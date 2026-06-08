WITH cte_tr1 AS (
SELECT 
  merchant_id,
  credit_card_id,
  transaction_timestamp,
  LEAD(transaction_timestamp) OVER(PARTITION BY merchant_id, credit_card_id ORDER BY merchant_id, credit_card_id) as next_p
FROM transactions 
), cte_tr2 AS (
SELECT 
    *
FROM cte_tr1
WHERE next_p IS NOT NULL 
)
SELECT * FROM cte_tr2
WHERE transaction_timestamp - next_p = 10;
