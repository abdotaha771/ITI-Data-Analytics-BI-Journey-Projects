import seaborn as sns
import matplotlib.pyplot as plt

# 1. Load Dataset
df = sns.load_dataset('titanic')

# 2. Measures of Central Tendency & Dispersion for 'fare'
fare = df['fare'].dropna()

mean_fare = fare.mean()
median_fare = fare.median()
mode_fare = fare.mode()[0]
range_fare = fare.max() - fare.min()

# Population (ddof=0) vs Sample (ddof=1)
var_pop = fare.var(ddof=0)
var_sample = fare.var(ddof=1)

std_pop = fare.std(ddof=0)
std_sample = fare.std(ddof=1)

print(f"Mean: {mean_fare:.2f} | Median: {median_fare:.2f} | Mode: {mode_fare:.2f}")
print(f"Range: {range_fare:.2f}")
print(f"Variance (Pop): {var_pop:.2f} | Variance (Sample): {var_sample:.2f}")
print(f"Std Dev (Pop): {std_pop:.2f} | Std Dev (Sample): {std_sample:.2f}")

# 3. Visualizations
plt.figure(figsize=(15, 4))

# Bar Chart
plt.subplot(1, 3, 1)
sns.countplot(data=df, x='pclass', palette='viridis')
plt.title('Passengers per Class')

# Histogram
plt.subplot(1, 3, 2)
sns.histplot(df['age'].dropna(), bins=20, kde=True, color='skyblue')
plt.title('Age Distribution')

# Box Plot
plt.subplot(1, 3, 3)
sns.boxplot(data=df, x='pclass', y='fare', palette='Set2')
plt.title('Fare by Passenger Class')

plt.tight_layout()
plt.show()