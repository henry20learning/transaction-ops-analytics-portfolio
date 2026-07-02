select
    block_date as date
    , COUNT(*) as total_transfer_count
    , sum(amount) as volume_USDC
    , sum(amount) / COUNT(*) as avg_transfer_value_USDC
    , count(distinct "from") as active_sender_count
    , count(distinct "to") as active_receiver_count
from tokens.transfers
where blockchain = 'base'
   and contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
   and block_date >= CURRENT_DATE - INTERVAL '30' DAY
   and block_date <> CURRENT_DATE
group by
    1
order by
    1 desc
limit 100
