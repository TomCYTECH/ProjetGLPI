CREATE ROLE "CERGY_ADMIN";
CREATE ROLE "CERGY_USER";
CREATE ROLE "CERGY_TECHNICIEN";

GRANT ALL PRIVILEGES TO "CERGY_ADMIN";

GRANT SELECT, DELETE, UPDATE ON GLPI_LIEU TO "CERGY_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_TYPE TO "CERGY_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_SITE TO "CERGY_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_EQUIPEMENT TO "CERGY_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_UTILISATEUR TO "CERGY_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_TICKET TO "CERGY_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_LOCATION TO "CERGY_TECHNICIEN";

CREATE ROLE "PAU_ADMIN";
CREATE ROLE "PAU_USER";
CREATE ROLE "PAU_TECHNICIEN";

GRANT ALL PRIVILEGES TO "PAU_ADMIN";

GRANT SELECT, DELETE, UPDATE ON GLPI_LIEU TO "PAU_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_TYPE TO "PAU_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_SITE TO "PAU_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_EQUIPEMENT TO "PAU_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_UTILISATEUR TO "PAU_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_TICKET TO "PAU_TECHNICIEN";
GRANT SELECT, DELETE, UPDATE ON GLPI_LOCATION TO "PAU_TECHNICIEN";

CREATE ROLE "GLOBAL_ADMIN";

GRANT ALL PRIVILEGES TO "GLOBAL_ADMIN";

GRANT "CERGY_ADMIN", "CERGY_USER", "CERGY_TECHNICIEN", "PAU_ADMIN", "PAU_USER", "PAU_TECHNICIEN", "GLOBAL_ADMIN" TO glpi;