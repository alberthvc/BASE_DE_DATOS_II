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
