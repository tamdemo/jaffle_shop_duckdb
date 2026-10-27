-- The four per-method *_amount columns must add up to the order total `amount`.
-- Fails if a payment_method outside the pivot list appears (it would count
-- towards `amount` but no *_amount column). Tolerance absorbs DOUBLE rounding.
select
    order_id,
    amount,
    credit_card_amount + coupon_amount + bank_transfer_amount + gift_card_amount as sum_of_method_amounts
from {{ ref('orders') }}
where abs(
    amount - (credit_card_amount + coupon_amount + bank_transfer_amount + gift_card_amount)
) > 0.001
