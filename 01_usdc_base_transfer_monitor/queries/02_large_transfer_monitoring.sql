SELECT 
    block_date AS date,

    COUNT(*) AS total_transfer_count,
    SUM(amount) AS total_volume_usdc,

    SUM(CASE WHEN amount > 100000 THEN 1 ELSE 0 END) AS large_transfer_count,
    SUM(CASE WHEN amount > 100000 THEN amount ELSE 0 END) AS large_transfer_value_usdc,

    100.0 * SUM(CASE WHEN amount > 100000 THEN 1 ELSE 0 END) 
        / COUNT(*) AS large_transfer_count_pct,

    100.0 * SUM(CASE WHEN amount > 100000 THEN amount ELSE 0 END) 
        / NULLIF(SUM(amount), 0) AS large_transfer_value_pct

FROM tokens.transfers
WHERE blockchain = 'base'
  AND contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
  AND block_date >= CURRENT_DATE - INTERVAL '30' DAY
  AND block_date < CURRENT_DATE

GROUP BY 1
ORDER BY 1
