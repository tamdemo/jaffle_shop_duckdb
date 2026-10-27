-- first_order, most_recent_order and number_of_orders all come from the same
-- per-customer aggregation of orders, so they must be either all NULL
-- (customer has no orders) or all populated, with number_of_orders >= 1.
select
    customer_id,
    first_order,
    most_recent_order,
    number_of_orders
from {{ ref('customers') }}
where not (
    (first_order is null and most_recent_order is null and number_of_orders is null)
    or (first_order is not null and most_recent_order is not null and number_of_orders >= 1)
)
