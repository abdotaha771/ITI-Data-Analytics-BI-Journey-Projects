import warnings
from pathlib import Path

import category_encoders as ce
import lightgbm as lgb
import matplotlib.pyplot as plt
import numpy as np
import pandas as pd
import seaborn as sns
from sklearn.compose import ColumnTransformer
from sklearn.compose import TransformedTargetRegressor
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error, mean_squared_error, r2_score
from sklearn.model_selection import KFold, cross_validate, train_test_split
from sklearn.pipeline import Pipeline
from sklearn.preprocessing import OneHotEncoder, RobustScaler
from xgboost import XGBRegressor

warnings.filterwarnings('ignore')

# ---------------------------------------------------------
# 1. DATA INGESTION & ROBUST DATA SANITIZATION
# ---------------------------------------------------------
DATA_PATH = Path(__file__).resolve().parent / 'Cleaned_UsedCarsSA_Dataset.xlsx'
df = pd.read_excel(DATA_PATH)

# Some rows store the real numeric price in Price_Numeric while Price may be text
# such as 'على السوم' or other non-numeric values; convert them to a usable target.
if 'Price_Numeric' in df.columns:
    df['Price'] = pd.to_numeric(df['Price'], errors='coerce').combine_first(
        pd.to_numeric(df['Price_Numeric'], errors='coerce')
    )
else:
    df['Price'] = pd.to_numeric(df['Price'], errors='coerce')

# Filter invalid prices (0 represents 'Negotiable')
df_clean = df[df['Price'].notna() & (df['Price'] > 0)].copy()

# Remove physical/temporal impossibilities & severe outliers
df_clean = df_clean[
    (df_clean['Mileage'] >= 100) & (df_clean['Mileage'] <= 800_000)
]
df_clean = df_clean[
    (df_clean['Year'] >= 1995) & (df_clean['Year'] <= 2026)
]  # Adjust to valid timeline
df_clean = df_clean[(df_clean['Engine_Size'] >= 0.8) & (df_clean['Engine_Size'] <= 8.0)]
df_clean.drop_duplicates(inplace=True)

# Drop redundant/leakage columns if present
cols_to_drop = ['Negotiable']
df_clean.drop(
    columns=[col for col in cols_to_drop if col in df_clean.columns],
    inplace=True,
    errors='ignore',
)

# ---------------------------------------------------------
# 2. ADVANCED FEATURE ENGINEERING
# ---------------------------------------------------------
CURRENT_YEAR = 2026
df_clean['Car_Age'] = (CURRENT_YEAR - df_clean['Year']).clip(lower=0)
df_clean['Mileage_Per_Year'] = df_clean['Mileage'] / (
    df_clean['Car_Age'] + 1
)  # +1 avoids division by zero
df_clean['Engine_Power_Ratio'] = df_clean['Engine_Size'] / (
    df_clean['Car_Age'] + 1
)

# ---------------------------------------------------------
# 3. TRAIN-TEST SPLIT & COLUMN IDENTIFICATION
# ---------------------------------------------------------
X = df_clean.drop(columns=['Price'])
y = df_clean['Price']

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.15, random_state=42, shuffle=True
)

high_cardinality_cols = ['Make', 'Type']
low_cardinality_cols = ['Origin', 'Gear_Type', 'Fuel_Type', 'Options', 'Region']
numeric_cols = [
    'Engine_Size',
    'Mileage',
    'Car_Age',
    'Mileage_Per_Year',
    'Engine_Power_Ratio',
]

# ---------------------------------------------------------
# 4. PREPROCESSING PIPELINE (ZERO DATA LEAKAGE)
# ---------------------------------------------------------
preprocessor = ColumnTransformer(
    transformers=[
        (
            'num',
            RobustScaler(),
            numeric_cols,
        ),  # Robust to remaining numerical outliers
        (
            'low_cat',
            OneHotEncoder(handle_unknown='ignore', sparse_output=False),
            low_cardinality_cols,
        ),
        (
            'high_cat',
            ce.TargetEncoder(smoothing=10.0),
            high_cardinality_cols,
        ),  # Prevents dimensional explosion
    ],
    remainder='drop',
)

# ---------------------------------------------------------
# 5. MODEL DEFINITIONS WITH TARGET TRANSFORMATION
# ---------------------------------------------------------
# Models trained on log1p(y) to solve skewness and optimize MAPE/R2
models = {
    'Random Forest': RandomForestRegressor(
        n_estimators=300, max_depth=16, random_state=42, n_jobs=-1
    ),
    'LightGBM': lgb.LGBMRegressor(
        n_estimators=500,
        learning_rate=0.03,
        num_leaves=31,
        subsample=0.8,
        colsample_bytree=0.8,
        random_state=42,
        verbose=-1,
    ),
    'XGBoost': XGBRegressor(
        n_estimators=500,
        learning_rate=0.03,
        max_depth=6,
        subsample=0.8,
        colsample_bytree=0.8,
        random_state=42,
        verbosity=0,
    ),
}

# ---------------------------------------------------------
# 6. K-FOLD CROSS VALIDATION & BENCHMARKING
# ---------------------------------------------------------
cv = KFold(n_splits=5, shuffle=True, random_state=42)
results = {}

print('--- 5-Fold Cross Validation Benchmarking ---')
for name, model in models.items():
  # TransformedTargetRegressor applies log1p on fit and expm1 on predict
  pipe = Pipeline([
      ('preprocessor', preprocessor),
      (
          'regressor',
          TransformedTargetRegressor(
              regressor=model, func=np.log1p, inverse_func=np.expm1
          ),
      ),
  ])

  cv_results = cross_validate(
      pipe,
      X_train,
      y_train,
      cv=cv,
      scoring=('r2', 'neg_mean_absolute_error'),
      n_jobs=-1,
  )

  r2_mean = cv_results['test_r2'].mean()
  mae_mean = -cv_results['test_neg_mean_absolute_error'].mean()
  results[name] = {'R2': r2_mean, 'MAE': mae_mean, 'Pipeline': pipe}

  print(f'{name:<15} | CV R² Score: {r2_mean:.4f} | CV MAE: {mae_mean:,.2f} SAR')

# ---------------------------------------------------------
# 7. FINAL EVALUATION ON UNSEEN HOLD-OUT TEST SET
# ---------------------------------------------------------
# Select best performing model based on CV R2
best_model_name = max(results, key=lambda k: results[k]['R2'])
best_pipeline = results[best_model_name]['Pipeline']

# Fit best pipeline on full training dataset
best_pipeline.fit(X_train, y_train)
y_pred = best_pipeline.predict(X_test)

r2_test = r2_score(y_test, y_pred)
mae_test = mean_absolute_error(y_test, y_pred)
rmse_test = np.sqrt(mean_squared_error(y_test, y_pred))

print('\n--- Final Evaluation (Hold-out Test Set) ---')
print(f'Winning Model   : {best_model_name}')
print(f'Test R² Score   : {r2_test:.4f}')
print(f'Test MAE        : {mae_test:,.2f} SAR')
print(f'Test RMSE       : {rmse_test:,.2f} SAR')

# ---------------------------------------------------------
# 8. RESIDUAL DIAGNOSTICS
# ---------------------------------------------------------
plt.figure(figsize=(12, 5))

# Actual vs Predicted
plt.subplot(1, 2, 1)
sns.scatterplot(x=y_test, y=y_pred, alpha=0.5, color='teal')
plt.plot(
    [y_test.min(), y_test.max()],
    [y_test.min(), y_test.max()],
    'r--',
    linewidth=2,
)
plt.xlabel('Actual Price (SAR)')
plt.ylabel('Predicted Price (SAR)')
plt.title(f'Actual vs. Predicted ({best_model_name})')

# Residual Distribution
plt.subplot(1, 2, 2)
residuals = y_test - y_pred
sns.histplot(residuals, kde=True, bins=40, color='indigo')
plt.axvline(0, color='red', linestyle='--')
plt.xlabel('Prediction Error (Residuals in SAR)')
plt.title('Residual Distribution')

plt.tight_layout()
plt.show()