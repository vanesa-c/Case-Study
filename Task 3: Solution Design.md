# A/B Testing Solution Design for Lead Utilisation at hipages

## 1.0 Introduction

The product team aims to increase lead utilisation by mandating four leads per job instead of the current three. To validate this hypothesis, we will design an A/B test using a Frequentist approach to measure the impact of this change on key business and user experience metrics. This document outlines the necessary preparatory work, technical execution details, and analysis approach for the experiment.

---

## 2.0 Preparation

### 2.1 Define Key Metrics & Hypothesis

#### Hypothesis:
- **Null Hypothesis (H₀):** Mandating four leads per job does not result in higher lead utilisation.
- **Alternative Hypothesis (H₁):** Mandating four leads per job increases lead utilisation.

### 2.2 Frequentist vs Bayesian Approach

A **Frequentist approach** is the preferred choice for this A/B test because the goal is to evaluate a one-time decision on whether mandating four leads per job improves lead utilisation. The experiment has clearly defined success metrics (**Lead Utilisation Rate, Job Acceptance Rate, Revenue Impact**), and the company seeks statistical significance before a full rollout.

This approach allows us to fix a sample size, conduct the test, and make a binary decision based on whether the new approach significantly outperforms the current one.

Given **hipages** operates as a marketplace with a high volume of job postings, a large sample size is expected. Each job typically generates three leads, and with continuous job postings across various trade categories and locations, the dataset will accumulate quickly. This ensures that even a modest effect size can be detected as statistically significant. Since the test randomises job postings (which are independent events), the risk of correlation between observations is minimal, making it feasible to reach a large sample size efficiently.

A **Bayesian approach**, while more flexible, is better suited for continuous learning and real-time decision-making. If **hipages** wanted to dynamically adjust the number of leads per job based on observed engagement (e.g., using **Thompson Sampling** to allocate more jobs to the better-performing condition), Bayesian methods would be a stronger fit. However, since the **product manager seeks a definitive answer before rollout** rather than an adaptive experiment, the Frequentist approach provides a structured and interpretable framework for decision-making.

### 2.3 Define Primary and Secondary Metrics

#### **Primary Metrics (Key Success Measures):**
- **Lead Utilisation Rate** = (Leads Accepted / Leads Offered)
- **Tradie Engagement Rate** = Percentage of tradies who claim at least one lead
- **Time to Job Acceptance** = Time taken for a job to be claimed
- **Customer Satisfaction (CSAT) Score** = Impact on customer experience

### 2.4 Randomisation & Stratification

To ensure a **fair comparison** between the control group (three leads per job) and the test group (four leads per job), we will use **stratified randomisation** instead of simple randomisation. This approach ensures an even distribution of key factors that can impact lead utilisation, such as:

- **Trade category**
- **Location**
- **Job size**

By first grouping jobs into these categories before randomly assigning them to either the control or test group, we achieve a **balanced distribution**. This mitigates biases related to trade type, location, or job size that could otherwise skew results.

#### **Implementation Methods:**
- **Feature flag tools** (e.g., `Split.io`, `LaunchDarkly`) for controlled assignment
- **Python-based stratified sampling**, using functions such as `numpy.random.choice`

### 2.5 Sample Size Calculation: Power Analysis & Minimum Detectable Effect (MDE)

To determine the required sample size, we will conduct a **power analysis** to ensure the experiment is sufficiently powered to detect a meaningful effect.

- **Significance Level (α):** 0.05 (5%)  
- **Power (1 - β):** 0.8 (80%)  
- **Baseline Lead Utilisation Rate:** X% (To be determined from historical data)  
- **Minimum Detectable Effect (MDE):** Y% (Smallest meaningful increase in lead utilisation)  
- **Effect Size Calculation:** Using **Cohen’s h** or standard proportion tests  

The **MDE** represents the smallest **real-world impact** worth detecting. If the detected effect is smaller than the MDE, the change may not be practically significant, even if it is statistically significant.

**Sample Size Calculation Methodology:**
- Use a **two-sample proportion test** (e.g., `statsmodels.stats.power.zt_ind_solve_power` in Python).
- Ensure **sufficient job postings** are allocated to both test and control groups based on the power analysis results.
- Validate assumptions using **historical job posting data**.

---

## 3.0 Experiment Implementation

### 3.1 Set Up Feature Toggling
- Update code to toggle the number of leads assigned per job
- Ensure that control and test groups are correctly tagged

### 3.2 Data Tracking
Ensure that the following events are tracked, either via backend platform data or telemetry:

- **Job Created:** Triggered when a consumer posts a job.
- **Lead Assigned:** Logs each lead assignment.
- **Lead Claimed:** Captures tradie acceptance.
- **Job Fulfilled:** Tracks when a consumer accepts a quote.
- **Revenue Logged:** Captures financial impact.

---

## 4.0 Measurement & Analysis

### 4.1 Statistical Methodology

- **Frequentist approach**
- **Confidence Intervals:** Construct 95% confidence intervals around estimated effects.
- **Z-test:** To determine whether changing the number of leads per job results in an increase or decrease in lead utilisation.
- **P-value interpretation:**
  - If **p-value < 0.05**, reject the null hypothesis and conclude a statistically significant impact.
  - If **p-value > 0.05**, fail to reject the null hypothesis (i.e., no significant effect detected).

### 4.2 Expected Outcomes & Decision Framework

| **Outcome** | **Decision** |
|------------|-------------|
| **Lead Utilisation & Revenue Increase (p < 0.05)** | Roll out the change permanently. |
| **No Significant Impact (p > 0.05)** | Maintain the current allocation of three tradies per job. |
| **Negative Impact (Lead Utilisation Drop, p < 0.05)** | Investigate reasons before reverting the change. |

### 4.3 Experiment Monitoring & Reporting
- **Tableau dashboard** to monitor real-time results.
