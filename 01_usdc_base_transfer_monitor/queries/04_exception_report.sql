select

block_date as date
, COUNT(*) AS total_transfer_count
, SUM(amount) AS total_volume_usdc

, sum(case when amount > 100000 then 1 else 0 end) as large_transfer_count_exceed_100k,

    100.0 * SUM(CASE WHEN amount >= 100000 THEN 1 ELSE 0 END)
        / COUNT(*) AS large_transfer_count_pct,

    100.0 * SUM(CASE WHEN amount >= 100000 THEN amount ELSE 0 END)
        / NULLIF(SUM(amount), 0) AS large_transfer_value_pct,

 sum(case when amount_usd is null then 1 else 0 end) as null_value_usd_count
, sum(case when amount = 0 then 1 else 0 end) as zero_value_count

from tokens.transfers

where blockchain = 'base'
and contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
and block_date >= CURRENT_DATE - interval '30' DAY
and block_date < CURRENT_DATE

group by 1
order by 2 desc

LIMIT 100
