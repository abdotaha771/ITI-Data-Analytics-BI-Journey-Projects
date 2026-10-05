from pathlib import Path

import pandas as pd

DATA_PATH = Path(__file__).resolve().parent / "data.xlsx"
SHEET_NAME = "data clean (2)"
TARGET_COLUMN = "commute_minutes"


def describe_commute(series: pd.Series) -> dict:
    s = series.dropna().astype(float)
    q1 = s.quantile(0.25)
    q3 = s.quantile(0.75)
    iqr = q3 - q1
    lower_fence = q1 - 1.5 * iqr
    upper_fence = q3 + 1.5 * iqr

    return {
        "count": int(s.count()),
        "mean_minutes": round(float(s.mean()), 2),
        "median_minutes": round(float(s.median()), 2),
        "mode_minutes": [round(float(x), 2) for x in s.mode().tolist()],
        "min_minutes": round(float(s.min()), 2),
        "max_minutes": round(float(s.max()), 2),
        "range_minutes": round(float(s.max() - s.min()), 2),
        "std_dev_minutes": round(float(s.std()), 2),
        "q1_minutes": round(float(q1), 2),
        "q3_minutes": round(float(q3), 2),
        "iqr_minutes": round(float(iqr), 2),
        "lower_fence_minutes": round(float(lower_fence), 2),
        "upper_fence_minutes": round(float(upper_fence), 2),
        "outlier_count": int(((s < lower_fence) | (s > upper_fence)).sum()),
        "outlier_count_above_upper_fence": int(((s > upper_fence)).sum()),
        "coefficient_of_variation_pct": round(float((s.std() / s.mean()) * 100), 2)
    }


def print_summary(title: str, stats: dict) -> None:
    print(f"\n{title}")
    for key, value in stats.items():
        print(f"- {key}: {value}")


if __name__ == "__main__":
    df = pd.read_excel(DATA_PATH, sheet_name=SHEET_NAME)
    commute = df[TARGET_COLUMN].dropna().astype(float)

    overall = describe_commute(commute)
    print_summary("C1. Headline number for commute_minutes", overall)

    q1 = commute.quantile(0.25)
    q3 = commute.quantile(0.75)
    iqr = q3 - q1
    upper_fence = q3 + 1.5 * iqr
    cairo_commute = df[df["branch"] == "Cairo"][TARGET_COLUMN].dropna().astype(float)
    cairo_above_upper_fence = int((cairo_commute > upper_fence).sum())
    overall["cairo_students_above_combined_upper_fence"] = cairo_above_upper_fence
    print(f"\nCairo students above the overall upper fence ({upper_fence:.2f} minutes): {cairo_above_upper_fence}")

    branch_summary = (
        df.groupby("branch", dropna=True)[TARGET_COLUMN]
        .agg(["count", "mean", "median", "std"])
        .reset_index()
        .sort_values("mean", ascending=False)
    )
    print("\nC4. Summary by branch")
    print(branch_summary.round(2).to_string(index=False))

    print("\nC2. Which average to report?")
    print(f"Overall mean excluding Cairo: {df[df['branch'] != 'Cairo'][TARGET_COLUMN].dropna().mean():.2f} minutes")
    print(f"Overall median excluding Cairo: {df[df['branch'] != 'Cairo'][TARGET_COLUMN].dropna().median():.2f} minutes")
    print(f"Overall mean including Cairo: {commute.mean():.2f} minutes")
    print(f"Overall median including Cairo: {commute.median():.2f} minutes")

    print("\nC3. Spread and why the average alone is a lie")
    q1 = commute.quantile(0.25)
    q3 = commute.quantile(0.75)
    iqr = q3 - q1
    print(f"Q1: {q1:.2f} minutes")
    print(f"Q3: {q3:.2f} minutes")
    print(f"IQR: {iqr:.2f} minutes")
    print(f"1.5*IQR fences: [{(q1 - 1.5 * iqr):.2f}, {(q3 + 1.5 * iqr):.2f}] minutes")
    print(f"Outliers beyond those fences: {((commute < q1 - 1.5 * iqr) | (commute > q3 + 1.5 * iqr)).sum()} students")

    print("\nPolicy threshold counts")
    for threshold in (60, 90):
        qualifying_count = int((commute > threshold).sum())
        qualifying_pct = (qualifying_count / commute.count()) * 100
        print(
            f"More than {threshold} minutes: {qualifying_count} of "
            f"{commute.count()} ({qualifying_pct:.1f}%)"
        )

    print("\nInterpretation:")
    print("- The commute distribution is right-skewed and contains a long tail.")
    print("- Mean is pulled upward by a small number of very long commutes.")
    print("- Median is more representative of a 'typical' student commute.")
    print("- Cairo has the longest average commute and is the main reason the overall mean is high.")
