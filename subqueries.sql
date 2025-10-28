SELECT * FROM rating_analytics;

# Znajdź te ratingi, które są wyższe od średniej wyznaczonej dla wszystkich filmów, bez podziału na rating.
# Find all ratings that have rental_rate higher than an average of all ratings rental_rates together.

SELECT IFNULL(rating, 'ALL RATINGS') as rating,
       avg_rental_rate
FROM rating_analytics
WHERE avg_rental_rate > (SELECT avg_rental_rate FROM rating_analytics WHERE rating IS NULL) OR rating IS NULL
ORDER BY avg_rental_rate DESC;

# Znajdź te ratingi, których średni czas wypożyczenia jest krótszy od średniej globalnej.
# Find ratings, which avg_rental_duration is shorter than average of all ratings.

SELECT IFNULL(rating, 'ALL RATINGS') as rating,
       avg_rental_duration
FROM rating_analytics
WHERE avg_rental_duration < (SELECT avg_rental_duration FROM rating_analytics WHERE rating IS NULL) OR rating IS NULL
ORDER BY avg_rental_duration DESC;

# Używając podzapytania wyświetl statystyki dla id_rating = 3
# Using only subquery find stats for id_rating = 3
SELECT *
FROM rating_analytics
WHERE rating = (SELECT rating FROM rating WHERE id_rating = 3);

# Używając podzapytania wyświetl statystyki dla id_rating = 3, 2, 5.
# Using subquery find stats for id_rating = 3, 2, 5.
SELECT *
FROM rating_analytics
WHERE rating IN (SELECT rating FROM rating WHERE id_rating IN (3, 2, 5))
ORDER BY rentals DESC; -- returns ratings with most movies in inventory
