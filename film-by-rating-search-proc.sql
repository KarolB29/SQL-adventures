-- Create function to search for amount of films with given rating, eg. PG-13

USE sakila;

DELIMITER $$

DROP PROCEDURE IF EXISTS CountFilmsByRating;
CREATE PROCEDURE CountFilmsByRating(IN rating_value VARCHAR(10))
BEGIN
    DECLARE film_count INT;

    SELECT COUNT(*) INTO film_count
    FROM film
    WHERE rating = rating_value;

    SELECT title, release_year
    FROM film
    WHERE rating = rating_value
    ORDER BY release_year DESC
    LIMIT 5;

    SELECT CONCAT(film_count, ' films were found by ','"' ,rating_value,'"', ' rating') AS info;
END$$

DELIMITER ;

CALL CountFilmsByRating('PG-13');