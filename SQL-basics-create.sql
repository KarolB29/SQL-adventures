USE sakila
DROP TABLE IF EXISTS rating_analytics;
CREATE TABLE IF NOT EXISTS rating_analytics(
    rating VARCHAR(10),
    avg_rental_duration DECIMAL(6, 5),
    avg_rental_rate DECIMAL(6, 5),
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

SELECT * FROM rating_analytics
ORDER BY rentals DESC;