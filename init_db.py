import duckdb
import os

os.makedirs('data', exist_ok=True)
db_path = 'data/nyc_taxi.db'
conn = duckdb.connect(db_path)

print("Inicjalizacja tabel")

conn.execute("""
    CREATE TABLE IF NOT EXISTS zones AS 
    SELECT * FROM 'data/taxi_zone_lookup.csv'
""")
print("\nTabela zones utworzona")

conn.execute("""
    CREATE TABLE IF NOT EXISTS trips AS 
    SELECT * FROM 'data/yellow_tripdata_2026-03.parquet'
""")
print("\nTabela trips utworzona")

print("\ntabele:")
tables = conn.execute("SHOW TABLES").df()
print(tables)

trips_count = conn.execute("SELECT COUNT(*) FROM trips").fetchone()[0]
print(f"\ntrips zawiera {trips_count:,} wierszy.")

conn.close()