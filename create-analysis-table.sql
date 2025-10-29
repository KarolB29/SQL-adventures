-- CREATE ANALYTICS TABLE WITH ALL FILMS INCLUDED IN INVENTORY
USE sakila;
DROP TABLE IF EXISTS film_analytics;

CREATE TABLE film_analytics(
    film_id SMALLINT PRIMARY KEY,
    title VARCHAR(30),
    rating VARCHAR(5),
    release_year YEAR,
    actors VARCHAR(100),
    rentals SMALLINT,
    payments FLOAT
);

INSERT INTO film_analytics
SELECT
    f.film_id,
    f.title,
    f.rating,
    f.release_year,
    COALESCE(a.actors, 0) AS actors,
    COALESCE(r.rentals, 0) AS rentals,
    COALESCE(p.total_revenue, 0) AS total_revenue
FROM film f
LEFT JOIN (
    SELECT film_id, COUNT(DISTINCT actor_id) AS actors
    FROM film_actor
    GROUP BY film_id
) a ON f.film_id = a.film_id
LEFT JOIN (
    SELECT i.film_id, COUNT(DISTINCT r.rental_id) AS rentals
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY i.film_id
) r ON f.film_id = r.film_id
LEFT JOIN (
    SELECT i.film_id, SUM(p.amount) AS total_revenue
    FROM inventory i
    JOIN rental r ON i.inventory_id = r.inventory_id
    JOIN payment p ON r.rental_id = p.rental_id
    GROUP BY i.film_id
) p ON f.film_id = p.film_id
ORDER BY total_revenue DESC;

--  to find top 5 movies with greatest revenue.
SELECT
    fa.title,
    fa.rating,
    fa.rentals,
    fa.payments
FROM film_analytics fa
ORDER BY payments DESC
LIMIT 5;