CREATE DATABASE IF NOT EXISTS parcial_sis_fact;
USE parcial_sis_fact;

-- Crear tabla productos
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
    codigo_barras VARCHAR(50) UNIQUE,  -- Código de barras unico
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (tamano_id) REFERENCES tamano(tamano_id),
    FOREIGN KEY (categoria_producto_id) REFERENCES categorias_producto(categoria_producto_id)
);

-- Tabla categorias de producto / agregamos fechas de gestion
CREATE TABLE categorias_producto (
    categoria_producto_id INT PRIMARY KEY AUTO_INCREMENT,
    categoria_id INT UNIQUE,
    fecha_asignacion DATETIME DEFAULT CURRENT_TIMESTAMP, --fecha de gestion
    usuario_asignacion VARCHAR(50),
    estado_asignacion BOOLEAN DEFAULT true,
    FOREIGN KEY (categoria_id) REFERENCES categoria(categoria_id)
);

-- Tabla tamano / 2 columnas con mas detalles de las medidas
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


-- Tabla color, agragamos codigos de colores y disponibilidad
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
-- Primero insertamos las categorias
INSERT INTO categoria (categoria_principal, nombre_categoria, descripcion_categoria, estado_categoria) VALUES 
('Ropa', 'Camisetas', 'Todo tipo de camisetas casual y formal', true),
('Ropa', 'Pantalones', 'Pantalones de diferentes estilos', true),
('Calzado', 'Deportivo', 'Calzado para actividades deportivas', true),
('Calzado', 'Casual', 'Calzado para uso diario', true),
('Accesorios', 'Bolsos', 'Bolsos y carteras de moda', true),
('Accesorios', 'Cinturones', 'Cinturones de cuero y sintéticos', true),
('Deportes', 'Equipamiento', 'Equipo deportivo variado', true),
('Ropa', 'Chaquetas', 'Chaquetas para toda temporada', true),
('Ropa', 'Vestidos', 'Vestidos casuales y formales', true),
('Accesorios', 'Gorras', 'Gorras y sombreros de moda', true);

-- Insertamos categorias de producto
INSERT INTO categorias_producto (categoria_id, usuario_asignacion) VALUES 
(1, 'admin1'),
(2, 'admin2'),
(3, 'admin1'),
(4, 'admin2'),
(5, 'admin1'),
(6, 'admin2'),
(7, 'admin1'),
(8, 'admin2'),
(9, 'admin1'),
(10, 'admin2');

-- 3. Insertamos tamanos
INSERT INTO tamano (codigo_tamano, clasificacion, medidas_cm, peso_aproximado, descripcion_tamano) VALUES 
('XS', 'Extra Pequeño', '45x65', 0.15, 'Talla extra pequeña'),
('S', 'Pequeño', '50x70', 0.20, 'Talla pequeña'),
('M', 'Mediano', '55x75', 0.25, 'Talla mediana'),
('L', 'Grande', '60x80', 0.30, 'Talla grande'),
('XL', 'Extra Grande', '65x85', 0.35, 'Talla extra grande'),
('36', 'Calzado Pequeño', '23.5', 0.40, 'Talla 36 calzado'),
('38', 'Calzado Mediano', '24.5', 0.45, 'Talla 38 calzado'),
('40', 'Calzado Grande', '25.5', 0.50, 'Talla 40 calzado'),
('42', 'Calzado Extra Grande', '26.5', 0.55, 'Talla 42 calzado'),
('U', 'Talla Única', 'N/A', 0.25, 'Talla única ajustable');

-- 4. Insertamos colores
INSERT INTO color (codigo_color, nombre_color, codigo_hex, codigo_rgb) VALUES 
('RED', 'Rojo', '#FF0000', '255,0,0'),
('BLU', 'Azul', '#0000FF', '0,0,255'),
('BLK', 'Negro', '#000000', '0,0,0'),
('WHT', 'Blanco', '#FFFFFF', '255,255,255'),
('GRY', 'Gris', '#808080', '128,128,128'),
('GRN', 'Verde', '#00FF00', '0,255,0'),
('YLW', 'Amarillo', '#FFFF00', '255,255,0'),
('PNK', 'Rosa', '#FFC0CB', '255,192,203'),
('PRP', 'Morado', '#800080', '128,0,128'),
('BRW', 'Marrón', '#A52A2A', '165,42,42');

-- 5. Insertamos productos
INSERT INTO producto (nombre_producto, descripcion_producto, precio, stock_actual, marca, codigo_barras, tamano_id, categoria_producto_id) VALUES 
('Camiseta Básica', 'Camiseta de algodón 100%', 29.99, 100, 'MarcaX', 'BAR123456', 3, 1),
('Pantalón Vaquero', 'Jeans clásico azul', 59.99, 75, 'DenimCo', 'BAR789012', 4, 2),
('Zapatillas Running', 'Zapatillas para correr', 89.99, 50, 'SportMax', 'BAR345678', 7, 3),
('Mocasines Casual', 'Mocasines de cuero', 79.99, 30, 'ComfortShoe', 'BAR901234', 8, 4),
('Bolso Tote', 'Bolso grande casual', 49.99, 25, 'BagStyle', 'BAR567890', 10, 5),
('Cinturón Cuero', 'Cinturón de cuero negro', 39.99, 60, 'LeatherCo', 'BAR123789', 10, 6),
('Balón Fútbol', 'Balón profesional', 29.99, 40, 'SportPro', 'BAR456123', 10, 7),
('Chaqueta Invierno', 'Chaqueta acolchada', 99.99, 35, 'WinterStyle', 'BAR789456', 4, 8),
('Vestido Floral', 'Vestido estampado primavera', 69.99, 45, 'DressUp', 'BAR234567', 3, 9),
('Gorra Baseball', 'Gorra ajustable', 24.99, 80, 'CapPro', 'BAR890123', 10, 10);

-- 6. Insertamos relaciones de colores y productos
INSERT INTO colores_producto (producto_id, color_id, cantidad_disponible) VALUES 
(1, 1, 20), -- Camiseta en Rojo
(1, 2, 20), -- Camiseta en Azul
(2, 3, 25), -- Pantalón en Negro
(2, 5, 25), -- Pantalón en Gris
(3, 3, 15), -- Zapatillas en Negro
(3, 4, 15), -- Zapatillas en Blanco
(4, 3, 15), -- Mocasines en Negro
(4, 10, 15), -- Mocasines en Marrón
(5, 3, 10), -- Bolso en Negro
(5, 10, 10); -- Bolso en Marrón