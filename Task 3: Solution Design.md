# A/B Testing Solution Design for Lead Utilisation at hipages

## 1.0 Introduction

The product team aims to increase lead utilisation by mandating four leads per job instead of the current three. To validate this hypothesis, we will design an A/B test using a Frequentist approach to measure the impact of this change on key business and user experience metrics. This document outlines the necessary preparatory work, technical execution details, and analysis approach for the experiment.

---

## 2.0 Preparation

### 2.1 Define Key Metrics & Hypothesis

#### Hypothesis:
- Null Hypothesis (H₀): Mandating four leads per job does not result in higher lead utilisation.
- Alternative Hypothesis (H₁): Mandating four leads per job increases lead utilisation.

### 2.2 Frequentist vs Bayesian Approach

A frequentist approach is recommended for this analysis based on the following factors:  

#### 1. Clear, One-Time Decision  
- The primary goal is to determine whether mandating four leads per job improves lead utilisation before rolling it out fully.  
- Frequentist methods provide a definitive "yes" or "no" answer based on hypothesis testing, making them well-suited for a one-time decision rather than an ongoing adjustment.  

#### 2.Lack of historical data
- Given that this is hipages' first initiative to increase lead counts, there is a lack of prior internal data or established benchmarks to inform the expected outcomes. 
- Frequentist approaches do not rely on prior assumptions and instead derive conclusions directly from the observed data. 

#### 3. Large Sample Size Availability  
- Given the large volume of job postings and leads, we can define a fixed sample size in advance, ensuring an unbiased test.  
- Frequentist methods work well when a sufficiently large dataset is available, eliminating the need for continuous adjustments mid-experiment.  


#### Why Not Bayesian?  
- Better for adaptive decision-making: Bayesian methods are more suitable when decisions need to be continuously updated as new data arrives rather than making a single, definitive decision.  
- Requires prior distributions: Bayesian models require assumptions about prior probabilities, which can introduce bias if not well-informed.  
- More useful for low-data scenarios: Bayesian methods are ideal when data is limited and we need to incorporate prior knowledge to improve estimations.  



### 2.3 Define Primary and Secondary Metrics

#### Primary Metric (Key Success Measure):
- Lead Utilisation Rate = (Leads Accepted / Leads Offered)

#### Secondary Metrics:
- Time to Job Acceptance = Time taken for a job to be claimed
- Customer Satisfaction (CSAT) Score = Impact on customer experience

### 2.4 Randomisation & Stratification

To ensure a fair comparison between the control group (three leads per job) and the test group (four leads per job), we will use stratified randomisation instead of simple randomisation.

#### Implementation Methods:
- Feature flag tools (e.g., `Split.io`, `LaunchDarkly`) for controlled assignment
- Python-based stratified sampling, using functions such as `numpy.random.choice`

### 2.5 Sample Size Calculation: Power Analysis & Minimum Detectable Effect (MDE)

To determine the required sample size, we will conduct a power analysis to ensure the experiment is sufficiently powered to detect a meaningful effect.

- Significance Level (α): 0.05 (5%)  
- Power (1 - β): 0.8 (80%)  
- Baseline Lead Utilisation Rate: X% (To be determined from historical data)  
- Minimum Detectable Effect (MDE): Y% (Smallest meaningful increase in lead utilisation)  

---

## 3.0 Experiment Implementation

### 3.1 Set Up Feature Toggling
- Update code to toggle the number of leads assigned per job
- Ensure that control and test groups are correctly tagged

### 3.2 Data Tracking
Ensure that the following events are tracked, either via backend platform data or telemetry:

- Job Created: Triggered when a consumer posts a job.
- Lead Assigned: Logs each lead assignment.
- Lead Claimed: Captures tradie acceptance.
- Job Fulfilled: Tracks when a consumer accepts a quote.
- Revenue Logged: Captures financial impact.

---

## 4.0 Measurement & Analysis

### 4.1 Statistical Methodology

- Frequentist approach
- Confidence Intervals: Construct 95% confidence intervals around estimated effects.
- Z-test: To determine whether changing the number of leads per job results in an increase or decrease in lead utilisation.
- P-value interpretation:
  - If p-value < 0.05, reject the null hypothesis and conclude a statistically significant impact.
  - If p-value > 0.05, fail to reject the null hypothesis (i.e., no significant effect detected).

### 4.2 Expected Outcomes & Decision Framework

| Outcome | Decision |
|------------|-------------|
| Lead Utilisation & Revenue Increase (p < 0.05) | Roll out the change permanently. |
| No Significant Impact (p > 0.05) | Maintain the current allocation of three tradies per job. |
| Negative Impact (Lead Utilisation Drop, p < 0.05) | Investigate reasons before reverting the change. |

### 4.3 Experiment Monitoring & Reporting
- Tableau dashboard to monitor real-time results.
