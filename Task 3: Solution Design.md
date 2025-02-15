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

A Frequentist approach is the preferred choice for this A/B test because the goal is to evaluate a one-time decision on whether mandating four leads per job improves lead utilisation. The experiment has clearly defined success metrics (Lead Utilisation Rate, Job Acceptance Rate, Revenue Impact), and the company seeks statistical significance before a full rollout.

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
