ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE TABLESPACE glpi_data
  DATAFILE 'glpi_data01.dbf' SIZE 200M
  AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED;
ALTER USER glpi_cergy QUOTA 100M ON glpi_data;
ALTER USER glpi_pau QUOTA 100M ON glpi_data;