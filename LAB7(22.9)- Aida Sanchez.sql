-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema TikTok
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema TikTok
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `TikTok` DEFAULT CHARACTER SET utf8 ;
USE `TikTok` ;

-- -----------------------------------------------------
-- Table `TikTok`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Usuarios` (
  `id_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `email` VARCHAR(45) NULL,
  `fecha_registro` DATE NOT NULL,
  `pais_origen` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_usuario`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Videos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Videos` (
  `id_videos` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `titulo` VARCHAR(45) NOT NULL,
  `descripcion` LONGTEXT NULL,
  `fecha_publicacion` DATE NOT NULL,
  `duracion` TINYINT(60) NOT NULL,
  `Usuarios_id_usuario` INT NOT NULL,
  PRIMARY KEY (`id_videos`),
  INDEX `fk_Videos_Usuarios_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_Usuarios`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `TikTok`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Comentarios` (
  `id_comentario` INT NOT NULL AUTO_INCREMENT,
  `id_video` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `comentario` LONGTEXT NULL,
  `fecha_comienzo` DATE NOT NULL,
  PRIMARY KEY (`id_comentario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Likes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Likes` (
  `id_like` INT NOT NULL AUTO_INCREMENT,
  `id_video` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `fecha_like` DATE NOT NULL,
  PRIMARY KEY (`id_like`),
  INDEX `id_video_idx` (`id_video` ASC) VISIBLE,
  INDEX `id_usuario_idx` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `id_video`
    FOREIGN KEY (`id_video`)
    REFERENCES `TikTok`.`Videos` (`id_videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `TikTok`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Seguidores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Seguidores` (
  `id_seguidor` INT NOT NULL AUTO_INCREMENT,
  `id_usuario_seguido` INT NOT NULL,
  `id_usuario_seguidor` INT NOT NULL,
  `fecha_seguimiento` DATE NOT NULL,
  PRIMARY KEY (`id_seguidor`),
  INDEX `id_usuario_seguido_idx` (`id_usuario_seguido` ASC) VISIBLE,
  INDEX `id_usuario_seguidor_idx` (`id_usuario_seguidor` ASC) VISIBLE,
  CONSTRAINT `id_usuario_seguido`
    FOREIGN KEY (`id_usuario_seguido`)
    REFERENCES `TikTok`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_usuario_seguidor`
    FOREIGN KEY (`id_usuario_seguidor`)
    REFERENCES `TikTok`.`Usuarios` (`id_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `TikTok`.`Videos_Comentarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TikTok`.`Videos_Comentarios` (
  `Videos_id_videos` INT NOT NULL,
  `Comentarios_id_comentario` INT NOT NULL,
  PRIMARY KEY (`Videos_id_videos`, `Comentarios_id_comentario`),
  INDEX `fk_Videos_has_Comentarios_Comentarios1_idx` (`Comentarios_id_comentario` ASC) VISIBLE,
  INDEX `fk_Videos_has_Comentarios_Videos1_idx` (`Videos_id_videos` ASC) VISIBLE,
  CONSTRAINT `fk_Videos_has_Comentarios_Videos1`
    FOREIGN KEY (`Videos_id_videos`)
    REFERENCES `TikTok`.`Videos` (`id_videos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Videos_has_Comentarios_Comentarios1`
    FOREIGN KEY (`Comentarios_id_comentario`)
    REFERENCES `TikTok`.`Comentarios` (`id_comentario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

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