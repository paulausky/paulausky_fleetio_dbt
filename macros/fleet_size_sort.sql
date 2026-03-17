{% macro fleet_size_sort(column_name) %}

case
    when {{ column_name }} = '<15'     then 1
    when {{ column_name }} = '15-99'   then 2
    when {{ column_name }} = '100-499' then 3
    when {{ column_name }} = '500-999' then 4
    when {{ column_name }} = '>1000'   then 5
end

{% endmacro %}