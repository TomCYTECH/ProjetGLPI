DECLARE
  CURSOR equipment_cursor IS
    SELECT e.ID, e.NOM, t.NOM AS Type, l.NOM AS Location, s.NOM AS Site
    FROM GLPI_EQUIPEMENT e
    JOIN GLPI_TYPE t ON e.TYPE_ID = t.ID
    JOIN GLPI_LIEU l ON e.LIEU_ID = l.ID
    JOIN GLPI_SITE s ON e.SITE_ID = s.ID;
  equipment_record equipment_cursor%ROWTYPE;
BEGIN
  OPEN equipment_cursor;
  LOOP
    FETCH equipment_cursor INTO equipment_record;
    EXIT WHEN equipment_cursor%NOTFOUND;
    -- Process each record as needed
    DBMS_OUTPUT.PUT_LINE('Equipment ID: ' || equipment_record.ID || ', Name: ' || equipment_record.NOM);
  END LOOP;
  CLOSE equipment_cursor;
END;
/
DECLARE
  CURSOR user_tickets_cursor IS
    SELECT u.ID, u.NOM, u.PRENOM, t.ID AS Ticket_ID, t.STATUT, t.CREATION_DATE
    FROM GLPI_UTILISATEUR u
    JOIN GLPI_TICKET t ON u.ID = t.UTILISATEUR_ID
    WHERE t.STATUT = 'OUVERT';

  ticket_record user_tickets_cursor%ROWTYPE;
BEGIN
  OPEN user_tickets_cursor;
  LOOP
    FETCH user_tickets_cursor INTO ticket_record;
    EXIT WHEN user_tickets_cursor%NOTFOUND;
    -- Processing logic here
    DBMS_OUTPUT.PUT_LINE('User: ' || ticket_record.NOM || ', Ticket ID: ' || ticket_record.Ticket_ID);
  END LOOP;
  CLOSE user_tickets_cursor;
END;
/
DECLARE
  CURSOR available_equipments_cursor IS
    SELECT e.ID, e.NOM
    FROM GLPI_EQUIPEMENT e
    WHERE NOT EXISTS (
      SELECT 1
      FROM GLPI_LOCATION l
      WHERE l.EQUIPEMENT_ID = e.ID
      AND l.FIN >= SYSDATE -- Assuming the end date is in the future
    );

  equipment available_equipments_cursor%ROWTYPE;
BEGIN
  OPEN available_equipments_cursor;
  LOOP
    FETCH available_equipments_cursor INTO equipment;
    EXIT WHEN available_equipments_cursor%NOTFOUND;
    -- Display or process available equipment
    DBMS_OUTPUT.PUT_LINE('Available Equipment: ' || equipment.NOM);
  END LOOP;
  CLOSE available_equipments_cursor;
END;
/