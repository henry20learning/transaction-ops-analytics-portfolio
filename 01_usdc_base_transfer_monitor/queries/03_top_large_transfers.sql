select 
block_date, block_time, tx_hash, "from" as sender_address, "to" as receiver_address, amount as transfer_amount_usdc,
case when amount >1000000 then 'very large >1M' when amount >100000 then 'large >100K' else 'below 100k' END as transfer_size_band

from tokens.transfers

where blockchain = 'base'
and contract_address = 0x833589fcd6edb6e08f4c7c32d4f71b54bda02913
and block_date >= CURRENT_DATE - interval '30' DAY
and block_date < CURRENT_DATE

order by amount desc

limit 50
