
-- 1. Actores con nombre Scarlett
SELECT actor_id, first_name, last_name
FROM actor
WHERE first_name = 'Scarlett';

-- 2. Actores con apellido Johansson
SELECT actor_id, first_name, last_name
FROM actor
WHERE last_name = 'Johansson';

-- 3. Películas disponibles para alquilar
SELECT COUNT(*) AS peliculas_disponibles
FROM inventory
WHERE inventory_in_stock(inventory_id);

-- 4. Películas alquiladas
SELECT COUNT(*) AS peliculas_alquiladas
FROM rental;

-- 5. Período de alquiler más corto y más largo
SELECT MIN(rental_duration) AS periodo_minimo,
       MAX(rental_duration) AS periodo_maximo
FROM film;

-- 6. Duración más corta y más larga de una película
SELECT MIN(length) AS min_duration,
       MAX(length) AS max_duration
FROM film;

-- 7. Duración media de una película
SELECT AVG(length) AS duracion_media
FROM film;

-- 8. Duración media en horas y minutos
SELECT CONCAT(FLOOR(AVG(length)/60), ' horas ', MOD(AVG(length),60), ' minutos') AS duracion_promedio
FROM film;

-- 9. Películas que duran más de 3 horas
SELECT COUNT(*) AS peliculas_mas_3h
FROM film
WHERE length > 180;

-- 10. Formatear nombre y correo electrónico de clientes
SELECT CONCAT(first_name, ' ', UPPER(last_name), ' - ', LOWER(first_name), '.', LOWER(last_name), '@sakilacustomer.org') AS nombre_formateado
FROM customer;

-- 11. Longitud del título más largo
SELECT MAX(LENGTH(title)) AS longitud_titulo_max
FROM film;