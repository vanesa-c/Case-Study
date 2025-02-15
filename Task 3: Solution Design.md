
A/B Testing Solution Design for Lead Utilisation at hipages

## 1.0 Introduction

Product is aiming to to increase lead utilisation by mandating four leads per job instead of the current three. To validate this hypothesis, we will design an A/B test using a frequentist approach to measure the impact of this change on key business and user experience metrics. This document outlines the necessary preparatory work, technical execution details, and analysis approach for the experiment.

## 2.0 Preparation
###  2.1.Define Key Metrics & Hypothesis
Hypothesis:
- Null Hypothesis (H₀): Mandating 4 leads per job does not result in higher lead utilisation.
- Alternative Hypothesis (H₁): Mandating 4 leads per job increases lead utilisation.

## 2.2Frquentist or Bayesian Approach

Given the context, a Frequentist approach is the best choice for this A/B test because the goal is to evaluate a one-time decision on whether mandating 4 leads per job improves lead utilisation. The experiment has clear success metrics (Lead Utilisation Rate, Job Acceptance Rate, Revenue Impact), and the company is interested in statistical significance before full rollout. A Frequentist approach allows us to fix a sample size, run the test, and make a binary decision based on whether the new approach significantly outperforms the current one.

This A/B test is also likely to have a large sample size because hipages operates as a marketplace with a high volume of job postings. Each job typically generates three leads, and with constant job postings across various trade categories and locations, a substantial amount of data will accumulate quickly. This ensures that even with a relatively modest effect size, the sample will be large enough to detect statistically significant differences. Since the test is randomising job postings, which are independent events, there is minimal risk of correlation between observations, and the test can reach a large sample size relatively easily.

A Bayesian approach, while more flexible, is better suited for continuous learning and real-time decision-making. If hipages wanted to dynamically adjust the number of leads per job based on observed engagement (e.g., using Thompson Sampling to assign more jobs to the better-performing condition), Bayesian methods would be a stronger fit. However, since the product manager wants a definitive answer before rollout rather than an ongoing adaptive experiment, the Frequentist method provides a more structured and interpretable framework for decision-making.

### 2.3 Define Primary and Secondary Metrics
Primary Metrics (Key Success Measures): Lead Utilisation Rate = (Leads Accepted / Leads Offered)

Tradie Engagement Rate = Percentage of tradies who claim at least one lead
Time to Job Acceptance = Time taken for a job to be claimed
Customer Satisfaction (CSAT) Score = Impact on customer experience

### 2.4 Randomisation & Stratification

- To ensure a fair comparison between the control group (3 leads per job) and the test group (4 leads per job), we will use stratified randomisation instead of simple randomisation. This approach ensures an even distribution of key factors that can impact lead utilisation, such as Trade category, Location & Job size. By first grouping jobs into these categories before randomly assigning them to either the control or test group, we achieve a balanced distribution. This prevents biases related to trade type, location, or job size from skewing the results.

- Implementation Methods:
  - Feature flag tools like Split.io or LaunchDarkly to manage controlled assignment.
    -Python-based stratified sampling, using functions such as numpy.random.choice.



## 3.0 Experiment Implementation

### 3.1 Set up feature toggling
- Update code to toggle the number of leads given to each job
- Ensure that the control and target group is tagged

### Data Tracking 
Ensure that the below data can be tracked eitehr through backend platform data or telemetry 
- Job Created: Trigger when a consumer posts a job.
- Lead Assigned: Log each lead assignment.
- Lead Claimed: Capture tradie acceptance.
- Job Fulfilled: Track when a consumer accepts a quote.
- Revenue Logged: Capture financial impact.
- Data Collection & Storage


## 4. Measurement & Analysis

### 4.1 Statistical Methodology

- Frequentist approach
- Confidence Intervals: Construct 95% confidence intervals around estimated effects.
- Z test: To detect whether change in the number of leads per job results in either an increase or a decrease in lead utilisation
- P-value interpretation: If p-value < 0.05, we reject the null hypothesis and conclude a statistically significant impact.

### 4.2 Expected Outcomes & Interpretation

| Outcome | Decision |
|---------|----------|
| **Lead Utilisation & Revenue Increase (p \< 0.05)** | Roll out the change permanently. |
| **No Significant Impact (p \> 0.05)** | Maintain the current allocation of 3 tradies per job. |
| **Negative Impact (Lead Utilisation Drop, p \< 0.05)** | Investigate reasons before reverting the change. |


### 4.3 Experiment Monitoring & Reporting
- Tableau dashboard to monitor results
