-- stg_customers must keep exactly one row per raw_customers row (no rows dropped or duplicated).
with counts as (
    select
        (select count(*) from {{ ref('raw_customers') }}) as raw_rows,
        (select count(*) from {{ ref('stg_customers') }}) as stg_rows
)

select *
from counts
where raw_rows != stg_rows
