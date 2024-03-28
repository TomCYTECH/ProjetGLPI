-- Vue qui résume tous les éléments d'un équipement
CREATE OR REPLACE VIEW view_equipement_details AS
SELECT e.ID, e.NOM AS Equipment_Name, t.NOM AS Type, l.NOM AS Location, s.NOM AS Site
FROM GLPI_EQUIPEMENT e
JOIN GLPI_TYPE t ON e.TYPE_ID = t.ID
JOIN GLPI_LIEU l ON e.LIEU_ID = l.ID
JOIN GLPI_SITE s ON e.SITE_ID = s.ID;

-- Vue qui résume les équipements d'un site
CREATE OR REPLACE VIEW view_equipements_site AS
SELECT s.NOM AS Site, t.NOM AS Type, COUNT(e.ID) AS Equipment_Count
FROM GLPI_SITE s
JOIN GLPI_EQUIPEMENT e ON s.ID = e.SITE_ID
JOIN GLPI_TYPE t ON e.TYPE_ID = t.ID
GROUP BY s.NOM, t.NOM;

-- Vue qui résume les équipements disponibles (Technicien et utilisateur)
CREATE OR REPLACE VIEW view_equipements_disponibles AS
SELECT e.NOM AS Equipment, e.ID, CASE WHEN l.FIN < CURRENT_DATE THEN 'Disponible' ELSE 'Indisponible' END AS Status
FROM GLPI_EQUIPEMENT e
LEFT JOIN GLPI_LOCATION l ON e.ID = l.EQUIPEMENT_ID
ORDER BY e.ID;

-- Vue qui donne les utilisateurs par site
CREATE OR REPLACE VIEW view_utilisateurs_par_site AS
SELECT u.ID, u.NOM, u.PRENOM, u.EMAIL, u.ROLE, s.NOM AS Site
FROM GLPI_UTILISATEUR u
JOIN GLPI_SITE s ON u.SITE_ID = s.ID;


-----------
-- ADMIN --
-----------

-- Vue qui détaille les équipements
CREATE OR REPLACE VIEW view_equipements_details AS
SELECT e.ID, e.NUMERO_SERIE, e.NOM, t.NOM AS Type, l.NOM AS Lieu, s.NOM AS Site, CASE WHEN loc.DEBUT IS NOT NULL AND loc.FIN > SYSDATE THEN 'Loué' ELSE 'Disponible' END AS Statut
FROM GLPI_EQUIPEMENT e
JOIN GLPI_TYPE t ON e.TYPE_ID = t.ID
JOIN GLPI_LIEU l ON e.LIEU_ID = l.ID
JOIN GLPI_SITE s ON e.SITE_ID = s.ID
LEFT JOIN GLPI_LOCATION loc ON e.ID = loc.EQUIPEMENT_ID;

-- Vue qui détaille la les utilisateurs et l'état de leurs tickets
CREATE OR REPLACE VIEW view_utilisateurs_tickets AS
SELECT u.ID, u.NOM, u.PRENOM, u.EMAIL, u.ROLE, t.ID AS Ticket_ID, t.STATUT, t.CREATION_DATE
FROM GLPI_UTILISATEUR u
LEFT JOIN GLPI_TICKET t ON u.ID = t.UTILISATEUR_ID;


----------------
-- TECHNICIEN --
----------------

-- Vue des tickets ouverts
CREATE OR REPLACE VIEW view_technicien_tickets_ouverts AS
SELECT t.ID, t.NOM, t.DESCRIPTION, t.CREATION_DATE, u.NOM || ' ' || u.PRENOM AS Demande_Par
FROM GLPI_TICKET t
JOIN GLPI_UTILISATEUR u ON t.UTILISATEUR_ID = u.ID
WHERE t.STATUT = 'OUVERT';

-- Vue des tickets en cours
CREATE OR REPLACE VIEW view_technicien_tickets_en_cours AS
SELECT t.ID, t.NOM, t.DESCRIPTION, t.CREATION_DATE, u.NOM || ' ' || u.PRENOM AS Demande_Par
FROM GLPI_TICKET t
JOIN GLPI_UTILISATEUR u ON t.UTILISATEUR_ID = u.ID
WHERE t.STATUT = 'EN_COURS';

-- Vue des tickets fermés
CREATE OR REPLACE VIEW view_technicien_tickets_ferme AS
SELECT t.ID, t.NOM, t.DESCRIPTION, t.CREATION_DATE, u.NOM || ' ' || u.PRENOM AS Demande_Par
FROM GLPI_TICKET t
JOIN GLPI_UTILISATEUR u ON t.UTILISATEUR_ID = u.ID
WHERE t.STATUT = 'FERME';

-- Vue des tickets pour un utilisateur
CREATE OR REPLACE VIEW view_tickets_utilisateur AS
SELECT u.NOM AS User_Name, u.PRENOM AS User_FirstName, t.NOM AS Ticket, t.STATUT AS Status, t.CREATION_DATE, t.DESCRIPTION, e.NOM AS Equipment
FROM GLPI_UTILISATEUR u
JOIN GLPI_TICKET t ON u.ID = t.UTILISATEUR_ID
JOIN GLPI_EQUIPEMENT e ON t.EQUIPEMENT_ID = e.ID;


-----------------
-- UTILISATEUR --
-----------------

-- Vue des équipements disponibles à la location
CREATE OR REPLACE VIEW view_utilisateur_equipements_disponibles AS
SELECT e.ID, e.NUMERO_SERIE, e.NOM, t.NOM AS Type, 'Disponible' AS Statut
FROM GLPI_EQUIPEMENT e
JOIN GLPI_TYPE t ON e.TYPE_ID = t.ID
WHERE e.ID NOT IN (SELECT EQUIPEMENT_ID FROM GLPI_LOCATION WHERE FIN > SYSDATE);
COMMIT;