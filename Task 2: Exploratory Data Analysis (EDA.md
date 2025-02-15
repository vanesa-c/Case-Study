# 1. What Data Preparation Steps Will You Implement?

## 1. Data Cleaning

Ensuring data quality before analysis and modeling.

### a. Handle Missing Values
- **Latitude & Longitude**: Fill missing values using regional averages.
- **Number of Tradies**:  
  - Impute missing values using the median.  
  - Alternatively, set a default minimum value.  
- **Category**:  
  - Assign `"Unknown"` if missing.  
  - Alternatively, use mode imputation.

### b. Remove Duplicates
- Ensure each job post is unique by checking the following attributes:
  - `time_of_post`
  - `latitude`
  - `longitude`
  - `category`

### c. Convert Datatypes
- Ensure `time_of_post` is properly formatted as `YYYY-MM-DD HH:MM:SS` for accurate time-based analysis.

### d. Detect and Handle Outliers
- Identify extreme values in:
  - `estimated_size`
  - `number_of_tradies`
  - `number_of_impressions`
- Use statistical methods such as **Z-score method**

---

## 2. Feature Engineering

Creating new features to enhance analysis and prediction accuracy.

### a. Time-Based Features
- Extract:
  - `hour_of_day`
  - `day_of_week`
  - `weekend_flag`  
  from `time_of_post` to identify trends.
- Create a **peak hour flag**:  
  - `1` for jobs posted between **8 AM - 5 PM**.  
  - `0` otherwise.

### b. Supply & Demand Features
- **Tradie availability ratio**:  
- **Tradie competition score**:  


### c. Job Value & Complexity Features
- Categorize `estimated_size` into **small, medium, large** using percentiles.
- Compute **revenu
