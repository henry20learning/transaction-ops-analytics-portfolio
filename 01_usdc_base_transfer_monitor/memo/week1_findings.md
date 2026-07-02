# USDC on Base — Stablecoin Transfer Operations Monitor

## 1. Objective

This project monitors USDC transfer activity on Base using DuneSQL. The goal is to practise transaction operations analytics by analysing daily transfer activity, large-transfer concentration, data-quality exceptions and address-level inflow/outflow patterns.

## 2. Dataset

The analysis uses Dune `tokens.transfers` data.

Filters used:
- Blockchain: Base
- Token: USDC
- Period: last 30 complete days
- Current day excluded to avoid partial-day distortion

## 3. Method

The dashboard is divided into four sections.

Section 1 monitors daily USDC transfer activity, including transfer count, transfer volume, active sender count, active receiver count and average transfer size.

Section 2 monitors large transfers, defined as transfers above 100,000 USDC. It compares large transfers as a percentage of total transfer count and as a percentage of total transfer value. It also includes a table of the top 50 largest USDC transfers.

Section 3 checks data-quality and exception indicators, including large-transfer count, missing USD value records and zero-value transfer records.

Section 4 analyses address-level inflow, outflow and net flow. Net USDC flow is calculated as total inflow minus total outflow.

## 4. Key findings

1. Daily transfer volume and average transfer size showed several spikes during the 30-day period. Volume and average transfer size appeared higher in the first half of the period than in the second half.

2. Transfer count and active sender/receiver counts declined slightly over the period. However, wallet addresses are not the same as users, so this should be interpreted as a decline in address-level activity rather than confirmed user decline.

3. Large transfers represented only a small share of total transfer count, but they accounted for a large share of total USDC transfer value. This suggests that transfer frequency and value exposure should be monitored separately.

4. Many of the largest transfers appeared to be associated with a small number of high-volume addresses. This suggests that a small number of addresses can have a large effect on daily transfer volume.

5. Section 3 flagged zero-value and missing-value records as data-quality review items. These records are not automatically suspicious, but they should be monitored because they may affect reporting quality.

6. Address-level net flow showed that some addresses with very large inflows or outflows had much smaller net flow after both sides were considered. This shows that high gross activity does not always mean an address is accumulating USDC.

## 5. Business interpretation

This dashboard could be useful for a crypto operations, payments operations or risk monitoring team. It helps monitor daily transaction activity, identify high-value review items, check data-quality exceptions and distinguish between gross transaction activity and actual net movement.

The most important business insight is that a small number of high-value transfers can drive a large share of total USDC volume, even when most transfer records are smaller. This means an operations team should monitor both transfer count and transfer value, rather than relying on one metric only.

## 6. Limitations

1. This is on-chain transfer data, not payment processor data.
2. The dashboard does not include failed payments, refunds, chargebacks or settlement delays.
3. Wallet addresses do not automatically represent real customer identities.
4. Large transfers are review candidates, not automatically suspicious.
5. Address labels should be verified before drawing strong conclusions.
6. `amount_usd` may be incomplete, so USDC `amount` was used as an approximate USD value where appropriate.

## 7. Next steps

1. Add wallet and protocol labels where available.
2. Add spike detection logic to identify unusual volume days.
3. Compare the current 30-day period with the previous 30-day period.
4. Investigate the largest transfer days using sender and receiver address analysis.
5. Build a simulated payment operations dataset with success, failure, refund and chargeback fields.
