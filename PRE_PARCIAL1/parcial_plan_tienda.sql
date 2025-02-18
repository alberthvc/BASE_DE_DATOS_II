-- Crear la base de datos
CREATE DATABASE IF NOT EXISTS parcial_plan_tienda;
-- USE parcial_plan_tienda;

-- Crear tabla REGION
CREATE TABLE IF NOT EXISTS REGION (
    REGION_CODE VARCHAR(10) PRIMARY KEY,  -- Identificador único para cada región
    REGION_DESCRIPT VARCHAR(100),  
    REGION_COUNTRY VARCHAR(50),  
    REGION_POPULATION INT  
);

-- Crear tabla STORE
CREATE TABLE IF NOT EXISTS STORE (
    STORE_CODE VARCHAR(10) PRIMARY KEY,  -- Identificador único para cada tienda
    STORE_NAME VARCHAR(100),  
    STORE_YTP_SALES DECIMAL(10,2),  
    REGION_CODE VARCHAR(10),  
    STORE_SIZE_SQM DECIMAL(8,2),  
    STORE_OPENING_DATE DATE,  
    FOREIGN KEY (REGION_CODE) REFERENCES REGION(REGION_CODE)  -- Relación con la tabla REGION
);

-- Crear tabla JOB
CREATE TABLE IF NOT EXISTS JOB (
    JOB_CODE VARCHAR(10) PRIMARY KEY,  -- Identificador único para cada puesto de trabajo
    JOB_DESCRIPTION VARCHAR(200),
    JOB_BASE_PAY DECIMAL(10,2),  
    JOB_REQUIREMENTS TEXT,  
    JOB_LEVEL VARCHAR(20)  
);

-- Crear tabla EMPLOYEE
CREATE TABLE IF NOT EXISTS EMPLOYEE (
    EMP_CODE VARCHAR(10) PRIMARY KEY,  -- Identificador único para cada empleado
    EMP_TITLE VARCHAR(10),  
    EMP_LNAME VARCHAR(50),  
    EMP_FNAME VARCHAR(50),  
    EMP_INITIAL CHAR(1),  
    EMP_DOB DATE,  
    JOB_CODE VARCHAR(10),
    STORE_CODE VARCHAR(10),  
    EMP_HIRE_DATE DATE,  
    EMP_SALARY DECIMAL(10,2),  
    FOREIGN KEY (JOB_CODE) REFERENCES JOB(JOB_CODE),  -- Relación con la tabla JOB
    FOREIGN KEY (STORE_CODE) REFERENCES STORE(STORE_CODE)  -- Relación con la tabla STORE
);

-- Insertar datos en REGION
INSERT INTO REGION (REGION_CODE, REGION_DESCRIPT, REGION_COUNTRY, REGION_POPULATION) VALUES
('R001', 'Norte', 'Argentina', 1500000),
('R002', 'Sur', 'Argentina', 900000),
('R003', 'Este', 'Argentina', 1200000),
('R004', 'Oeste', 'Argentina', 800000),
('R005', 'Centro', 'Argentina', 2000000),
('R006', 'Noroeste', 'Argentina', 600000),
('R007', 'Noreste', 'Argentina', 700000),
('R008', 'Patagonia', 'Argentina', 300000),
('R009', 'Litoral', 'Argentina', 950000),
('R010', 'Cuyo', 'Argentina', 550000),
('R011', 'Pampa', 'Argentina', 1100000);

-- Insertar datos en STORE
INSERT INTO STORE (STORE_CODE, STORE_NAME, STORE_YTP_SALES, REGION_CODE, STORE_SIZE_SQM, STORE_OPENING_DATE) VALUES
('S001', 'Tienda Norte', 50000.50, 'R001', 300.75, '2015-06-10'),
('S002', 'Tienda Sur', 32000.00, 'R002', 220.30, '2016-08-15'),
('S003', 'Tienda Este', 45000.75, 'R003', 250.00, '2014-09-20'),
('S004', 'Tienda Oeste', 28000.60, 'R004', 180.40, '2017-11-30'),
('S005', 'Tienda Centro', 60000.90, 'R005', 400.00, '2013-05-12'),
('S006', 'Tienda Noroeste', 15000.00, 'R006', 120.00, '2018-02-25'),
('S007', 'Tienda Noreste', 17000.80, 'R007', 140.50, '2019-07-19'),
('S008', 'Tienda Patagonia', 8000.50, 'R008', 90.25, '2020-10-05'),
('S009', 'Tienda Litoral', 29000.75, 'R009', 210.30, '2016-04-14'),
('S010', 'Tienda Cuyo', 23000.40, 'R010', 170.20, '2017-03-28'),
('S011', 'Tienda Pampa', 31000.10, 'R011', 190.75, '2015-12-08');

-- Insertar datos en JOB
INSERT INTO JOB (JOB_CODE, JOB_DESCRIPTION, JOB_BASE_PAY, JOB_REQUIREMENTS, JOB_LEVEL) VALUES
('J001', 'Cajero', 1200.50, 'Experiencia en caja registradora', 'Junior'),
('J002', 'Vendedor', 1400.75, 'Habilidades de atencion al cliente', 'Junior'),
('J003', 'Gerente de tienda', 2500.00, 'Experiencia en gestion de tiendas', 'Senior'),
('J004', 'Reponedor', 1100.30, 'Capacidad para cargar productos', 'Junior'),
('J005', 'Seguridad', 1350.40, 'Experiencia en seguridad privada', 'Medio'),
('J006', 'Administrador', 2700.90, 'Manejo de inventario y finanzas', 'Senior'),
('J007', 'Supervisor', 2000.60, 'Supervision de empleados', 'Medio'),
('J008', 'Contador', 2600.00, 'Titulo universitario en contabilidad', 'Senior'),
('J009', 'Limpieza', 1000.20, 'Experiencia en limpieza comercial', 'Junior'),
('J010', 'Marketing', 2300.70, 'Conocimiento en estrategias de marketing', 'Medio'),
('J011', 'Recursos Humanos', 2400.50, 'Gestion de empleados y seleccion de personal', 'Senior');

-- Insertar datos en EMPLOYEE
INSERT INTO EMPLOYEE (EMP_CODE, EMP_TITLE, EMP_LNAME, EMP_FNAME, EMP_INITIAL, EMP_DOB, JOB_CODE, STORE_CODE, EMP_HIRE_DATE, EMP_SALARY) VALUES
('E001', 'Sr.', 'Gonzalez', 'Carlos', 'A', '1990-05-12', 'J001', 'S001', '2021-03-15', 1250.50),
('E002', 'Sra.', 'Perez', 'Maria', 'B', '1985-11-22', 'J002', 'S002', '2019-07-01', 1450.75),
('E003', 'Sr.', 'Lopez', 'Juan', 'C', '1992-08-30', 'J003', 'S003', '2018-06-20', 2550.00),
('E004', 'Sra.', 'Fernandez', 'Ana', 'D', '1993-03-25', 'J004', 'S004', '2020-05-18', 1150.30),
('E005', 'Sr.', 'Martinez', 'Jose', 'E', '1988-12-10', 'J005', 'S005', '2016-09-10', 1380.40),
('E006', 'Sr.', 'Sanchez', 'Diego', 'F', '1995-07-14', 'J006', 'S006', '2022-01-07', 2750.90),
('E007', 'Sra.', 'Ramirez', 'Laura', 'G', '1991-04-05', 'J007', 'S007', '2017-10-28', 2050.60),
('E008', 'Sr.', 'Torres', 'Pedro', 'H', '1987-06-18', 'J008', 'S008', '2015-02-14', 2650.00),
('E009', 'Sra.', 'Rojas', 'Camila', 'I', '1994-09-03', 'J009', 'S009', '2021-08-23', 1050.20),
('E010', 'Sr.', 'Diaz', 'Fernando', 'J', '1986-01-21', 'J010', 'S010', '2019-12-12', 2350.70),
('E011', 'Sra.', 'Moreno', 'Valentina', 'K', '1990-10-08', 'J011', 'S011', '2018-04-06', 2450.50);

SELECT * FROM EMPLOYEE;