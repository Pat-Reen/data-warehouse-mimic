"""
setup.py
Runs all SQL setup scripts in order:
  01_tables.sql   – create tables
  02_seed_data.sql – populate dummy data
  03_procedure.sql – create stored procedure
Then calls the procedure once to populate policy_policyholder.
"""

import os
import sys
from pathlib import Path

import psycopg2
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    sys.exit("ERROR: DATABASE_URL not set in .env")

SQL_DIR = Path(__file__).parent / "sql"
SQL_FILES = [
    "01_tables.sql",
    "02_seed_data.sql",
    "03_procedure.sql",
]


def run_sql_file(conn, path: Path) -> None:
    print(f"  Running {path.name} ...", end=" ")
    sql = path.read_text(encoding="utf-8")
    with conn.cursor() as cur:
        cur.execute(sql)
    conn.commit()
    print("done.")


def main() -> None:
    print("Connecting to database ...")
    conn = psycopg2.connect(DATABASE_URL)

    try:
        for filename in SQL_FILES:
            run_sql_file(conn, SQL_DIR / filename)

        print("  Calling refresh_policy_policyholder() ...", end=" ")
        with conn.cursor() as cur:
            cur.execute("CALL refresh_policy_policyholder();")
        conn.commit()
        print("done.")

        # Show row count
        with conn.cursor() as cur:
            cur.execute("SELECT COUNT(*) FROM policy_policyholder;")
            count = cur.fetchone()[0]
        print(f"\nSetup complete. policy_policyholder contains {count} rows.")

    finally:
        conn.close()


if __name__ == "__main__":
    main()
