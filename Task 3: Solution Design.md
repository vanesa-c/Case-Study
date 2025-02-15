



###  1.Define Key Metrics & Hypothesis
Hypothesis:
- Null Hypothesis (H₀): Mandating 4 leads per job does not result in higher lead utilisation.
- Alternative Hypothesis (H₁): Mandating 4 leads per job increases lead utilisation.

## Frquentist or Bayesian Approach

Given the context, a Frequentist approach is the best choice for this A/B test because the goal is to evaluate a one-time decision on whether mandating 4 leads per job improves lead utilisation. The experiment has clear success metrics (Lead Utilisation Rate, Job Acceptance Rate, Revenue Impact), and the company is interested in statistical significance before full rollout. A Frequentist approach allows us to fix a sample size, run the test, and make a binary decision based on whether the new approach significantly outperforms the current one.

This A/B test is also likely to have a large sample size because hipages operates as a marketplace with a high volume of job postings. Each job typically generates three leads, and with constant job postings across various trade categories and locations, a substantial amount of data will accumulate quickly. This ensures that even with a relatively modest effect size, the sample will be large enough to detect statistically significant differences. Since the test is randomising job postings, which are independent events, there is minimal risk of correlation between observations, and the test can reach a large sample size relatively easily.

A Bayesian approach, while more flexible, is better suited for continuous learning and real-time decision-making. If hipages wanted to dynamically adjust the number of leads per job based on observed engagement (e.g., using Thompson Sampling to assign more jobs to the better-performing condition), Bayesian methods would be a stronger fit. However, since the product manager wants a definitive answer before rollout rather than an ongoing adaptive experiment, the Frequentist method provides a more structured and interpretable framework for decision-making.


### 2. Metrics
Primary Metrics (Key Success Measures): Lead Utilisation Rate = (Leads Accepted / Leads Offered)

Tradie Engagement Rate = Percentage of tradies who claim at least one lead
Time to Job Acceptance = Time taken for a job to be claimed
Customer Satisfaction (CSAT) Score = Impact on customer experience

###  3. Determine Experiment Design & Sample Size
- A/B Testing Type: Frequentist approach (Classical Hypothesis Testing) or Bayesian approach
- Randomisation Strategy:
  - Jobs are randomly assigned to either control (3 leads per job) or treatment (4 leads per job)
  - Stratified randomisation may be used to balance by job category, location, and time of posting
- Power Analysis
- Use historical data to determine baseline metrics and calculate the minimum detectable effect (MDE)
- Sample size require Set confidence level = 95% and power = 80%

