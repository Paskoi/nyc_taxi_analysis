import duckdb

conn = duckdb.connect('data/nyc_taxi.db')

with open('sql/01_exploration.sql', 'r', encoding='utf-8') as f:
    sql_queries = f.read()

queries = [q.strip() for q in sql_queries.split(';') if q.strip()]

titles = [
    "1. Tabela trips:",
    "2. Tabela zones:",
    "3. Przegląd zakresu danych i anomalii:",
    "4. Struktura metod płatności (udział w %):",
    "5. Brakujące strefy:",
    "6. Rozbudowany przegląd zakresu danych i anomalii"
]

for title, query in zip(titles, queries):
    print("\n" + "-"*50)
    print(title)
    print("-"*50)
    df = conn.execute(query).df()
    print(df.to_string(index=False))

conn.close()