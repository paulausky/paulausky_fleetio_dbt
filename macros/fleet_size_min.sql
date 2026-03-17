{% macro fleet_size_min(column_name) %}

case
    when {{ column_name }} = '<15'     then 1
    when {{ column_name }} = '15-99'   then 15
    when {{ column_name }} = '100-499' then 100
    when {{ column_name }} = '500-999' then 500
    when {{ column_name }} = '>1000'   then 1000
end

{% endmacro %}