CREATE ROLE TECHNICIEN;
CREATE ROLE ADMIN;
CREATE ROLE UTILISATEUR;

GRANT SELECT ON view_equipements_details TO TECHNICIEN;
GRANT ALL PRIVILEGES TO ADMIN;
GRANT SELECT ON view_utilisateur_equipements_disponibles TO UTILISATEUR;
GRANT SELECT ON view_utilisateurs_tickets TO UTILISATEUR;

GRANT TECHNICIEN TO glpi_cergy_technicien;
GRANT ADMIN TO glpi_cergy_admin;
GRANT UTILISATEUR TO glpi_cergy_utilisateur;

GRANT TECHNICIEN TO glpi_pau_technicien;
GRANT ADMIN TO glpi_pau_admin;
GRANT UTILISATEUR TO glpi_pau_utilisateur;