\echo # Loading request schema
drop schema if exists request cascade;
create schema request;

create or replace function request.env_var(v text) returns text as $$
  declare
    result text;
  begin
    begin
      select current_setting(v) into result;
    exception 
      when undefined_object then
        return null;
    end;
    return result;
  end;
$$ stable language plpgsql;

create or replace function request.jwt_claim(c text) returns text as $$
    select request.env_var('request.jwt.claim.' || c);
$$ stable language sql;

create or replace function request.cookie(c text) returns text as $$
    select request.env_var('request.cookie.' || c);
$$ stable language sql;

create or replace function request.header(h text) returns text as $$
    select request.env_var('request.header.' || h);
$$ stable language sql;
