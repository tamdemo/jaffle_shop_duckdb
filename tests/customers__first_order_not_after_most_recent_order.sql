-- A customer's first order can never be later than their most recent order.
select
    customer_id,
    first_order,
    most_recent_order
from {{ ref('customers') }}
where first_order > most_recent_order
