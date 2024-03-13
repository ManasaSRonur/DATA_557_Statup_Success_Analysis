# Exploratory Data Analysis on Startup Founders and their Academic Backgrounds

This question aims to analyze the relationship between the academic backgrounds of startup founders and the success of their ventures. By combining data from various sources, including details about founders, their educational degrees, and startup performance metrics, we aim to uncover valuable insights.

## Data Preprocessing

The analysis begins by cleaning and merging multiple datasets, including information on founders, their relationships, academic degrees, and startup performance metrics. Relevant columns are selected, and data is filtered and transformed to facilitate further analysis.

Some key steps in data preprocessing include:

- Handling missing values by dropping rows with NaN values in critical columns
- Categorizing degree types into broader categories (e.g., Bachelor's in STEM, Master's in STEM, PhD)
- Merging datasets based on common identifiers (e.g., person IDs, startup names)

## Exploratory Data Analysis

The exploratory data analysis phase involves various techniques to gain insights into the dataset. Some of the analyses performed include:

1. **Birthplace Analysis**: Examining the distribution of founders' birthplaces and identifying the top locations.
2. **Degree Type Analysis**: Exploring the distribution of degree types among the founders, including visualizations using bar plots.
3. **Ivy League Analysis**: Investigating the representation of founders from Ivy League institutions compared to non-Ivy League institutions.
4. **Time-based Analysis**: Analyzing the distribution of graduates across different time periods, such as decades, to identify potential trends.

## Final Analysis: STEM Degrees and Startup Success

The final analysis focuses on understanding the relationship between having a STEM (Science, Technology, Engineering, and Mathematics) degree and startup success. The steps involved are as follows:

1. **Data Filtering**: Filtering the dataset to include only startups with a "Successful" or "Unsuccessful" status, excluding those marked as "Potentially Successful."
2. **Contingency Table Creation**: Constructing a contingency table by cross-tabulating the degree category (STEM or non-STEM) and startup success status.
3. **Chi-Square Test**: Performing a chi-square test of independence to determine if there is a significant association between having a STEM degree and startup success.
4. **Result Interpretation**: Interpreting the chi-square test results based on the p-value and a predefined significance level (α = 0.05).
5. **Visualization**: Visualizing the contingency table using a stacked bar plot to observe the distribution of startup success based on personnel with or without STEM degrees.

Through this comprehensive analysis, we aim to gain valuable insights into the potential influence of founders' academic backgrounds, particularly STEM degrees, on the success of their startup ventures.