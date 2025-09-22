-- Insertar Usuarios
INSERT INTO usuarios (nombre, email, fecha_registro, pais_origen) VALUES
('juan123', 'juan@gmail.com', '2023-01-10', 'México'),
('maria99', 'maria@gmail.com', '2023-02-05', 'España'),
('lucho_t', 'lucho@gmail.com', '2023-03-12', 'Argentina'),
('ana_g', 'ana@gmail.com', '2023-04-01', 'Chile');

-- Insertar Videos
INSERT INTO videos (id_videos, id_usuario, titulo, descripcion, fecha_publicacion, duracion, Usuarios_id_usuario) VALUES
(1, 1, 'Primer baile', 'Mi primer video en TikTok', '2023-04-01', 30, 1),
(2, 2, 'Receta fácil', 'Cómo hacer una tortilla rápida', '2023-04-02', 45, 2),
(3, 3, 'Truco de magia', 'Desapareciendo una moneda', '2023-04-03', 60, 3);

-- Insertar Comentarios
INSERT INTO comentarios (id_video, id_usuario, comentario, fecha_comienzo) VALUES
(1, 2, 'Muy buen video!', '2023-04-05'),
(2, 1, 'Qué rico se ve!', '2023-04-06'),
(3, 2, 'Wow, impresionante!', '2023-04-07');

ALTER TABLE likes
MODIFY COLUMN fecha_like DATE NOT NULL;

-- Insertar Likes
INSERT INTO likes (id_video, id_usuario, fecha_like) VALUES
(1, 2, '2023-07-01'),
(2, 3, '2023-04-05'),
(3, 1, '2023-10-08');

-- Insertar Seguidores
INSERT INTO seguidores (id_usuario_seguido, id_usuario_seguidor, fecha_seguimiento) VALUES
(2, 1, '2023-04-01'),
(3, 2, '2023-04-02'),
(1, 3, '2023-04-03');

-- Insertar en Videos_Comentarios
INSERT INTO videos_has_comentarios (Videos_id_videos, Comentarios_id_comentario) VALUES
(1, 1),
(2, 2),
(3, 3);

SELECT * FROM usuarios;
SELECT * FROM videos;
SELECT * FROM comentarios;
SELECT * FROM likes;
SELECT * FROM seguidores;

 -- 3 QUERIES MÁS !!! ---
SELECT u.nombre, COUNT(v.id_videos) AS total_videos
FROM Usuarios u
LEFT JOIN Videos v ON u.id_usuario = v.id_usuario
GROUP BY u.nombre;

SELECT v.titulo, u.nombre AS autor, COUNT(l.id_like) AS total_likes
FROM Videos v
JOIN Usuarios u ON v.id_usuario = u.id_usuario
LEFT JOIN Likes l ON v.id_videos = l.id_video
GROUP BY v.id_videos, v.titulo, u.nombre
ORDER BY total_likes DESC;

SELECT u.nombre, COUNT(s.id_usuario_seguidor) AS total_seguidores
FROM Usuarios u
LEFT JOIN Seguidores s ON u.id_usuario = s.id_usuario_seguido
GROUP BY u.id_usuario, u.nombre
ORDER BY total_seguidores DESC;