create database bd_reservacancha;

use bd_reservacancha;

create table establecimientos (
    id_establecimiento int primary key auto_increment,
    nombre varchar(100) not null,
    ubicacion varchar(100) not null,
    numero_cancha int not null,
    dueno int, 
    telefono varchar(20),
    capacidad int,
    FOREIGN KEY (dueno) REFERENCES usuarios_duenos(id_usuario)
);

create table deportes (
    id_deporte int primary key auto_increment,
    nombre varchar(100) not null,
    tipo varchar(50),
    imagen varchar(100),
    icono varchar(100),
    clasificacion varchar(50),
    cancha_asociada int, 
    foreign key (cancha_asociada) references canchas(id_cancha) 
);

create table canchas (
    id_cancha int primary key auto_increment,
    nombre varchar(100) not null,
    tarifa decimal(10, 2) not null,
    capacidad INT not null,
    establecimiento int,  
    FOREIGN KEY (establecimiento) REFERENCES establecimientos(id_establecimiento)
);

create table usuarios_duenos (
    id_usuario int primary key auto_increment,
    nombre varchar(100) not null,
    nombre_usuario varchar(50) not null unique,
    contraseña varchar(100) not null,
    estado varchar(20),
    perfil varchar(50),
    correo varchar(100),
    ultima_ingreso datetime,
    dueno BOOLEAN  -- Valor booleano para identificar dueño
);

create table deporte_Favorito (
    id_favorito int primary key auto_increment,
    nombre varchar(100),
    deporte int,  
    usuario int,  
    descripcion TEXT,
    FOREIGN KEY (deporte) REFERENCES deportes(id_deporte),
    FOREIGN KEY (usuario) REFERENCES usuarios_duenos(id_usuario)
);

create table forma_pago (
    id_pago int primary key auto_increment,
    nombre varchar(100),
    usuario int,  
    establecimiento int,  
    cancha int,  
    FOREIGN KEY (usuario) REFERENCES usuarios_duenos(id_usuario),
    FOREIGN KEY (establecimiento) REFERENCES establecimientos(id_establecimiento),
    FOREIGN KEY (cancha) REFERENCES canchas(id_cancha)
);
-- Agregamos 2 columnas (edad y nacionalidad) a la tabla de usuarios_duenos
ALTER TABLE usuarios_duenos add edad int;
ALTER TABLE usuarios_duenos add nacionalidad varchar(50);

-- Crear y consultar usuarios_duenos
insert into usuarios_duenos (nombre, nombre_usuario, contraseña, estado, perfil, correo, ultima_ingreso, dueno, edad, nacionalidad) values
('Jose Lorenzo', 'jlo', 'Password1234', 'Casado', 'Administrador', 'jocfran12@gmail.com', '2025-02-20 12:00:00', '1', '39', 'Panamameña' );
insert into usuarios_duenos (nombre, nombre_usuario, contraseña, estado, perfil, correo, ultima_ingreso, dueno, edad, nacionalidad) values
('Mario Morales', 'mamorales', 'Pass2035', 'Soltero', 'Usuario', 'mario.morales@gmail.com', '2025-02-20 13:00:00', '0', '25', 'Portugues' );

select * from usuarios_duenos;

-- Creacion de un establecimiento
insert into establecimientos (nombre, ubicacion, numero_cancha, dueno, telefono, capacidad) values
('Sport Soccer', 'Costa del Este', '4', '1', '221-2074', '10' );
insert into establecimientos (nombre, ubicacion, numero_cancha, dueno, telefono, capacidad) values
('MVP SPort', 'San Antonio', '5', '2', '221-2025', '40' );
select * from establecimientos;

-- Creacion de un deporte
insert into deportes (nombre, tipo, imagen, icono, clasificacion, cancha_asociada ) values
('Futbol', 'aficionado', 'balon de futbol', 'Pelota', 'de cancha', '10' );

select * from deportes;

-- Creacion de una cacha
insert into canchas (nombre, tarifa, capacidad, establecimiento ) values
('futbol', '45.50', '8', 2);
insert into canchas (nombre, tarifa, capacidad, establecimiento ) values
('futbol23', '100.00', '20', 3);

select * from canchas;

-- creacion de deporte
INSERT INTO deporte_favorito (nombre, deporte, usuario, descripcion)
VALUES ('Fútbol', 4, 2, 'Deporte favoritos de los jovenes');

-- consulta de deporte
select * from deporte_favorito;

INSERT INTO  forma_pago(nombre, usuario, establecimiento, cancha)
VALUES ('Jose Lorenzo', '1', 3, 11);

select * from forma_pago;

-- Consulta Establecer un usuario a un establecimiento con su deporte y cancha
SELECT id_usuario, id_establecimiento, id_deporte, nombre_usuario, id_cancha FROM usuarios_duenos, establecimientos, deportes, canchas;