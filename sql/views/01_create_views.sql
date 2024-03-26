-- Vue qui résume tous les éléments d'un équipement
CREATE OR REPLACE VIEW equipment_summary AS
SELECT e.ID, e.NOM AS Equipment_Name, t.NOM AS Type, l.NOM AS Location, s.NOM AS Site
FROM GLPI_EQUIPEMENT e
JOIN GLPI_TYPE t ON e.TYPE_ID = t.ID
JOIN GLPI_LIEU l ON e.LIEU_ID = l.ID
JOIN GLPI_SITE s ON e.SITE_ID = s.ID;


-- Vue qui résume les tickets d'un utilistauer
CREATE OR REPLACE VIEW user_tickets AS
SELECT u.NOM AS User_Name, u.PRENOM AS User_FirstName, t.NOM AS Ticket, t.STATUT AS Status, t.CREATION_DATE, t.DESCRIPTION, e.NOM AS Equipment
FROM GLPI_UTILISATEUR u
JOIN GLPI_TICKET t ON u.ID = t.UTILISATEUR_ID
JOIN GLPI_EQUIPEMENT e ON t.EQUIPEMENT_ID = e.ID;

-- Vue qui résume les équipements d'un site
CREATE OR REPLACE VIEW site_equipment_allocation AS
SELECT s.NOM AS Site, t.NOM AS Type, COUNT(e.ID) AS Equipment_Count
FROM GLPI_SITE s
JOIN GLPI_EQUIPEMENT e ON s.ID = e.SITE_ID
JOIN GLPI_TYPE t ON e.TYPE_ID = t.ID
GROUP BY s.NOM, t.NOM;

-- Vue qui résume les équipements disponibles
CREATE OR REPLACE VIEW equipment_availability AS
SELECT e.NOM AS Equipment, e.ID, CASE WHEN l.FIN < CURRENT_DATE THEN 'Disponible' ELSE 'Indisponible' END AS Status
FROM GLPI_EQUIPEMENT e
LEFT JOIN GLPI_LOCATION l ON e.ID = l.EQUIPEMENT_ID
ORDER BY e.ID;