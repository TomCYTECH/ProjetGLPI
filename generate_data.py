import oracledb
import random
from datetime import datetime, timedelta

dsn = "localhost:1521/xe"
user = "glpi"
password = "glpi"
connection = oracledb.connect(user=user, password=password, dsn=dsn)

NUM_RECORDS = 1000


def random_date(start, end):
    return start + timedelta(days=random.randint(0, (end - start).days))


def insert_equipment(num_records, cursor):
    for i in range(num_records):
        cursor.execute(
            """
            INSERT INTO GLPI_EQUIPEMENT (ID, NOM, TYPE_ID, LIEU_ID, SITE_ID)
            VALUES (:id, :nom, :type_id, :lieu_id, :site_id)
        """,
            {
                "id": i + 1,
                "nom": f"Equipement{i}",
                "type_id": random.randint(1, 3),  # Assuming 3 types exist
                "lieu_id": random.randint(1, 5),  # Assuming 5 locations exist
                "site_id": random.randint(1, 2),  # Assuming 2 sites exist
            },
        )


def insert_users(num_records, cursor):
    for i in range(num_records):
        cursor.execute(
            """
            INSERT INTO GLPI_UTILISATEUR (ID, NOM, PRENOM, EMAIL, SITE_ID)
            VALUES (:id, :nom, :prenom, :email, :site_id)
        """,
            {
                "id": i + 1,
                "nom": f"LastName{i}",
                "prenom": f"FirstName{i}",
                "email": f"user{i}@example.com",
                "site_id": random.randint(1, 2),  # Assuming 2 sites exist
            },
        )


def insert_tickets(num_records, cursor):
    for i in range(num_records):
        cursor.execute(
            """
            INSERT INTO GLPI_TICKET (ID, NOM, EQUIPEMENT_ID, CREATION_DATE, UTILISATEUR_ID, DESCRIPTION, SITE_ID, STATUT)
            VALUES (:id, :nom, :equipement_id, :creation_date, :utilisateur_id, :description, :site_id, :statut)
        """,
            {
                "id": i + 1,
                "nom": f"Ticket{i}",
                "equipement_id": random.randint(1, num_records),
                "creation_date": random_date(
                    datetime(2020, 1, 1), datetime(2022, 12, 31)
                ),
                "utilisateur_id": random.randint(1, num_records),
                "description": f"Description{i}",
                "site_id": random.randint(1, 2),  # Assuming 2 sites exist
                "statut": random.choice(["EN_COURS", "OUVERT", "FERME"]),
            },
        )


def insert_locations(num_records, cursor):
    for i in range(num_records):
        start_date = random_date(datetime(2020, 1, 1), datetime(2022, 12, 31))
        cursor.execute(
            """
            INSERT INTO GLPI_LOCATION (ID, EQUIPEMENT_ID, DEBUT, FIN)
            VALUES (:id, :equipement_id, :debut, :fin)
        """,
            {
                "id": i + 1,
                "equipement_id": random.randint(1, num_records),
                "debut": start_date,
                "fin": start_date
                + timedelta(days=random.randint(1, 90)),  # Up to 90 days later
            },
        )


def insert_data(cursor):
    # GLPI_LIEU
    for i in range(1, NUM_RECORDS):
        cursor.execute(
            "INSERT INTO GLPI_LIEU (ID, NOM) VALUES (:1, :2)", [i, f"Lieu_{i}"]
        )

    # GLPI_TYPE
    for i in range(1, NUM_RECORDS):
        cursor.execute(
            "INSERT INTO GLPI_TYPE (ID, NOM, DESCRIPTION) VALUES (:1, :2, :3)",
            [i, f"Type_{i}", f"Description_{i}"],
        )

    # GLPI_SITE
    for i in range(1, NUM_RECORDS):
        cursor.execute(
            "INSERT INTO GLPI_SITE (ID, LIEU_ID, NOM) VALUES (:1, :2, :3)",
            [i, random.randint(1, NUM_RECORDS - 1), f"Site_{i}"],
        )

    # GLPI_EQUIPEMENT
    insert_equipment(NUM_RECORDS, cursor)

    # GLPI_UTILISATEUR
    insert_users(NUM_RECORDS, cursor)

    # GLPI_TICKET
    insert_tickets(NUM_RECORDS, cursor)

    # GLPI_LOCATION
    insert_locations(NUM_RECORDS, cursor)


def main():
    cursor = connection.cursor()
    insert_data(cursor)
    connection.commit()
    print(f"Insertion de {NUM_RECORDS} lignes dans chaque table.")
    connection.close()


if __name__ == "__main__":
    main()
