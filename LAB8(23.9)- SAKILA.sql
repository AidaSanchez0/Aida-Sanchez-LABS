-- EX1 --
SELECT COUNT(DISTINCT last_name) AS total_apellidos_distintos
FROM actor;

-- EX2 -
SELECT COUNT(DISTINCT language_id) AS idiomas_distintos
FROM film;

-- EX3 -
SELECT COUNT(*) AS peliculas_pg13
FROM film
WHERE rating = 'PG-13';

-- EX4 -
SELECT title, length
FROM film
WHERE release_year = 2006
ORDER BY length DESC
LIMIT 10;

-- EX5 -
SELECT DATEDIFF(CURDATE(), MIN(rental_date)) AS dias_funcionando
FROM rental;

-- EX6 -
SELECT rental_id,
       rental_date,
       MONTH(rental_date) AS mes,
       DAYNAME(rental_date) AS dia_semana
FROM rental
LIMIT 20;

-- EX7 -
SELECT rental_id,
       rental_date,
       DAYNAME(rental_date) AS dia_semana,
       CASE 
           WHEN DAYOFWEEK(rental_date) IN (1,7) THEN 'weekend'
           ELSE 'workday'
       END AS day_type
FROM rental
LIMIT 20;

-- EX8 -
SELECT COUNT(*) AS alquileres_ultimo_mes
FROM rental
WHERE MONTH(rental_date) = (
    SELECT MONTH(MAX(rental_date)) FROM rental
)
AND YEAR(rental_date) = (
    SELECT YEAR(MAX(rental_date)) FROM rental
);

-- EX9 -
SELECT c.name AS categoria, COUNT(f.film_id) AS total_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
JOIN film f ON fc.film_id = f.film_id
GROUP BY c.name
ORDER BY total_peliculas DESC;

-- EX10 -
SELECT c.customer_id,
       CONCAT(c.first_name, ' ', c.last_name) AS cliente,
       SUM(p.amount) AS ingresos_totales
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, cliente
ORDER BY ingresos_totales DESC;

-- EX11 -
SELECT release_year, COUNT(*) AS total_peliculas
FROM film
GROUP BY release_year
ORDER BY release_year;

-- PARAR EN EX11 -
