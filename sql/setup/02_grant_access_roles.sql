ALTER SESSION SET "_ORACLE_SCRIPT"=true;

CREATE ROLE TECHNICIEN;
CREATE ROLE ADMIN;
CREATE ROLE UTILISATEUR;

GRANT SELECT ON view_equipements_details TO TECHNICIEN;
GRANT SELECT, UPDATE, DELETE, INSERT ON GLPI_EQUIPEMENT TO ADMIN;
GRANT SELECT, UPDATE, DELETE, INSERT ON GLPI_LIEU TO ADMIN;
GRANT SELECT, UPDATE, DELETE, INSERT ON GLPI_LOCATION TO ADMIN;
GRANT SELECT, UPDATE, DELETE, INSERT ON GLPI_SITE TO ADMIN;
GRANT SELECT, UPDATE, DELETE, INSERT ON GLPI_TICKET TO ADMIN;
GRANT SELECT, UPDATE, DELETE, INSERT ON GLPI_TYPE TO ADMIN;
GRANT SELECT, UPDATE, DELETE, INSERT ON GLPI_UTILISATEUR TO ADMIN;

GRANT SELECT ON view_utilisateur_equipements_disponibles TO UTILISATEUR;
GRANT SELECT ON view_utilisateurs_tickets TO UTILISATEUR;

GRANT TECHNICIEN TO glpi_cergy_technicien;
GRANT ADMIN TO glpi_cergy_admin;
GRANT UTILISATEUR TO glpi_cergy_utilisateur;

GRANT TECHNICIEN TO glpi_pau_technicien;
GRANT ADMIN TO glpi_pau_admin;
GRANT UTILISATEUR TO glpi_pau_utilisateur;