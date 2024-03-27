-- GLPI_LIEU
CREATE OR REPLACE PROCEDURE insert_lieux_data IS
BEGIN
  FOR i IN 1..10000 LOOP
    INSERT INTO GLPI_LIEU (NOM)
    VALUES ('Lieu_' || i);
  END LOOP;
  COMMIT;
END;
/
-- GLPI_TYPE
CREATE OR REPLACE PROCEDURE insert_types_data IS
BEGIN
  FOR i IN 1..10000 LOOP
    INSERT INTO GLPI_TYPE (NOM, DESCRIPTION)
    VALUES ('Type_' || i, 'Description_' || i);
  END LOOP;
  COMMIT;
END;
/
-- GLPI_SITE
CREATE OR REPLACE PROCEDURE insert_sites_data IS
BEGIN
  FOR i IN 1..10000 LOOP
    INSERT INTO GLPI_SITE (LIEU_ID, NOM)
    VALUES (TRUNC(DBMS_RANDOM.VALUE(1, 5)), 'Site_' || i); -- Assuming 5 locations exist
  END LOOP;
  COMMIT;
END;
/
-- GLPI_EQUIPEMENT
CREATE OR REPLACE PROCEDURE insert_equipements_data IS
BEGIN
  FOR i IN 1..10000 LOOP
    INSERT INTO GLPI_EQUIPEMENT (NUMERO_SERIE, NOM, TYPE_ID, LIEU_ID, SITE_ID)
    VALUES ('NOSERIE' || i, 'Equipement' || i, TRUNC(DBMS_RANDOM.VALUE(1, 4)), TRUNC(DBMS_RANDOM.VALUE(1, 6)), TRUNC(DBMS_RANDOM.VALUE(1, 3)));
  END LOOP;
  COMMIT;
END;
/
-- GLPI_UTILISATEUR
CREATE OR REPLACE PROCEDURE insert_utilisateurs_data IS
BEGIN
  FOR i IN 1..10000 LOOP
    INSERT INTO GLPI_UTILISATEUR (NOM, PRENOM, EMAIL, ROLE, SITE_ID)
    VALUES ('LastName' || i, 'FirstName' || i, 'user' || i || '@example.com', 
    CASE TRUNC(DBMS_RANDOM.VALUE(1, 4)) 
      WHEN 1 THEN 'ADMINISTRATEUR' 
      WHEN 2 THEN 'TECHNICIEN' 
      ELSE 'UTILISATEUR' 
    END, TRUNC(DBMS_RANDOM.VALUE(1, 3)));
  END LOOP;
  COMMIT;
END;
/
-- Date au hasard
CREATE OR REPLACE FUNCTION random_date(p_start_date DATE, p_end_date DATE) RETURN DATE IS
  v_random_date DATE;
BEGIN
  v_random_date := p_start_date + DBMS_RANDOM.VALUE(0, p_end_date - p_start_date);
  RETURN v_random_date;
END;
/
-- GLPI_TICKET
CREATE OR REPLACE PROCEDURE insert_tickets_data IS
BEGIN
  FOR i IN 1..10000 LOOP
    INSERT INTO GLPI_TICKET (NOM, EQUIPEMENT_ID, CREATION_DATE, UTILISATEUR_ID, DESCRIPTION, SITE_ID, STATUT)
    VALUES ('Ticket'||i, TRUNC(DBMS_RANDOM.VALUE(1, 10001)), random_date(TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2022-12-31', 'YYYY-MM-DD')), TRUNC(DBMS_RANDOM.VALUE(1, 10001)), 'Description'||i, TRUNC(DBMS_RANDOM.VALUE(1, 3)), 
    CASE TRUNC(DBMS_RANDOM.VALUE(1, 4))
      WHEN 1 THEN 'EN_COURS'
      WHEN 2 THEN 'OUVERT'
      ELSE 'FERME'
    END);
  END LOOP;
  COMMIT;
END;
/
-- GLPI_LOCATION
CREATE OR REPLACE PROCEDURE insert_locations_data IS
  v_start_date DATE;
  v_end_date DATE;
BEGIN
  FOR i IN 1..10000 LOOP
    v_start_date := random_date(TO_DATE('2020-01-01', 'YYYY-MM-DD'), TO_DATE('2022-12-31', 'YYYY-MM-DD'));
    v_end_date := v_start_date + NUMTODSINTERVAL(TRUNC(DBMS_RANDOM.VALUE(1, 91)), 'DAY');
    
    INSERT INTO GLPI_LOCATION (EQUIPEMENT_ID, UTILISATEUR_ID, DEBUT, FIN)
    VALUES (i, TRUNC(DBMS_RANDOM.VALUE(1, 10001)), v_start_date, v_end_date);
  END LOOP;
  COMMIT;
END;
/