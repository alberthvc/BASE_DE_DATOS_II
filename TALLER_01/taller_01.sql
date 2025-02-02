
CREATE DATABASE taller_01;
use taller_01;


 */
CREATE TABLE ordes(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255)
);

CREATE TABLE categories(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255)
);

CREATE TABLE furnitures(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	manufacture_date DATE
);

CREATE TABLE foods(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	expiration_date DATE,
	calories INT
);

CREATE TABLE products(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(255),
	price FLOAT,
	categories_id INT,
	foods_id INT,
	furnitures_id INT,
	
	FOREIGN KEY (categories_id) REFERENCES categories(id),
	FOREIGN KEY (foods_id) REFERENCES foods(id),
	FOREIGN KEY (furnitures_id) REFERENCES furnitures(id)
);


CREATE TABLE orders_lines(
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	quantity FLOAT,
	products_id INT,
	ordes_id INT,
	
	FOREIGN KEY (products_id) REFERENCES products(id),
	FOREIGN KEY (ordes_id) REFERENCES ordes(id)
);



INSERT INTO taller_01.ordes (name) VALUES
	 ('navidad'),
	 ('anio nuevo chino'),
	 ('semana santa'),
	 ('escolar'),
	 ('fiesta patrias');

-- Forma 2 de insertar varios registros
INSERT INTO taller_01.categories (id, name) VALUES(1, 'ccomida');
INSERT INTO taller_01.categories (id, name) VALUES(2, 'electrodomestico');
INSERT INTO taller_01.categories (id, name) VALUES(3, 'hogar');
INSERT INTO taller_01.categories (id, name) VALUES(4, 'cosmeticos');
INSERT INTO taller_01.categories (id, name) VALUES(5, 'jugueteria');

INSERT INTO taller_01.foods (expiration_date, calories) VALUES
	 ('2024-12-31', 100),
	 ('2024-10-31', 500),
     ('2025-01-31', 300),
     ('2026-12-31', 900),
     ('2027-12-31', 700);
    
INSERT INTO taller_01.furnitures (manufacture_date) VALUES
	('2024-12-31'),
	('2025-12-31'),
	('2026-12-31'),
	('2027-12-31'),
	('2028-12-31');

INSERT INTO taller_01.products (name,price,categories_id,foods_id,furnitures_id) VALUES
	 ('Carrito de HotGof',2000.0,1,1,1),
	 ('TV',1890.0,2,2,2),
	 ('Cama Grande',8.0,3,3,4),
	 ('Adidas X90',135.0,4,4,4),
	 ('Closet de Ropa ',2893.0,5,5,5);


INSERT INTO taller_01.orders_lines (quantity,products_id,ordes_id) VALUES
	 (4987.0,1,3),
	 (2138.0,2,5),
	 (10.0,4,2),
	 (485.0,5,1),
	 (32987.0,4,4);