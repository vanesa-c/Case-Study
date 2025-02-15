# Data Cleaning & Feature Engineering

## 1. Data Cleaning

Ensuring data quality before analysis and modeling.

### Handle Missing Values
- **Latitude & Longitude**: Fill missing values using regional averages.
- **Number of Tradies**:  
  - Impute missing values using the median.  
  - Alternatively, set a default minimum value.  
- **Category**:  
  - Assign `"Unknown"` if missing.  
  - Alternatively, use mode imputation.

### Remove Duplicates
- Ensure each job post is unique by checking the following attributes:
  - `time_of_post`
  - `latitude`
  - `longitude`
  - `category`

### Convert Datatypes
- Ensure `time_of_post` is properly formatted as `YYYY-MM-DD HH:MM:SS` for accurate time-based analysis.

### Detect and Handle Outliers
- Identify extreme values in:
  - `estimated_size`
  - `number_of_tradies`
  - `number_of_impressions`
- Use statistical methods (e.g., IQR, Z-score) to detect and handle anomalies.

---

## 2. Feature Engineering

Creating new features to enhance analysis and prediction accuracy.

### Time-Based Features
- Extract:
  - `hour_of_day`
  - `day_of_week`
  - `weekend_flag`  
  From `time_of_post` to identify trends.
- Create a **peak hour flag**:  
  - `1` for jobs posted between **8 AM - 5 PM**.  
  - `0` otherwise.

### Supply & Demand Features
- **Tradie availability ratio**:  
  ```math
  tradie_availability = \frac{number\_of\_tradies}{number\_of\_impressions}
