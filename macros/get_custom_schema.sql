-- This macro is for using different datasets when running from CLI and production
{# {% macro generate_schema_name(custom_schema_name, node) -%}
{{ generate_schema_name_for_env(custom_schema_name, node) }}
{%- endmacro %} #}

-- With this macro, both CLI and production runs will build models to the same datasets
{% macro generate_schema_name(custom_schema_name, node) -%}

    {%- set default_schema = target.schema -%}
    {%- if custom_schema_name is none -%}

        {{ default_schema }}

    {%- else -%}

        {{ custom_schema_name | trim }}

    {%- endif -%}

{%- endmacro %}