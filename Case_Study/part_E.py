import pandas as pd
from pathlib import Path

DATA_PATH = Path(__file__).resolve().parent / "data.xlsx"
SHEET_NAME = "data clean (2)"


def get_branch_distribution():
    df = pd.read_excel(DATA_PATH, sheet_name=SHEET_NAME)
    branch_counts = df.groupby("branch", dropna=True).size()
    total = branch_counts.sum()
    expected_per_branch = total / len(branch_counts)

    print("\nBRANCH DISTRIBUTION:")
    print("=" * 60)
    for branch in branch_counts.index:
        actual = branch_counts[branch]
        pct = (actual / total) * 100
        diff = actual - expected_per_branch
        print(f"{branch:15} {actual:3} ({pct:5.1f}%)  Expected: {expected_per_branch:5.1f}, Diff: {diff:+6.1f}")


def get_missing_data_analysis():
    df = pd.read_excel(DATA_PATH, sheet_name=SHEET_NAME)

    print("\nMISSING DATA ANALYSIS:")
    print("=" * 60)

    missing_counts = df.isnull().sum().sort_values(ascending=False)
    if missing_counts.max() == 0:
        print("No missing values found")
        return

    most_missing_col = missing_counts.idxmax()
    print(f"\nMost missing column: {most_missing_col}")
    print(f"Total missing: {missing_counts.max()} / {len(df)} ({100*missing_counts.max()/len(df):.1f}%)")

    print(f"\nMissingness by branch for '{most_missing_col}':")
    print("-" * 60)
    missing_by_branch = df.groupby("branch", dropna=True)[most_missing_col].apply(
        lambda x: (x.isnull().sum(), len(x))
    ).apply(pd.Series)
    missing_by_branch.columns = ['Missing', 'Total']
    missing_by_branch['Percent'] = (missing_by_branch['Missing'] / missing_by_branch['Total'] * 100).round(1)
    print(missing_by_branch)

    max_pct = missing_by_branch['Percent'].max()
    min_pct = missing_by_branch['Percent'].min()
    print(f"\nConcentration: {min_pct}% to {max_pct}%")
    print(f"Ratio: {max_pct/min_pct if min_pct > 0 else 'inf':.2f}x")

    if max_pct > (min_pct * 1.5):
        print("[CONCENTRATED] Significantly different across branches")
    else:
        print("[SPREAD EVENLY] Similar across branches")


def get_commute_statistics():
    df = pd.read_excel(DATA_PATH, sheet_name=SHEET_NAME)

    print("\nCOMMUTE STATISTICS BY BRANCH:")
    print("=" * 60)

    commute_stats = df.groupby("branch", dropna=True)["commute_minutes"].agg(
        ["count", "mean", "median", "std"]
    ).round(2)
    print(commute_stats)

    overall_mean = df["commute_minutes"].dropna().mean()
    overall_median = df["commute_minutes"].dropna().median()
    print(f"\nOverall mean: {overall_mean:.2f} minutes")
    print(f"Overall median: {overall_median:.2f} minutes")


if __name__ == "__main__":
    print("\n" + "="*60)
    print("PART E DATA ANALYSIS UTILITY")
    print("="*60)

    get_branch_distribution()
    get_missing_data_analysis()
    get_commute_statistics()

    print("\n" + "="*60)
