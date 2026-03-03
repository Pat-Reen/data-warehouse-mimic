"""
refresh.py
Triggers the refresh_policy_policyholder stored procedure.
Run this whenever you want to resync the combined table from source data.
"""

import os
import sys

import psycopg2
from dotenv import load_dotenv

load_dotenv()

DATABASE_URL = os.getenv("DATABASE_URL")
if not DATABASE_URL:
    sys.exit("ERROR: DATABASE_URL not set in .env")


def main() -> None:
    print("Connecting to database ...")
    conn = psycopg2.connect(DATABASE_URL)

    try:
        print("Calling refresh_policy_policyholder() ...")
        with conn.cursor() as cur:
            cur.execute("CALL refresh_policy_policyholder();")
        conn.commit()

        with conn.cursor() as cur:
            cur.execute("SELECT COUNT(*) FROM policy_policyholder;")
            count = cur.fetchone()[0]

        print(f"Refresh complete. policy_policyholder now contains {count} rows.")

    finally:
        conn.close()


if __name__ == "__main__":
    main()
