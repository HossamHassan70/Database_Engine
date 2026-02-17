# Database Engine Bash Project

A lightweight **database engine simulator built in Bash**.
It stores databases as directories and tables as plain text files with a simple schema format.

## About

This project provides a terminal menu system to perform CRUD operations similar to a tiny relational database workflow:

- Create, list, connect to, and drop databases.
- Create tables with typed columns.
- Insert, select, update, and delete table records.

## How data is stored

Inside `DB/`:

- Each **database** is a directory.
- Each **table** is a file.

Each table file has this structure:

1. First line: column names separated by `:`
2. Second line: column types separated by `:` (`int` or `str`)
3. Remaining lines: records where the first field is an auto-generated integer `id`

Example:

```text
id:name:age
int:str:int
1:alice:21
2:bob:30
```

## Features

- **Persistent storage** in text files.
- **Schema definition** at table creation time.
- **Type validation** on insert and update (`int`/`str`).
- **CRUD operations** across menu-driven scripts.

## Project scripts

- `mainMenu.sh`: database-level operations.
- `tableMenu.sh`: table-level operation router.
- `createTable.sh`, `listTables.sh`, `dropTable.sh`
- `insertInTable.sh`, `selectFromTable.sh`, `updateTable.sh`, `removeFromTable.sh`

## Getting started

```bash
git clone https://github.com/HossamHassan70/Database_Engine.git
cd Database_Engine
bash mainMenu.sh
```

## Notes

- Run scripts from the repository root for correct relative paths.
- This is a learning project and intentionally keeps storage/query logic simple.

## Contributors

- [Hossam Hassan](https://github.com/HossamHassan70)
- [Amany Abdelrahman](https://github.com/amany-abdelrahman)

## References

- https://en.wikipedia.org/wiki/Database_engine
- https://devhints.io/bash
- https://linuxconfig.org/bash-scripting-tutorial
- https://www.regular-expressions.info/posixbrackets.html
