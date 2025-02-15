# What Data Preparation Steps Will You Implement?

## 1. Data Cleaning

Ensuring data quality before analysis and modeling.

### a. Handle Missing Values
- Latitude & Longitude: Fill missing values using regional averages.
- Number of Tradies:  
  - Impute missing values using the median.  
  - Alternatively, set a default minimum value.  
- Category:  
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
- Use statistical methods such as Z-score method

## 2. Feature Engineering

Creating new features to enhance analysis and prediction accuracy.

### a. Time-Based Features
- From `time_of_post` extract the hour, day, week 
- Create categorisation to identify whether time of posting is in peak hour, off-peak etc

### b. Supply & Demand Features
- Tradie availability ratio:  
- Tradie competition score: 


### c. Job Value Categorisation
- Categorize `estimated_size` into small, medium, large using percentiles.
- Identify 'high-value jobs' where `estimated_size` is in the top 20%.

  ---

# Which parameters influence if a job would be accepted?

### 1. Number of Tradies Available
- Jobs in areas with a higher number of tradies tend to be accepted more frequently. For example, locations with over 5,000 tradies show an acceptance rate of ~13%, while those with fewer tradies have lower acceptance rates. This suggests increased competition leads to higher job uptake.

### 2. Job Category 
- Some job categories are more likely to be accepted than others. Categories 3 and 7, for instance, have a higher acceptance rate compared to other categories, indicating certain trades may be in higher demand or have a more engaged workforce.

### 3. Number of Impressions 
- Jobs with more than 1,000 impressions have a noticeably higher acceptance rate compared to those with fewer views. This suggests that visibility plays a crucial role in whether a job is picked up.

### 4. Estimated Job Size 
- Medium-sized jobs tend to have a higher acceptance rate than small ones. This indicates that tradies may prefer jobs with greater earning potential or that take more time to complete.

---

# Can We Predict If a Job Will Be Accepted?

Yes, a predictive model can be developed using logistic regression or machine learning techniques (e.g., decision trees, random forests) to estimate whether a job will be accepted. However, with the available data alone, predictive accuracy is unlikely to be high due to missing key factors.

### Key Predictive Factors
- Number of tradies available – Higher competition increases the likelihood of acceptance.
- Job category – Some trades have a higher acceptance rate than others.
- Number of impressions – Greater visibility improves acceptance probability.
- Job size – Medium-sized jobs tend to be accepted more frequently.
- Time of posting – Jobs posted during early morning hours see higher acceptance rates.


###  Limitations & Accuracy Constraints
We are missing additional variables that may influence predictive accuracy. We don;t have information about macro economic factors, pricing or information about the job urgency and complexity.
- Tradie availability and workload – The dataset does not account for whether a tradie is already booked.
- Job urgency and complexity – Some jobs may require immediate attention, influencing acceptance rates.
- Pricing and payment terms – Tradies may reject jobs due to low budgets or payment concerns.
- Regional and seasonal trends – Market demand varies over time and across locations.


-----
