with incoming as (select 

"to" as receiver_address
, count(*) as total_transfer_count
, sum(amount) as total_transfer_volume_usdc
, sum(amount) / count(*) as avg_transfer_size

from tokens.transfers

where blockchain = 'base'
and contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
and block_date >= CURRENT_DATE - INTERVAL '30' DAY
and block_date < CURRENT_DATE

group by 1),

outgoing as (select 

"from" as sender_address
, count(*) as total_transfer_count
, sum(amount) as total_transfer_volume_usdc
, sum(amount) / count(*) as avg_transfer_size

from tokens.transfers

where blockchain = 'base'
and contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
and block_date >= CURRENT_DATE - INTERVAL '30' DAY
and block_date < CURRENT_DATE

group by 1)

SELECT

coalesce( i.receiver_address, o.sender_address) as address

, coalesce(i.total_transfer_count,0)as total_inflow_count
, coalesce(o.total_transfer_count,0)as total_outflow_count
, coalesce(i.total_transfer_count,0) - coalesce(o.total_transfer_count,0) as net_inflow_count

, coalesce(i.total_transfer_volume_usdc,0) as total_inflow_usdc
, coalesce(o.total_transfer_volume_usdc,0) as total_outflow_usdc
, coalesce(i.total_transfer_volume_usdc,0) - coalesce(o.total_transfer_volume_usdc,0) as net_inflow_usdc

from incoming i
full outer join outgoing o
on i.receiver_address = o.sender_address

order by abs(net_inflow_usdc) desc

limit 100
