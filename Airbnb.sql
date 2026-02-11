/* =========================================================
   AIRBNB PRICING ANALYSIS PROJECT
   Database: MySQL
   ========================================================= */

/* ===============================
   1. CREATE DATABASE
   =============================== */

CREATE DATABASE IF NOT EXISTS airbnb_project;
USE airbnb_project;


/* ===============================
   2. CREATE TABLE
   =============================== */

CREATE TABLE airbnb_listings (
    listing_id INT AUTO_INCREMENT PRIMARY KEY,
    price_total DECIMAL(10,2),
    room_type VARCHAR(50),
    is_shared_room TINYINT,
    is_private_room TINYINT,
    max_guests INT,
    is_superhost TINYINT,
    is_multi_listing TINYINT,
    is_business_listing TINYINT,
    cleanliness_score DECIMAL(4,2),
    guest_satisfaction_score DECIMAL(5,2),
    num_bedrooms INT,
    distance_city_center DECIMAL(6,2),
    distance_metro DECIMAL(6,2),
    attraction_index DECIMAL(8,2),
    restaurant_index DECIMAL(8,2),
    longitude DECIMAL(10,6),
    latitude DECIMAL(10,6),
    city VARCHAR(100),
    district VARCHAR(100),
    state VARCHAR(100),
    country_name VARCHAR(100),
    Crime_Index DECIMAL(6,2),
    Safety_Index DECIMAL(6,2),
    Monthly_Average_Net_salary DECIMAL(12,2)
);


/* ===============================
   3. DATA VALIDATION QUERIES
   =============================== */

-- Total listings & price range
SELECT 
    COUNT(*) AS total_listings,
    ROUND(AVG(price_total),2) AS avg_price,
    ROUND(MIN(price_total),2) AS min_price,
    ROUND(MAX(price_total),2) AS max_price
FROM airbnb_listings;

-- Guest satisfaction range
SELECT 
    MIN(guest_satisfaction_score) AS min_satisfaction,
    MAX(guest_satisfaction_score) AS max_satisfaction
FROM airbnb_listings;

-- Cleanliness range
SELECT 
    MIN(cleanliness_score) AS min_cleanliness,
    MAX(cleanliness_score) AS max_cleanliness
FROM airbnb_listings;

-- Null checks
SELECT 
    COUNT(*) - COUNT(price_total) AS null_price,
    COUNT(*) - COUNT(city) AS null_city,
    COUNT(*) - COUNT(guest_satisfaction_score) AS null_satisfaction
FROM airbnb_listings;


/* ===============================
   4. BUSINESS ANALYSIS QUERIES
   =============================== */

-- Price by Room Type
SELECT 
    room_type,
    COUNT(*) AS total_listings,
    ROUND(AVG(price_total),2) AS avg_price
FROM airbnb_listings
GROUP BY room_type
ORDER BY avg_price DESC;

-- Superhost Impact
SELECT 
    is_superhost,
    COUNT(*) AS total_listings,
    ROUND(AVG(price_total),2) AS avg_price
FROM airbnb_listings
GROUP BY is_superhost;

-- Price by Bedrooms
SELECT 
    num_bedrooms,
    COUNT(*) AS total_listings,
    ROUND(AVG(price_total),2) AS avg_price
FROM airbnb_listings
GROUP BY num_bedrooms
ORDER BY num_bedrooms;

-- Distance vs Price
SELECT 
    ROUND(distance_city_center,0) AS rounded_distance,
    COUNT(*) AS total_listings,
    ROUND(AVG(price_total),2) AS avg_price
FROM airbnb_listings
GROUP BY rounded_distance
ORDER BY rounded_distance;


/* ===============================
   5. CREATE ANALYTICAL VIEW
   =============================== */

CREATE VIEW vw_airbnb_analysis AS
SELECT
    listing_id,
    price_total,
    room_type,
    max_guests,
    num_bedrooms,
    is_superhost,
    is_multi_listing,
    is_business_listing,
    cleanliness_score,
    guest_satisfaction_score,
    distance_city_center,
    distance_metro,
    attraction_index,
    restaurant_index,
    city,
    district,
    state,
    country_name,
    Crime_Index,
    Safety_Index,
    Monthly_Average_Net_salary
FROM airbnb_listings;
