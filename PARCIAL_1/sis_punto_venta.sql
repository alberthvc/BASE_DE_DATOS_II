
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

-- Describir estructura de todas las tablas
DESCRIBE PROVINCIAS;
DESCRIBE PUEBLOS;
DESCRIBE VENDEDORES;
DESCRIBE CLIENTES;
DESCRIBE ARTICULOS;
DESCRIBE FACTURA;
DESCRIBE LINEAS_FAC;

INSERT INTO PROVINCIAS (codpro, nombre, region_de_prv, disponib_cap) VALUES
('334', 'Panama', 'este', TRUE ),
('7654', 'Los Santos', 'sur', true),
('7549', 'Veraguas', 'sur', false),
('7659', 'Chiriqui', 'este', true),
('5532', 'Darien', 'oeste', true);

