ALTER SESSION SET "_ORACLE_SCRIPT"=true;
CREATE USER glpi IDENTIFIED BY glpi;
GRANT CONNECT, RESOURCE, DBA TO glpi;
CONNECT glpi/glpi;



ALTER SESSION SET "_ORACLE_SCRIPT"=true;

CREATE USER glpi_cergy IDENTIFIED BY glpi_cergy;
CREATE USER glpi_cergy_technicien IDENTIFIED BY glpi_cergy_technicien;
CREATE USER glpi_cergy_admin IDENTIFIED BY glpi_cergy_admin;
CREATE USER glpi_cergy_utilisateur IDENTIFIED BY glpi_cergy_utilisateur;

CREATE USER glpi_pau IDENTIFIED BY glpi_pau;
CREATE USER glpi_pau_technicien IDENTIFIED BY glpi_pau_technicien;
CREATE USER glpi_pau_admin IDENTIFIED BY glpi_pau_admin;
CREATE USER glpi_pau_utilisateur IDENTIFIED BY glpi_pau_utilisateur;

GRANT CREATE ROLE, CONNECT, CREATE VIEW, RESOURCE TO glpi_cergy;
GRANT CREATE ROLE, CONNECT, CREATE VIEW, RESOURCE TO glpi_pau;

SET TIMING ON;
SET linesize 250;
