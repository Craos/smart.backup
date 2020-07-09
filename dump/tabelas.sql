select table_schema || '.' || table_name as tabela
from information_schema.tables
where table_catalog = 'smt' and table_type = 'BASE TABLE' and table_schema not in ('pg_catalog', 'information_schema')
order by table_schema, table_name;