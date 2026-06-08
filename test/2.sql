WITH cte_tr1 AS (
SELECT 
  merchant_id,
  credit_card_id,
  transaction_timestamp,
  LEAD(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id, amount ORDER BY transaction_timestamp) as next_p
FROM transactions 
), cte_tr2 AS (
SELECT 
    *
FROM cte_tr1
WHERE next_p IS NOT NULL 
)
SELECT
  COUNT(*) as payment_count
FROM cte_tr2
WHERE next_p - transaction_timestamp  <= INTERVAL '10 MINUTES';
