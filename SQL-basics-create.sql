USE sakila;
DROP TABLE IF EXISTS rating_analytics;
CREATE TABLE rating_analytics(
    rating VARCHAR(10),
    avg_rental_duration DECIMAL(5, 4),
    avg_rental_rate DECIMAL(7, 6),
    rentals SMALLINT,
    avg_film_length DECIMAL(4, 1)
);

INSERT INTO rating_analytics (
        SELECT rating,
    AVG(rental_duration),
    AVG(rental_rate) as avg_rental_rate,
    COUNT(rating) as rentals,
    AVG(length) as avg_lenght
FROM film
GROUP BY rating
ORDER BY rating
);

INSERT INTO rating_analytics
VALUES( NULL,
    (SELECT AVG(rental_duration) FROM film),
    (SELECT AVG(rental_rate) FROM film),
    (SELECT COUNT(film_id) FROM film),
    (SELECT AVG(length) FROM film));

SELECT * FROM rating_analytics
ORDER BY rating;