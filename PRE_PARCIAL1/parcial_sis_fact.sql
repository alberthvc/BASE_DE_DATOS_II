CREATE DATABASE IF NOT EXISTS parcial_sis_fact;
USE parcial_sis_fact;

-- Tabla Producto: Agregamos más detalles del producto
CREATE TABLE IF NOT EXISTS  producto (
    producto_id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_producto VARCHAR(100) NOT NULL,
    otros_datos TEXT,
    tamano_id INT,
    categoria_producto_id INT,
    precio DECIMAL(10,2) NOT NULL,    -- Precio del producto
    stock_actual INT DEFAULT 0,        -- Stock actual
    descripcion_producto TEXT,         -- Descripción detallada
    marca VARCHAR(50),                 -- Marca del producto
    codigo_barras VARCHAR(50) UNIQUE,  -- Código de barras único
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tamano_id) REFERENCES tamano(tamano_id),
    FOREIGN KEY (categoria_producto_id) REFERENCES categorias_producto(categoria_producto_id)
);

-- Tabla Categorias de Producto: Agregamos fechas de gestión
CREATE TABLE categorias_producto (
    categoria_producto_id INT PRIMARY KEY AUTO_INCREMENT,
    categoria_id INT UNIQUE,
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    usuario_asignacion VARCHAR(50),
    estado_asignacion BOOLEAN DEFAULT true,
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

-- Tabla Tamaño: Agregamos mas detalles de medidas
CREATE TABLE tamano (
    tamano_id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_tamano VARCHAR(20) NOT NULL,
    clasificacion VARCHAR(50),
    medidas_cm VARCHAR(50),      -- Para especificar medidas exactas
    peso_aproximado DECIMAL(5,2), -- Para productos que varian por tamano
    descripcion_tamano TEXT,      -- Descripcion detallada del tamaño
    stock_minimo INT DEFAULT 5    -- Stock minimo por tamaño
);


-- creando tabla categorias/ se anadio la columna descripcion_categoria, estado_categoria
CREATE TABLE categoria (
    categoria_id INT PRIMARY KEY AUTO_INCREMENT,
    categoria_principal VARCHAR(100),
    nombre_categoria VARCHAR(100) NOT NULL,
    descripcion_categoria TEXT,
    estado_categoria BOOLEAN DEFAULT true,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- Tabla Color: Agregamos códigos de color y disponibilidad
CREATE TABLE color (
    color_id INT PRIMARY KEY AUTO_INCREMENT,
    codigo_color VARCHAR(20) NOT NULL,
    nombre_color VARCHAR(50) NOT NULL,
    codigo_hex VARCHAR(7),       -- Para guardar el código hexadecimal
    codigo_rgb VARCHAR(20),      -- Para guardar el código RGB
    disponible BOOLEAN DEFAULT true,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP
);


-- Tabla intermedia colores_producto: Agregamos detalles de la relación
CREATE TABLE colores_producto (
    color_producto_id INT PRIMARY KEY AUTO_INCREMENT,
    producto_id INT,
    color_id INT,
    cantidad_disponible INT DEFAULT 0,    -- Stock por color
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    estado_color_producto BOOLEAN DEFAULT true,  -- Si está activo este color para el producto
    FOREIGN KEY (producto_id) REFERENCES producto(producto_id),
    FOREIGN KEY (color_id) REFERENCES color(color_id)
);