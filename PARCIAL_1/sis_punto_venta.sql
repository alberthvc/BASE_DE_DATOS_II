CREATE DATABASE IF NOT EXISTS sis_punto_venta

CREATE TABLE PROVINCIAS (
    codpro VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(50),
    CONSTRAINT uk_provincia_nombre UNIQUE (nombre)
);


CREATE TABLE PUEBLOS (
    codpue VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(50),
    codpro VARCHAR(5),
    FOREIGN KEY (codpro) REFERENCES PROVINCIAS(codpro),
    CONSTRAINT uk_pueblo_nombre UNIQUE (nombre)
);

CREATE TABLE VENDEDORES (
    codven VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100),
    codpostal VARCHAR(5),
    codpue VARCHAR(5),
    codjefe VARCHAR(5),
    FOREIGN KEY (codpue) REFERENCES PUEBLOS(codpue),
    FOREIGN KEY (codjefe) REFERENCES VENDEDORES(codven)
);

CREATE TABLE CLIENTES (
    codcli VARCHAR(5) PRIMARY KEY,
    nombre VARCHAR(50),
    direccion VARCHAR(100),
    codpostal VARCHAR(5),
    codpue VARCHAR(5),
    FOREIGN KEY (codpue) REFERENCES PUEBLOS(codpue)
);

CREATE TABLE ARTICULOS (
    codart VARCHAR(5) PRIMARY KEY,
    descrip VARCHAR(100),
    precio DECIMAL(10,2),
    stock INT,
    stock_min INT,
    dto DECIMAL(5,2),
    CONSTRAINT uk_articulo_descripcion UNIQUE (descrip)
);

CREATE TABLE FACTURA (
    codfact VARCHAR(5) PRIMARY KEY,
    fecha DATE,
    codcli VARCHAR(5),
    codven VARCHAR(5),
    iva DECIMAL(5,2),
    dto DECIMAL(5,2),
    FOREIGN KEY (codcli) REFERENCES CLIENTES(codcli),
    FOREIGN KEY (codven) REFERENCES VENDEDORES(codven)
);


CREATE TABLE LINEAS_FAC (
    codfac VARCHAR(5),
    linea INT,
    cant INT,
    codart VARCHAR(5),
    dto DECIMAL(5,2),
    precio DECIMAL(10,2),
    PRIMARY KEY (codfac, linea),
    FOREIGN KEY (codfac) REFERENCES FACTURA(codfact),
    FOREIGN KEY (codart) REFERENCES ARTICULOS(codart)
);

-- columnas adicionales
-- Para PROVINCIAS
ALTER TABLE PROVINCIAS
ADD COLUMN region_de_prv ENUM('norte', 'sur', 'este', 'oeste'), 
ADD COLUMN disponib_cap BOOLEAN; 

-- Para PUEBLOS
ALTER TABLE PUEBLOS
ADD COLUMN tipo_pueblo ENUM('Ciudad', 'Villa', 'Pueblo', 'Aldea'), 
ADD COLUMN tiene_mercado BOOLEAN; 

-- Para VENDEDORES
ALTER TABLE VENDEDORES
ADD COLUMN tipo_vendedor ENUM('Junior', 'Senior', 'Master'), 
ADD COLUMN activo BOOLEAN; 

-- Para CLIENTES
ALTER TABLE CLIENTES
ADD COLUMN tipo_cliente_list ENUM('regular', 'VIP', 'corporativo', 'especial', 'otro'),
ADD COLUMN credito_activo BOOLEAN; 

-- Para ARTICULOS
ALTER TABLE ARTICULOS
ADD COLUMN categoria_lst ENUM('electronica', 'ropa', 'alimentos', 'hogar'),
ADD COLUMN disponible BOOLEAN;

-- Para FACTURA
ALTER TABLE FACTURA
ADD COLUMN tipo_pago_list ENUM('efectivo', 'tarjeta', 'transferencia', 'yappy', 'credito'),
ADD COLUMN anulada BOOLEAN;

-- Para LINEAS_FAC
ALTER TABLE LINEAS_FAC
ADD COLUMN estado_list ENUM('pendiente', 'enviado', 'entregado', 'perdido'),
ADD COLUMN devuelto BOOLEAN;

-- Insercion de datos 

INSERT INTO PROVINCIAS (codpro, nombre, region_de_prv, disponib_cap) VALUES
('334', 'Panama', 'este', TRUE ),
('7654', 'Los Santos', 'sur', true),
('7549', 'Veraguas', 'sur', false),
('7659', 'Chiriqui', 'este', true),
('5532', 'Darien', 'oeste', true);


INSERT INTO PUEBLOS (codpue, nombre, codpro, tipo_pueblo, tiene_mercado) VALUES
('P101', 'Panama Centro', '334', 'Ciudad', true),
('P102', 'Las Tablas', '7654', 'Ciudad', true),
('P103', 'Santiago', '7549', 'Ciudad', true),
('P104', 'David', '7659', 'Ciudad', true),
('P105', 'La Palma', '5532', 'Villa', true);

INSERT INTO VENDEDORES (codven, nombre, direccion, codpostal, codpue, codjefe, tipo_vendedor, activo) VALUES
('V221', 'Juan Perez', 'via españa', '0801', 'P101', NULL, 'Master', true),
('V222', 'Ana Garcia', 'Calle 4ta Sur', '0401', 'P102', 'V221', 'Senior', true),
('V223', 'Luis Martinez', 'avenida central', '0301', 'P103', 'V221', 'Junior', true),
('V224', 'Maria Lopez', 'calle principal', '0201', 'P104', 'V222', 'Senior', true),
('V225', 'Carlos Ruiz', 'via interamericana', '0501', 'P105', 'V222', 'Junior', false);

INSERT INTO CLIENTES (codcli, nombre, direccion, codpostal, codpue, tipo_cliente_list, credito_activo) VALUES
('C441', 'Empresa ABC', 'costa del sur', '0801', 'P101', 'corporativo', true),
('C442', 'tienda XYZ', 'el camaron', '0401', 'P102', 'VIP', true),
('C443', 'Pedro Sanchez', 'la langosta', '0301', 'P103', 'regular', false),
('C444', 'Maria Gonzalez', 'por alli mas arriba', '0201', 'P104', 'especial', true),
('C445', 'Juan Lopez', 'el cangrejo', '0501', 'P105', 'otro', true);

INSERT INTO ARTICULOS (codart, descrip, precio, stock, stock_min, dto, categoria_lst, disponible) VALUES
('A771', 'DELL Alienware', 899.99, 50, 10, 5.00, 'electronica', true),
('A772', 'Victoria Secret', 29.99, 100, 20, 10.00, 'ropa', true),
('A773', 'sopa maruchan', 12.99, 200, 50, 0.00, 'alimentos', true),
('A774', 'paila de 50 libras', 199.99, 30, 5, 15.00, 'hogar', true),
('A775', 'iphone 25pro', 699.99, 40, 8, 7.50, 'electronica', false);

INSERT INTO FACTURA (codfact, fecha, codcli, codven, iva, dto, tipo_pago_list, anulada) VALUES
('F661', '2024-02-01', 'C441', 'V221', 7.00, 5.00, 'yappy', false),
('F662', '2024-02-05', 'C442', 'V222', 7.00, 0.00, 'efectivo', false),
('F663', '2024-02-10', 'C443', 'V223', 7.00, 10.00, 'transferencia', false),
('F664', '2024-02-15', 'C444', 'V224', 7.00, 7.50, 'credito', true),
('F665', '2024-02-20', 'C445', 'V225', 7.00, 2.50, 'tarjeta', false);

INSERT INTO LINEAS_FAC (codfac, linea, cant, codart, dto, precio, estado_list, devuelto) VALUES
('F661', 1, 2, 'A771', 5.00, 899.99, 'entregado', false),
('F662', 1, 5, 'A772', 10.00, 29.99, 'enviado', false),
('F663', 1, 10, 'A773', 0.00, 12.99, 'pendiente', false),
('F664', 1, 1, 'A774', 15.00, 199.99, 'perdido', true),
('F665', 1, 3, 'A775', 7.50, 699.99, 'enviado', false);

-- Describir estructura de todas las tablas
DESCRIBE PROVINCIAS;
DESCRIBE PUEBLOS;
DESCRIBE VENDEDORES;
DESCRIBE CLIENTES;
DESCRIBE ARTICULOS;
DESCRIBE FACTURA;
DESCRIBE LINEAS_FAC;