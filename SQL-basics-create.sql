DROP TABLE IF EXISTS rating_analytics;
CREATE TABLE IF NOT EXISTS rating_analytics(
    rating VARCHAR(10),
    avg_rental_duration FLOAT,
    avg_rental_rate FLOAT,
    rentals MEDIUMINT,
    avg_film_length FLOAT
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

select * from rating_analytics
ORDER BY rentals DESC;