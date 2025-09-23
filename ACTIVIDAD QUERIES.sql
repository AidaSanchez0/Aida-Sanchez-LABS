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

-- EX12 -
SELECT f.title, COUNT(fa.actor_id) AS total_actores
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title
ORDER BY total_actores DESC;

-- EX13 -
SELECT s.store_id, AVG(p.amount) AS pago_promedio
FROM payment p
JOIN staff st ON p.staff_id = st.staff_id
JOIN store s ON st.store_id = s.store_id
GROUP BY s.store_id;

-- EX14 -
SELECT c.name AS categoria, COUNT(fc.film_id) AS total_peliculas
FROM category c
JOIN film_category fc ON c.category_id = fc.category_id
GROUP BY c.name
HAVING COUNT(fc.film_id) > 10;

-- EX15 -
SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name) AS cliente, COUNT(p.payment_id) AS total_pagos
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id
GROUP BY c.customer_id, cliente
HAVING COUNT(p.payment_id) > 5;

-- EX16 -
SELECT YEAR(payment_date) AS anio, AVG(amount) AS pago_promedio
FROM payment
GROUP BY YEAR(payment_date)
HAVING AVG(amount) > 20;

-- EX17 -
SELECT f.title, COUNT(fa.actor_id) AS total_actores
FROM film f
JOIN film_actor fa ON f.film_id = fa.film_id
GROUP BY f.film_id, f.title
HAVING COUNT(fa.actor_id) > 3;

-- EX18 -
SELECT DISTINCT rating
FROM film;

-- EX19 -
SELECT DISTINCT release_year
FROM film
ORDER BY release_year;

-- EX20 -
SELECT title
FROM film
WHERE title LIKE '%ARMAGEDDON%';

-- EX21 -
SELECT title
FROM film
WHERE title LIKE '%APOLLO%';

-- EX22 -
SELECT title
FROM film
WHERE title LIKE '%APOLLO';

-- EX23 -
SELECT title
FROM film
WHERE title LIKE '%DATE%';

-- EX24 -
SELECT title, LENGTH(title) AS longitud_titulo
FROM film
ORDER BY longitud_titulo DESC
LIMIT 10;

-- EX25 -
SELECT title, length
FROM film
ORDER BY length DESC
LIMIT 10;

-- EX26 -
SELECT COUNT(*) AS peliculas_behind_scenes
FROM film
WHERE FIND_IN_SET('Behind the Scenes', special_features);

-- EX27 -
SELECT release_year, title
FROM film
ORDER BY release_year, title;

