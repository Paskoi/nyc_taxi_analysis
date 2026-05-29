DESCRIBE trips;
DESCRIBE zones;

SELECT
    COUNT(*) AS total_trips,
    MIN(tpep_pickup_datetime) AS earliest_pickup,
    MAX(tpep_pickup_datetime) AS latest_pickup,
    ROUND(AVG(trip_distance), 2) AS avg_distance_miles,
    MAX(trip_distance) AS max_distance_miles,
    ROUND(AVG(total_amount), 2) AS avg_total_amount,
    MIN(total_amount) AS min_total_amount,
    MAX(total_amount) AS max_total_amount
FROM trips;

SELECT
    CASE payment_type
        WHEN 1 THEN 'Credit Card'
        WHEN 2 THEN 'Cash'
        WHEN 3 THEN 'No Charge'
        WHEN 4 THEN 'Dispute'
        WHEN 5 THEN 'Unknown (TLC 5)'
        WHEN 6 THEN 'Voided Trip'
        ELSE 'Unknown/System Error (0)'
    END AS payment_method,
    COUNT(*) AS trips_count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 2) AS pct_share
FROM trips
GROUP BY payment_type
ORDER BY trips_count DESC;

SELECT
    COUNT(t.PULocationID) AS trips_with_missing_pickup_zone
FROM trips t
LEFT JOIN zones z ON t.PULocationID = z.LocationID
WHERE z.LocationID IS NULL;

SELECT
    COUNT(*) AS total_records,

    SUM(CASE WHEN tpep_pickup_datetime < '2026-03-01 00:00:00'
              OR tpep_pickup_datetime >= '2026-04-01 00:00:00' THEN 1 ELSE 0 END) AS bad_dates,

    SUM(CASE WHEN trip_distance <= 0.05 OR trip_distance > 50 THEN 1 ELSE 0 END) AS bad_distance,

    SUM(CASE WHEN total_amount <= 0 OR total_amount > 400 THEN 1 ELSE 0 END) AS bad_amount,

    SUM(CASE WHEN fare_amount < 2.50 THEN 1 ELSE 0 END) AS below_min_fare,

    SUM(CASE WHEN epoch(tpep_dropoff_datetime - tpep_pickup_datetime) / 60 <= 1.0
              OR epoch(tpep_dropoff_datetime - tpep_pickup_datetime) / 60 > 180.0 THEN 1 ELSE 0 END) AS bad_duration,

    SUM(CASE WHEN passenger_count <= 0 OR passenger_count > 6 THEN 1 ELSE 0 END) AS bad_passenger_count,

    SUM(CASE WHEN payment_type = 0 THEN 1 ELSE 0 END) AS unknown_payment

FROM trips;