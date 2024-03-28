CREATE OR REPLACE PROCEDURE countOpenTicketsBySite IS
    CURSOR ticketCursor IS
        SELECT SITE_ID, COUNT(*) AS num_open_tickets
        FROM GLPI_TICKET
        WHERE STATUT = 'OUVERT'
        GROUP BY SITE_ID;
    ticketRecord ticketCursor%ROWTYPE;
BEGIN
    OPEN ticketCursor;
    LOOP
        FETCH ticketCursor INTO ticketRecord;
        EXIT WHEN ticketCursor%NOTFOUND;
        -- Traitement des données récupérées
        DBMS_OUTPUT.PUT_LINE('Site ID: ' || ticketRecord.SITE_ID || ', Nombre de tickets ouverts: ' || ticketRecord.num_open_tickets);
    END LOOP;
    CLOSE ticketCursor;
END;
/