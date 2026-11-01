{% macro amount_bucket(amount) %}
case
    when {{ amount }} < 100 then 'LOW'
    when {{ amount }} < 1000 then 'MEDIUM'
    else 'HIGH'
end
{% endmacro %}
