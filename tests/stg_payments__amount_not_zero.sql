-- DATA ISSUE (warn only): 3 payments in the current seed have amount = 0
-- (payment_id 10, 74, 87). They may be legitimate (e.g. fully discounted),
-- so this is kept at severity warn pending client confirmation.
{{ config(severity='warn') }}

select
    payment_id,
    order_id,
    payment_method,
    amount
from {{ ref('stg_payments') }}
where amount = 0
