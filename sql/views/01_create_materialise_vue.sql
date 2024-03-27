

CREATE VIEW glpi_cergy_pau_view AS
SELECT * FROM glpi_cergy
UNION ALL
SELECT * FROM glpi_pau;

CREATE TABLE glpi_cergy_pau_materialized AS
SELECT * FROM glpi_cergy
UNION ALL
SELECT * FROM glpi_pau;

TRUNCATE TABLE glpi_cergy_pau_materialized;

INSERT INTO glpi_cergy_pau_materialized
SELECT * FROM glpi_cergy
UNION ALL
SELECT * FROM glpi_pau;