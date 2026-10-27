-- customer_lifetime_value must equal the sum of orders.amount for the customer
-- (both are built from stg_payments, so they should never disagree).
with order_totals as (

    select
        customer_id,
        sum(amount) as total_amount
    from {{ ref('orders') }}
    group by customer_id

)

select
    customers.customer_id,
    customers.customer_lifetime_value,
    order_totals.total_amount
from {{ ref('customers') }} as customers
left join order_totals
    on customers.customer_id = order_totals.customer_id
where (customers.customer_lifetime_value is null) <> (order_totals.total_amount is null)
   or abs(customers.customer_lifetime_value - order_totals.total_amount) > 0.001
