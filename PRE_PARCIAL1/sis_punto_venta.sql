CREATE DATABASE IF NOT EXISTS sis_punto_venta;

CREATE TABLE PROVINCIAS (
    codpro VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(50),
    region_list ENUM('Norte', 'Sur', 'Este', 'Oeste'), -- Columna adicional tipo lista
    capital_status BOOLEAN, -- Columna adicional tipo si/no
    CONSTRAINT uk_provincia_nombre UNIQUE (nombre)
);