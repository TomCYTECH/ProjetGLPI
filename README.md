# Projet GLPI

## Initialisation

Lancer le script SQL : `sql/setup/setup.sql`

## Pour insérer les données

```
CONNECT glpi_cergy/glpi_cergy
```
OU
```
CONNECT glpi_pau/glpi_pau
```
Executer le script SQL : `sql/data/01_create_procedures_insert.sql`
Executer le script SQL : `sql/data/02_execute_procedures.sql`