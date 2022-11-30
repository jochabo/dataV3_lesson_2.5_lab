USE sakila;

-- 1. Select all the actors with the first name ‘Scarlett’.
SELECT * FROM actor;
SELECT * FROM actor WHERE first_name = 'Scarlett';

-- 2. How many films (movies) are available for rent and how many films have been rented?
-- Interpretation:
-- How many films are available for rent = How many titles are available for rent.
SELECT * FROM film;
SELECT COUNT(DISTINCT film_id) FROM film;

-- How many titles are available in the inventory for rent.
SELECT * FROM inventory;
SELECT COUNT(DISTINCT film_id) FROM inventory;

-- How many films have been rented = How many of the inventory films have been rented.
SELECT * FROM rental;
SELECT * FROM film;
SELECT COUNT(DISTINCT inventory_id) FROM rental;

-- 3. What are the shortest and longest movie duration? Name the values max_duration and min_duration.
SELECT MAX(length) AS max_duration, MIN(length) AS min_duration FROM film;

-- 4. What's the average movie duration expressed in format (hours, minutes)?
SELECT round(AVG(length)) AS avg_duration FROM film;
SELECT CONCAT(FLOOR(round(AVG(length))/60),'h',MOD(round(AVG(length)),60),'m') AS avg_duration FROM film;

-- 5. How many distinct (different) actors' last names are there?
SELECT * FROM actor;

SELECT COUNT(DISTINCT last_name)
FROM sakila.actor;

-- 6. Since how many days has the company been operating (check DATEDIFF() function)?
SELECT * FROM rental;
SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS 'Operating Days' FROM rental;

-- 7. Show rental info with additional columns month and weekday. Get 20 results.
SELECT * FROM rental;
SELECT 
    *,
    DATE_FORMAT(CONVERT( LEFT(rental_date, 10) , DATE),
            '%M') AS 'rental_date_month',
    DATE_FORMAT(CONVERT( LEFT(rental_date, 10) , DATE),
            '%W') AS 'rental_date_weekday'
FROM
    rental LIMIT 20;

-- 8. Add an additional column day_type with values 'weekend' and 'workday' depending on the rental day of the week.

SELECT 
    *,
    DATE_FORMAT(CONVERT( LEFT(rental_date, 10) , DATE),
            '%M') AS 'rental_date_month',
    DATE_FORMAT(CONVERT( LEFT(rental_date, 10) , DATE),
            '%W') AS 'rental_date_weekday',
    CASE
        WHEN
            DATE_FORMAT(CONVERT( LEFT(rental_date, 10) , DATE),
                    '%W') = 'Saturday'
                OR 'Sunday'
        THEN
            'weekend'
        ELSE 'workday'
    END AS 'rental_date_day_type'
FROM
    rental;

-- 9. Get release years.
SELECT * FROM film;
SELECT release_year FROM film;

-- 10. Get all films with ARMAGEDDON in the title.
SELECT * FROM film;
SELECT * FROM film WHERE title LIKE '%ARMAGEDDON%';

-- 11. Get all films which title ends with APOLLO.
SELECT * FROM film;
SELECT * FROM film WHERE title LIKE '%APOLLO';

-- 12. Get 10 the longest films.
SELECT * FROM film;
SELECT * FROM film ORDER BY length DESC LIMIT 10;

-- 13. How many films include Behind the Scenes content?
SELECT * FROM film;
SELECT COUNT(film_id) FROM film WHERE special_features Like '%Behind the Scenes%';