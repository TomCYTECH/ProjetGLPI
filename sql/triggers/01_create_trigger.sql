-- Trigger pour vérifier que les dates de début et de fin dans la table GLPI_LOCATION correspondent aux dates de création du tickets
CREATE OR REPLACE TRIGGER check_location_dates
BEFORE INSERT ON GLPI_LOCATION
FOR EACH ROW
DECLARE
    creation_date DATE;
BEGIN
    -- Sélectionner la date de création du ticket associé à partir de GLPI_TICKET
    SELECT CREATION_DATE INTO creation_date FROM GLPI_TICKET WHERE ID = :new.TICKET_ID;

    -- Vérifier si la date de début et la date de fin sont postérieures à la date de création du ticket
    IF (creation_date IS NOT NULL AND (:new.DEBUT < creation_date OR :new.FIN < creation_date)) THEN
        RAISE_APPLICATION_ERROR(-20001, 'Les dates de début et de fin doivent être postérieures à la date de création du ticket.');
    END IF;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        NULL; -- Gérer l'absence de ticket associé si nécessaire
END;
/


-- Trigger pour s'assurer qu'un équipement ne peut pas être assigné à deux sites différents
CREATE OR REPLACE TRIGGER check_equipment_site
BEFORE INSERT OR UPDATE ON GLPI_EQUIPEMENT
FOR EACH ROW
DECLARE
    site_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO site_count FROM GLPI_SITE WHERE ID = :new.SITE_ID;
    
    IF (site_count = 0) THEN
        RAISE_APPLICATION_ERROR(-20002, 'L''équipement doit être associé à un site existant.');
    END IF;
END;
/

-- Trigger pour s'assurer qu'un ticket ne peut pas être créé sans équipement
CREATE OR REPLACE TRIGGER check_ticket_equipment
BEFORE INSERT ON GLPI_TICKET
FOR EACH ROW
DECLARE
    equipment_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO equipment_count FROM GLPI_EQUIPEMENT WHERE ID = :new.EQUIPEMENT_ID;
    
    IF (equipment_count = 0) THEN
        RAISE_APPLICATION_ERROR(-20003, 'Le ticket doit être associé à un équipement existant.');
    END IF;
END;
/

-- Trigger pour s'assurer qu'un ticket ne peut pas être créé sans utilisateur
CREATE OR REPLACE TRIGGER check_ticket_user
BEFORE INSERT ON GLPI_TICKET
FOR EACH ROW
DECLARE
    user_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO user_count FROM GLPI_UTILISATEUR WHERE ID = :new.UTILISATEUR_ID;
    
    IF (user_count = 0) THEN
        RAISE_APPLICATION_ERROR(-20004, 'Le ticket doit être associé à un utilisateur existant.');
    END IF;
END;
/ 


CREATE OR REPLACE TRIGGER assign_technician
BEFORE INSERT ON GLPI_TICKET
FOR EACH ROW
DECLARE
    v_technician_id NUMBER;
BEGIN
    -- Vérifier si le ticket n'a pas déjà un technicien attribué
    IF :new.UTILISATEUR_ID IS NULL THEN
        -- Sélectionner un technicien disponible dans la base de données
        SELECT ID INTO v_technician_id
        FROM GLPI_UTILISATEUR
        WHERE ROLE = 'TECHNICIEN' AND ROWNUM = 1; -- Choisissez le premier technicien disponible, vous pouvez ajuster la logique selon vos besoins
        
        -- Attribuer le technicien au nouveau ticket
        :new.UTILISATEUR_ID := v_technician_id;
    END IF;
END;
/
