# USDC on Base — Stablecoin Transfer Operations Monitor

## Project summary

This project monitors USDC transfer activity on Base using DuneSQL. The dashboard tracks daily transfer activity, large-transfer concentration, data-quality exceptions and address-level inflow/outflow patterns over the last 30 complete days.

The goal of this project is to practise transaction operations analytics using public on-chain data.

## Dashboard

Dune dashboard: [USDC on Base — Stablecoin Transfer Operations Monitor](PASTE_YOUR_DUNE_LINK_HERE)

## Business problem

Transaction-heavy businesses need to monitor transfer activity, identify high-value movements, check data-quality exceptions and understand whether activity is driven by broad usage or a small number of high-volume addresses.

This project uses USDC transfer data as a proxy for stablecoin payment / crypto operations monitoring.

## Dataset

Source: Dune `tokens.transfers`

Filters used:

- Blockchain: Base
- Token: USDC
- Period: last 30 complete days
- Current day excluded to avoid partial-day distortion

## Dashboard sections

### 1. Daily activity

Tracks:

- Daily transfer count
- Daily USDC transfer volume
- Active sender count
- Active receiver count
- Average transfer size

### 2. Large transfer monitoring

Large transfers are defined as transfers above 100,000 USDC.

This section compares:

- Large transfers as a percentage of transfer count
- Large transfers as a percentage of transfer value
- Top 50 largest USDC transfers

### 3. Data quality and exception report

Flags daily review items including:

- Large transfer count
- Missing USD value records
- Zero-value transfer records

These are not automatically suspicious. They are review items for operations monitoring.

### 4. Address net flow

Compares USDC inflows and outflows by address.

Net USDC flow is calculated as:

```text
total inflow USDC - total outflow USDC
