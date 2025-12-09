# Contoso Sales Analysis SQL Project

## Introduction

Hi, I'm Thinh. I'm graduated from FPT University with the major of Software Engineering. During the process of learning and making web application projects as multiple roles, I ended up falling in love with data analysis. Although getting trained in web development, I decided to pursue a job in data field. So I've spent time for self-learning all these data analyst skills after my graduation. Hopefully, I'm going to have more chances to work with more realistic dataset. The main reason why I choose this role is to work in an insightful job position with cross-functional team.

## Overview

This is a popular public dataset provided by Microsoft ([contoso_100k.sql](/Data/contoso_100k.sql)). I've used this dataset for making analysis of customer behavior, retention, and lifetime value for an e-commerce company to improve customer retention and maximize revenue.

## Business Questions

1. **Customer Segmentation:** Who are our most valuable customers?
2. **Retention Analysis:** Which customers haven't purchased recently?

## Analysis Approach

### 0. Create a cohort analysis view for repetitive uses

- Joined the _sales_ table with _customer_ table
- Grouped by customerkey and orderdate then cleaning up basic information
- Calculated net revenue of each customer
- Identified their first purchase date and cohort year (first year purchase)

Query: [Create_cohort_analysis_view.sql](/Scripts/Create_cohort_analysis_view.sql)

![Cohort analysis view result](/images/image.png)

### 1. Customer Segmentation Analysis

- Categorized customers based on total lifetime value (LTV)
- Assigned customers to High, Mid, and Low-value segments
- Calculated key metrics: total revenue

Query: [Customer_segmentation.sql](/Scripts/Customer_segment.sql)

![Customer segmetation result](/images/image-1.png)

💡 **Insights:**

- High-value segment (25% of customers) drives 66% of revenue ($135.4M)
- Mid-value segment (50% of customers) generates 32% of revenue ($66.6M)
- Low-value segment (25% of customers) is only worth 2% of revenue ($4.3M)

**Business suggestions**

- High-Value (66% revenue): Offer premium membership program to VIP customers, as losing one customer significantly impacts revenue.

- Mid-Value (32% revenue): Create upgrade paths through personalized promotions.

### 2. Customer Retention

- Identified customers at risk of churning
- Analyzed last purchase patterns
- Calculated customer-specific metrics

Query: [Retention_analysis.sql](/Scripts/Retention_analysis.sql)

![Retention analysis result](/images/image-2.png)

💡 **Insights:**

- Cohort churn stabilizes at ~90% after 2-3 years, indicating a predictable long-term retention pattern.
- Retention rates are consistently low (8-10%) across all cohorts, suggesting retention issues are systemic rather than specific to certain years.

**Business suggestions:**

- Strengthen early engagement strategies to target the first 1-2 years with onboarding incentives, loyalty rewards, and personalized offers to improve long-term retention.
- Predict & preempt churn risk and use customer-specific warning indicators to proactively intervene with at-risk users before they lapse.

## Technical Details

- **Database:** PostgreSQL
- **Analysis Tools:** PostgreSQL, DBeaver, PGadmin

## Technical Process

- Install the contoso_100k.sql file to localhost PostgreSQL by PGadmin
- Creating project and making analysis all in DBeaver
- Upload project to Github repository
