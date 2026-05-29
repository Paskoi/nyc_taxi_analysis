# NYC Yellow Taxi Analytics – Analiza Efektywności Biznesowej (Marzec 2026)

## 1. Cel i Problem Biznesowy
Projekt ma na celu przeanalizowanie realnych danych biznesowych dotyczących przejazdów Yellow Cab w marcu 2026 roku.

W ramach projektu szukam odpowiedzi na następujące zagadnienia biznesowe:
1. **Zarządzanie popytem (Kiedy?):** W które dni tygodnia i w jakich godzinach występuje największe zapotrzebowanie na przejazdy? Jak optymalnie rozłożyć flotę w ciągu doby?
2. **Geografia przychodów (Gdzie?):** Które strefy początkowe (Pickup Zones) generują najwyższy całkowity przychód, a które charakteryzują się najwyższą średnią wartością kursu?
3. **Ekonomia napiwków (Dlaczego?):** Jakie czynniki (dystans, strefa, pora dnia, metoda płatności) najsilniej determinują wysokość napiwku? Czy klienci bezgotówkowi są bardziej dochodowi dla kierowców?
4. **Wąskie gardła i nieefektywności:** Czy istnieją trasy systemowo nieefektywne (wysoki czas przejazdu, bardzo krótki dystans, niski przychód)? Jak zmienia się czas przejazdu na kluczowych trasach w godzinach szczytu?

---

## 2. Architektura i Stack Techniczny
Projekt został zaprojektowany z myślą o separacji warstwy logicznej od prezentacji danych.

* **Język:** Python 3.12.3
* **Silnik analityczny baz danych:** DuckDB
* **Manipulacja i analiza danych:** Pandas, NumPy, SciPy
* **Wizualizacja:** Matplotlib, Seaborn
* **IDE:** PyCharm

### Schemat bazy danych
Analiza opiera się na relacyjnym modelu składającym się z dwóch tabel:
* `trips` – tabela faktów zawierająca rejestr podróży (źródło: NYC TLC Parquet) - yellow_tripdata_2026-03.parquet
* `zones` – tabela wymiarów mapująca identyfikatory lokalizacji na konkretne dzielnice i strefy - taxi_zone_lookup.csv

---
