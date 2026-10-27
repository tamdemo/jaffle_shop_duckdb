-- Payments should never have a negative amount.
select
    payment_id,
    amount
from {{ ref('stg_payments') }}
where amount < 0
