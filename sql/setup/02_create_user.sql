CREATE USER glpi IDENTIFIED BY glpi;
GRANT CONNECT, RESOURCE, DBA TO glpi;
CONNECT glpi/glpi;
SET TIMING ON;