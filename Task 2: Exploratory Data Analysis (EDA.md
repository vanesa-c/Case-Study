# Task 2: Exploratory Data Analysis (EDA)

## What data preparation steps will you implement?

### 1. Data Cleaning

Ensuring data quality before analysis and modeling.

#### a. Handle Missing Values
  - Impute missing values using the median or assign `"Unknown"` if missing.  

#### b. Remove Duplicates
- Ensure each job post is unique by checking the following attributes:
  - `time_of_post`
  - `latitude`
  - `longitude`
  - `category`

#### c. Convert Datatypes
- Ensure `time_of_post` is properly formatted as `YYYY-MM-DD HH:MM:SS`

#### d. Detect and Handle Outliers
- Identify extreme values in:
  - `estimated_size`
  - `number_of_tradies`
  - `number_of_impressions`
- Use statistical methods such as Z-score method
- One method to deal with outliers is to apply a maximum or minimum value, based on understanding of domain

### 2. Feature Engineering

Creating new features to enhance analysis and prediction accuracy.

#### a. Time-Based Features
- From `time_of_post` extract the hour, day, week 
- Create categorisation to identify whether time of posting is in peak hour, off-peak etc

#### b. Job Context & Historical Acceptance
To better understand job acceptance likelihood, enrich the dataset with historical insights and contextual factors:
- Benchmark acceptance rates: Calculate acceptance rates for similar jobs (same category) within the past 7, 30, and 90 days in the same region. This helps identify trends in job demand and tradie responsiveness over time.
- Urgency indicators: Incorporate an urgency flag based on the timeframe specified by the customer for job completion. Additionally, scan job titles and descriptions for keywords such as "urgent" or "emergency" to further refine urgency classification.
- Market competitiveness: Assess job supply and demand by counting the number of active job postings in the same category and region within the past X hours. A higher number of concurrent postings may indicate increased competition among jobs for tradie availability.
- Time-to-acceptance metric: Track how quickly jobs are accepted, providing insights into job desirability and response times across different job types and locations.


#### c. Location Based Features
- Enrich data with location-based features by doing reversed geocoding: Assign broader region labels (e.g., suburb, city, state)

  ---

## Which parameters influence if a job would be accepted?

#### 1. Time of Day & Day of the Week  
- Acceptance rates are highest in the afternoon and evening (40-50%), suggesting that tradies are more likely to accept jobs later in the day.  
- Morning and early morning have the lowest acceptance rates (8-15%), indicating that jobs posted earlier may take longer to be accepted.

#### 2. Job Category  
- Category 3 (39%) and Category 9 (29%) have the highest acceptance rates, likely due to higher demand or a more responsive workforce in those trades.  
- Category 5 (16%) has the lowest acceptance rate, suggesting labour shortages or lower interest in that type of job.

#### 3. Number of Impressions  
- Jobs with higher visibility tend to have better acceptance rates:  
  - 37% of jobs with over 5,000 impressions are accepted.  
  - In contrast, jobs with fewer than 500 impressions have an acceptance rate of just 14%.  
- This reinforces the idea that job visibility significantly impacts acceptance likelihood.

#### 4. Job Size  
- Medium-sized jobs have a higher acceptance rate (37%) compared to smaller jobs (16%), indicating that tradies may prioritise jobs with greater earning potential or more steady work.  
- Smaller jobs may be less attractive due to lower profitability.

#### 5. Location & Market Competition  
- Cities with a high concentration of jobs, such as Sydney and Melbourne, show better acceptance rates, suggesting that a more active workforce leads to higher job uptake.  
- This supports the idea that tradie availability and market competition influence acceptance rates.

---

## Can We Predict If a Job Will Be Accepted?

Yes, a predictive model can estimate job acceptance likelihood using techniques such as logistic regression, decision trees, or random forests. However, predictive accuracy may be limited by missing key factors.

#### Key Predictive Factors:
- Number of tradies available – Higher competition increases the likelihood of acceptance.  
- Job category – Some trades have a higher acceptance rate than others.  
- Number of impressions – Greater visibility improves acceptance probability.  
- Job size – Medium-sized jobs tend to be accepted more frequently.  
- Time of posting – Jobs posted later in the day are more likely to be accepted.


####  Limitations & Accuracy Constraints
We are missing additional variables that may influence predictive accuracy. We don't have information about macro economic factors, pricing or information about the job urgency and complexity.
- Tradie availability and workload – The dataset does not account for whether a tradie is already booked.
- Job urgency and complexity – Some jobs may require immediate attention, influencing acceptance rates.
- Pricing and payment terms – Tradies may reject jobs due to low budgets or payment concerns.
- Regional and seasonal trends – Market demand varies over time and across locations.


-----
## Which visualisations would best communicate the findings?
[View the Tableau Dashboard](https://public.tableau.com/views/HiPagesExploratoryDataAnalysis/HighPagesAcceptanceRateInfluences?:language=en-US&:sid=&:redirect=auth&:display_count=n&:origin=viz_share_link)


