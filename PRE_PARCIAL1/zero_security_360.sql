-- Crear base de datos
CREATE DATABASE IF NOT EXISTS zero_security_360;
USE zero_security_360;

-- Tabla para almacenar los diferentes tipos de usuarios del sistema
CREATE TABLE TIPO_USUARIO (
    id_tipo_usuario INT PRIMARY KEY AUTO_INCREMENT,      -- Identificador unico del tipo de usuario
    nombre_tipo VARCHAR(50) NOT NULL,
    descripcion TEXT,
    permisos TEXT,
    fecha_creacion DATE DEFAULT CURRENT_DATE,
    estado BOOLEAN DEFAULT TRUE
);

-- Tabla principal de usuarios del sistema
CREATE TABLE USUARIO (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT, -- Identificador unico del usuario
    id_tipo_usuario INT,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    nombre_usuario VARCHAR(50) UNIQUE NOT NULL,
    token VARCHAR(255),
    contrasena VARCHAR(255) NOT NULL,
    ciudad VARCHAR(100),
    sexo CHAR(1),
    estado_civil VARCHAR(20),
    tipo_empresa VARCHAR(20),
    direccion TEXT,
    email VARCHAR(100) UNIQUE,                           
    telefono VARCHAR(20),                              
    FOREIGN KEY (id_tipo_usuario) REFERENCES TIPO_USUARIO(id_tipo_usuario)
);

-- Tabla para registro de sesiones y autenticacion
CREATE TABLE AUTENTICACION (
    id_autenticacion INT PRIMARY KEY AUTO_INCREMENT,     -- Identificador unico de la sesion
    id_usuario INT,
    nombre_usuario VARCHAR(50),
    contrasena VARCHAR(255),
    agente_usuario VARCHAR(255),
    fecha_login DATETIME DEFAULT CURRENT_TIMESTAMP,
    token VARCHAR(255),
    ip_address VARCHAR(45),
    estado_sesion VARCHAR(20),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- Catalogo de tipos de pruebas de seguridad
CREATE TABLE TIPO_PRUEBA (
    id_tipo_prueba INT PRIMARY KEY AUTO_INCREMENT,       -- Identificador unico del tipo de prueba
    referencia VARCHAR(50) UNIQUE,
    nombre VARCHAR(100),
    descripcion TEXT,
    fecha_ingreso DATE DEFAULT CURRENT_DATE,
    estado BOOLEAN DEFAULT TRUE,
    nivel_complejidad VARCHAR(20),
    duracion_estimada VARCHAR(50)
);

-- Registro de pruebas de seguridad realizadas
CREATE TABLE PRUEBA_SEGURIDAD (
    id_prueba INT PRIMARY KEY AUTO_INCREMENT, -- identificador unico de la prueba
    id_usuario INT,
    id_tipo_prueba INT,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    estado VARCHAR(20),
    costo DECIMAL(10,2),
    resultados TEXT,
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario),
    FOREIGN KEY (id_tipo_prueba) REFERENCES TIPO_PRUEBA(id_tipo_prueba)
);

-- Registro de pagos realizados
CREATE TABLE PAGO (
    id_pago INT PRIMARY KEY AUTO_INCREMENT,              -- Identificador unico del pago
    id_usuario INT,
    credit_card_number VARCHAR(16),
    cardholder_name VARCHAR(100),
    cvc VARCHAR(3),
    expiration DATE,
    monto DECIMAL(10,2),
    estado_transaccion VARCHAR(20),
    FOREIGN KEY (id_usuario) REFERENCES USUARIO(id_usuario)
);

-- Insertar tipos de usuario iniciales
INSERT INTO TIPO_USUARIO (nombre_tipo, descripcion) VALUES
('Cliente', 'Usuario que contrata servicios'),
('Administrador', 'Usuario con acceso total al sistema'),
('Vendedor', 'Usuario que gestiona ventas'),
('Ejecutivo', 'Usuario que supervisa operaciones'),
('Tecnico', 'Usuario que realiza pruebas de seguridad');

-- Insertar tipos de pruebas iniciales
INSERT INTO TIPO_PRUEBA (referencia, nombre, descripcion, estado) VALUES
('REC-001', 'Reconocimiento', 'Fase inicial de recopilacion de informacion', true),
('VUL-001', 'Analisis de vulnerabilidades', 'Identificacion de vulnerabilidades en sistemas', true),
('EXP-001', 'Explotacion', 'Pruebas de explotacion de vulnerabilidades', true),
('PRI-001', 'Escalar privilegios', 'Pruebas de escalacion de privilegios', true),
('POS-001', 'Post explotacion', 'Analisis post explotacion de vulnerabilidades', true);

-- Insertar usuarios de ejemplo
INSERT INTO USUARIO (id_tipo_usuario, nombre, apellido, nombre_usuario, contrasena, ciudad, tipo_empresa) VALUES
(1, 'Juan', 'Perez', 'jperez', 'hash123', 'Ciudad de Mexico', 'Privada'),
(2, 'Maria', 'Gonzalez', 'mgonzalez', 'hash456', 'Guadalajara', 'Publica'),
(3, 'Carlos', 'Ruiz', 'cruiz', 'hash789', 'Monterrey', 'Privada'),
(4, 'Ana', 'Martinez', 'amartinez', 'hash012', 'Puebla', 'Publica'),
(5, 'Roberto', 'Lopez', 'rlopez', 'hash345', 'Tijuana', 'Privada');

-- Insertar registros de autenticacion
INSERT INTO AUTENTICACION (id_usuario, nombre_usuario, agente_usuario, token) VALUES
(1, 'jperez', 'Chrome Windows', 'token123'),
(2, 'mgonzalez', 'Firefox Mac', 'token456'),
(3, 'cruiz', 'Safari iOS', 'token789'),
(4, 'amartinez', 'Chrome Android', 'token012'),
(5, 'rlopez', 'Edge Windows', 'token345');

-- Insertar pagos de ejemplo
INSERT INTO PAGO (id_usuario, credit_card_number, cardholder_name, cvc, expiration, monto) VALUES
(1, '4111111111111111', 'Juan Perez', '123', '2025-12-31', 1000.00),
(2, '5555555555554444', 'Maria Gonzalez', '456', '2025-11-30', 1500.00),
(3, '3782822463100005', 'Carlos Ruiz', '789', '2025-10-31', 2000.00),
(4, '6011111111111117', 'Ana Martinez', '012', '2025-09-30', 2500.00),
(5, '3566002020360505', 'Roberto Lopez', '345', '2025-08-31', 3000.00);

-- Insertar pruebas de seguridad de ejemplo
INSERT INTO PRUEBA_SEGURIDAD (id_usuario, id_tipo_prueba, fecha_inicio, estado, costo) VALUES
(1, 1, NOW(), 'En progreso', 1000.00),
(2, 2, NOW(), 'Pendiente', 1500.00),
(3, 3, NOW(), 'Completado', 2000.00),
(4, 4, NOW(), 'En revision', 2500.00),
(5, 5, NOW(), 'Aprobado', 3000.00);

-- comando para monstrar la descripcion de todas las columnas de mi base de datos
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, IS_NULLABLE, COLUMN_KEY 
FROM INFORMATION_SCHEMA.COLUMNS 
WHERE TABLE_SCHEMA = 'zero_security_360';