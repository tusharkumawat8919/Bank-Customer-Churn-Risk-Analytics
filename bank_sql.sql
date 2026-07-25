
-- ==================================================================================
---------      PROJECT: Bank Customer Churn & Risk Analytics Pipeline     -----------
-- ==================================================================================


CREATE TABLE bank 
    (customer_id INT PRIMARY KEY,
    credit_score INT,
    country VARCHAR(50),
    gender VARCHAR(20),
    age INT,
    tenure INT,
    balance NUMERIC(15, 2),
    products_number INT,
    credit_card INT,
    active_member INT,
    estimated_salary NUMERIC(15, 2),
    churn INT);


     select * from bank


--q1--Customer Attrition & Baseline Churn Rate Quantification
      SELECT churn, COUNT(*) as total_customers, 
      ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
      FROM bank 
      GROUP BY churn;

--q2--Geographical Loss Analysis & Branch Performance Metrics
      SELECT country, COUNT(*) as total_churned 
      FROM bank 
      WHERE churn = 1 
      GROUP BY country 
      ORDER BY total_churned DESC;

--q3--High-Value Customer Financial Health & Account Balance Risk Assessment 
      SELECT churn, ROUND(AVG(balance), 2) as avg_balance 
      FROM bank 
      GROUP BY churn;

--q4--Customer Segmentation
      WITH CustomerRisk AS 
      (SELECT customer_id, country, credit_score, balance, churn,
           CASE 
               WHEN credit_score < 600 THEN 'High Risk'
               WHEN credit_score BETWEEN 600 AND 700 THEN 'Medium Risk'
               ELSE 'Low Risk'
           END as credit_risk_segment
      FROM bank)

      SELECT credit_risk_segment, 
      COUNT(*) as total_customers,
      SUM(churn) as churned_customers,
      ROUND(SUM(churn) * 100.0 / COUNT(*), 2) as churn_rate_percentage
      FROM CustomerRisk
      GROUP BY credit_risk_segment
      ORDER BY churn_rate_percentage DESC;










