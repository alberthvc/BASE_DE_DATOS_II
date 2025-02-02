CREATE DATABASE VideojuegosDB;
USE VideojuegosDB;

CREATE TABLE Videojuegos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(100) NOT NULL,
    genero VARCHAR(50),
    plataforma VARCHAR(50),
    lanzamiento DATE
);

INSERT INTO Videojuegos (nombre, genero, plataforma, lanzamiento)
VALUES 
    ('The Legend of Zelda: Breath of the Wild', 'Aventura', 'Nintendo Switch', '2017-03-03'),
    ('Cyberpunk 2077', 'RPG', 'PC', '2020-12-10'),
    ('Super Mario Odyssey', 'Aventura', 'Nintendo Switch', '2017-10-27'),
    ('Hades', 'Acción', 'PC, PlayStation 4, Nintendo Switch', '2020-09-17'),
    ('Grand Theft Auto V', 'Acción', 'PC, PlayStation 4, Xbox One', '2013-09-17');

SELECT * FROM Videojuegos;

UPDATE Videojuegos
SET plataforma = 'PC, PlayStation 5'
WHERE nombre = 'Cyberpunk 2077';

DELETE FROM Videojuegos
WHERE nombre = 'FIFA 23';
