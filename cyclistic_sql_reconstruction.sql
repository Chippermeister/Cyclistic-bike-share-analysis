-- ============================================================
-- Cyclistic Bike-Share Capstone — Reconstructed SQL
-- Project: cyclistic-489918
-- NOTE: Reconstructed from the case study roadmap description.
-- Replace dataset/table names below with your actual ones,
-- and verify each query still matches what you originally ran.
-- ============================================================


-- STEP 1: PREPARE
-- Combine each month's trip data into one table with UNION ALL
-- ------------------------------------------------------------
CREATE TABLE `cyclistic-489918.cyclistic_data.all_trips` AS
SELECT * FROM `cyclistic-489918.cyclistic_data.202101_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202102_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202103_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202104_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202105_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202106_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202107_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202108_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202109_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202110_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202111_divvy_tripdata`
UNION ALL
SELECT * FROM `cyclistic-489918.cyclistic_data.202112_divvy_tripdata`;


-- STEP 2: PROCESS — check for duplicate ride IDs
-- (Your roadmap notes you checked and found none)
-- ------------------------------------------------------------
SELECT ride_id, COUNT(*) AS occurrences
FROM `cyclistic-489918.cyclistic_data.all_trips`
GROUP BY ride_id
HAVING COUNT(*) > 1;


-- STEP 3: PROCESS — add ride length (duration) and day of week
-- ------------------------------------------------------------
CREATE OR REPLACE TABLE `cyclistic-489918.cyclistic_data.all_trips_clean` AS
SELECT
  *,
  TIMESTAMP_DIFF(ended_at, started_at, MINUTE) AS ride_length,
  FORMAT_DATE('%A', DATE(started_at)) AS day_of_week
FROM `cyclistic-489918.cyclistic_data.all_trips`;


-- STEP 4: PROCESS — check for null values in key location columns
-- (Your roadmap notes null values turned up in location data)
-- ------------------------------------------------------------
SELECT COUNT(*) AS rows_with_null_stations
FROM `cyclistic-489918.cyclistic_data.all_trips_clean`
WHERE start_station_name IS NULL
   OR end_station_name IS NULL;


-- STEP 5: PROCESS — filter out bad/test rides before analysis
-- (negative or zero-length rides, and Divvy's internal test/
-- maintenance station entries)
-- ------------------------------------------------------------
CREATE OR REPLACE TABLE `cyclistic-489918.cyclistic_data.all_trips_final` AS
SELECT *
FROM `cyclistic-489918.cyclistic_data.all_trips_clean`
WHERE ride_length > 0
  AND start_station_name NOT LIKE '%TEST%';


-- ============================================================
-- STEP 6: ANALYZE — the 5 questions from the write-up
-- ============================================================

-- Q1: Do casuals or members ride more?
SELECT
  member_casual,
  COUNT(ride_id) AS number_of_rides,
  ROUND(COUNT(ride_id) * 100.0 / SUM(COUNT(ride_id)) OVER (), 1) AS pct_of_total
FROM `cyclistic-489918.cyclistic_data.all_trips_final`
GROUP BY member_casual;

-- Q2: Do casuals or members ride more on weekdays vs. weekends?
SELECT
  member_casual,
  CASE
    WHEN day_of_week IN ('Saturday', 'Sunday') THEN 'Weekend'
    ELSE 'Weekday'
  END AS day_type,
  COUNT(ride_id) AS number_of_rides
FROM `cyclistic-489918.cyclistic_data.all_trips_final`
GROUP BY member_casual, day_type
ORDER BY member_casual, day_type;

-- Q3: How often do rides end where they started (round trips)?
SELECT
  member_casual,
  COUNTIF(start_station_id = end_station_id) AS round_trips,
  COUNT(ride_id) AS total_rides,
  ROUND(COUNTIF(start_station_id = end_station_id) * 100.0 / COUNT(ride_id), 2) AS pct_round_trips
FROM `cyclistic-489918.cyclistic_data.all_trips_final`
GROUP BY member_casual;

-- Q4: Do casuals or members take longer rides?
SELECT
  member_casual,
  ROUND(AVG(ride_length), 1) AS avg_ride_length_minutes,
  ROUND(APPROX_QUANTILES(ride_length, 2)[OFFSET(1)], 1) AS median_ride_length_minutes
FROM `cyclistic-489918.cyclistic_data.all_trips_final`
GROUP BY member_casual;

-- Q5: Do casuals or members prefer classic or electric bikes?
SELECT
  member_casual,
  rideable_type,
  COUNT(ride_id) AS number_of_rides
FROM `cyclistic-489918.cyclistic_data.all_trips_final`
GROUP BY member_casual, rideable_type
ORDER BY member_casual, number_of_rides DESC;

-- Supporting: seasonal trend across the year
-- (supports: "both ride types ride more in summer, less in winter")
SELECT
  FORMAT_DATE('%Y-%m', DATE(started_at)) AS ride_month,
  member_casual,
  COUNT(ride_id) AS number_of_rides
FROM `cyclistic-489918.cyclistic_data.all_trips_final`
GROUP BY ride_month, member_casual
ORDER BY ride_month, member_casual;

-- Supporting: starting locations for casual riders, for the
-- downtown/river district heatmap in Tableau
SELECT
  start_station_name,
  start_lat,
  start_lng,
  COUNT(ride_id) AS number_of_rides
FROM `cyclistic-489918.cyclistic_data.all_trips_final`
WHERE member_casual = 'casual'
GROUP BY start_station_name, start_lat, start_lng
ORDER BY number_of_rides DESC;
