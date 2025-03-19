CREATE DATABASE IF NOT EXISTS xyz_company;
USE xyz_company;

CREATE TABLE perfiles (
    id_perfil INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    fecha_vigencia DATE NOT NULL,
    descripcion TEXT,
    encargado VARCHAR(100)
);
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    id_perfil INT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    estado ENUM('Activo', 'Inactivo') DEFAULT 'Activo',
    contrasena VARCHAR(255) NOT NULL,
    cargo VARCHAR(100) NOT NULL,
    salario DECIMAL(10, 2) NOT NULL,
    fecha_ingreso DATE NOT NULL,
    FOREIGN KEY (id_perfil) REFERENCES perfiles(id_perfil)
);
CREATE TABLE login (
    id_login INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    estado_sesion ENUM('Exitoso', 'Fallido') NOT NULL,
    ip_direccion VARCHAR(15),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE actividades (
    id_actividad INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion TEXT,
    fecha DATE NOT NULL,
    puntos_maximos INT NOT NULL DEFAULT 100
);
CREATE TABLE fidelizacion (
    id_fidelizacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_actividad INT NOT NULL,
    puntos INT NOT NULL,
    fecha_registro DATETIME NOT NULL,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_actividad) REFERENCES actividades(id_actividad)
);

use xyz_company;

-- insercion de 10 perfiles diferentes
insert into perfiles (nombre, fecha_vigencia, descripcion, encargado) values 
('administrador', '2025-12-31', 'acceso total al sistema', 'gerencia general'),
('recursos humanos', '2025-12-31', 'gestion de personal', 'director de rrhh'),
('contabilidad', '2025-12-31', 'gestion financiera', 'director financiero'),
('ventas', '2025-12-31', 'equipo comercial', 'director comercial'),
('produccion', '2025-12-31', 'operaciones productivas', 'jefe de produccion'),
('marketing', '2025-12-31', 'estrategias de mercado', 'director de marketing'),
('ti', '2025-12-31', 'tecnologia y sistemas', 'director de ti'),
('logistica', '2025-12-31', 'distribucion y almacenes', 'jefe de logistica'),
('atencion al cliente', '2025-12-31', 'soporte y atencion', 'supervisor de atencion'),
('investigacion', '2025-12-31', 'desarrollo e innovacion', 'director de i+d');

-- insercion de 20 usuarios
insert into usuarios (id_perfil, nombre, apellido, estado, contrasena, cargo, salario, fecha_ingreso) values 
(1, 'juan', 'perez', 'activo', sha2('password123', 256), 'gerente general', 5000.00, '2020-01-15'),
(2, 'maria', 'gomez', 'activo', sha2('password123', 256), 'director rrhh', 4500.00, '2020-02-10'),
(3, 'carlos', 'rodriguez', 'activo', sha2('password123', 256), 'director financiero', 4500.00, '2020-03-05'),
(4, 'ana', 'martinez', 'activo', sha2('password123', 256), 'director comercial', 4000.00, '2020-04-20'),
(5, 'pedro', 'lopez', 'activo', sha2('password123', 256), 'jefe de produccion', 3500.00, '2020-05-15'),
(6, 'laura', 'sanchez', 'activo', sha2('password123', 256), 'director de marketing', 4000.00, '2020-06-10'),
(7, 'miguel', 'hernandez', 'activo', sha2('password123', 256), 'director de ti', 4200.00, '2020-07-05'),
(8, 'sofia', 'diaz', 'activo', sha2('password123', 256), 'jefe de logistica', 3500.00, '2020-08-20'),
(9, 'david', 'torres', 'activo', sha2('password123', 256), 'supervisor atencion', 3000.00, '2020-09-15'),
(10, 'carmen', 'ruiz', 'activo', sha2('password123', 256), 'director de i+d', 4200.00, '2020-10-10'),
(1, 'roberto', 'fernandez', 'activo', sha2('password123', 256), 'administrador sistema', 3800.00, '2021-01-15'),
(2, 'lucia', 'morales', 'activo', sha2('password123', 256), 'analista rrhh', 2800.00, '2021-02-10'),
(3, 'fernando', 'castro', 'activo', sha2('password123', 256), 'contador', 3000.00, '2021-03-05'),
(4, 'paula', 'ortiz', 'activo', sha2('password123', 256), 'vendedor', 2500.00, '2021-04-20'),
(5, 'javier', 'nunez', 'inactivo', sha2('password123', 256), 'operario', 2200.00, '2021-05-15'),
(6, 'elena', 'vega', 'activo', sha2('password123', 256), 'disenador grafico', 2800.00, '2021-06-10'),
(7, 'gabriel', 'reyes', 'activo', sha2('password123', 256), 'soporte tecnico', 2600.00, '2021-07-05'),
(8, 'natalia', 'flores', 'activo', sha2('password123', 256), 'asistente logistica', 2300.00, '2021-08-20'),
(9, 'hugo', 'medina', 'activo', sha2('password123', 256), 'agente atencion', 2200.00, '2021-09-15'),
(10, 'alicia', 'jimenez', 'activo', sha2('password123', 256), 'investigador', 3100.00, '2021-10-10');

-- insercion de actividades
insert into actividades (nombre, descripcion, fecha, puntos_maximos) values 
-- actividades de 2024
('team building', 'actividad outdoor para fortalecer equipo', '2024-03-15', 100),
('taller de innovacion', 'sesiones de creatividad', '2024-03-30', 80),
('dia del trabajador', 'celebracion especial', '2024-04-15', 50),
('capacitacion excel', 'nivel avanzado', '2024-04-30', 70),
('maraton corporativa', 'carrera 5k', '2024-05-15', 120),
('taller de liderazgo', 'habilidades gerenciales', '2024-05-30', 90),
('aniversario empresa', 'celebracion anual', '2024-06-15', 150),
('donacion voluntaria', 'actividad social', '2024-06-30', 100),
('torneo deportivo', 'competencia interna', '2024-07-15', 80),
('workshop comunicacion', 'habilidades comunicativas', '2024-07-30', 70),
('semana de la salud', 'revisiones medicas', '2024-08-15', 60),
('concurso de ideas', 'mejoras a procesos', '2024-08-30', 100),
('dia de la familia', 'actividad con familiares', '2024-09-15', 120),
('charla motivacional', 'conferencia externa', '2024-09-30', 50),
('octubre rosa', 'campana de concientizacion', '2024-10-15', 40),
('halloween corporativo', 'celebracion tematica', '2024-10-30', 60),
('taller gestion tiempo', 'productividad personal', '2024-11-15', 70),
('desafio sustentable', 'iniciativas ecologicas', '2024-11-30', 90),
('cena de fin de ano', 'celebracion anual', '2024-12-15', 150),
('secret santa', 'intercambio de regalos', '2024-12-23', 50),
-- actividades de 2025
('kickoff anual', 'presentacion de objetivos', '2025-01-15', 80),
('taller finanzas personales', 'educacion financiera', '2025-01-30', 60),
('semana de bienestar', 'actividades de bienestar', '2025-02-15', 100),
('taller de trabajo en equipo', 'dinamicas grupales', '2025-02-28', 90);

-- Generacion de 100 registros de autenticacion
DELIMITER $$
CREATE PROCEDURE generar_logins()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE usuario_id INT;
    DECLARE fecha DATETIME;
    DECLARE estado VARCHAR(10);
    
    WHILE i <= 100 DO
        -- Seleccionar un usuario aleatorio entre 1 y 20
        SET usuario_id = FLOOR(1 + RAND() * 20);
        -- Generar fecha aleatoria en el último año
        SET fecha = DATE_ADD('2024-03-01', INTERVAL FLOOR(RAND() * 365) DAY);
        SET fecha = DATE_ADD(fecha, INTERVAL FLOOR(RAND() * 24) HOUR);
        SET fecha = DATE_ADD(fecha, INTERVAL FLOOR(RAND() * 60) MINUTE);
        -- Estado de login (90% exitoso, 10% fallido)
        IF RAND() < 0.9 THEN
            SET estado = 'Exitoso';
        ELSE
            SET estado = 'Fallido';
        END IF;
        
        INSERT INTO login (id_usuario, fecha_hora, estado_sesion, ip_direccion) 
        VALUES (usuario_id, fecha, estado, CONCAT('192.168.1.', FLOOR(1 + RAND() * 254)));
        
        SET i = i + 1;
    END WHILE;
END $$
DELIMITER ;

CALL generar_logins();
DROP PROCEDURE generar_logins;

-- generacion de registros de fidelizacion
DELIMITER $$
CREATE PROCEDURE generar_fidelizacion()
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE usuario_id INT;
    DECLARE actividad_id INT;
    DECLARE act_fecha DATE;
    DECLARE puntos_ganados INT;
    DECLARE fecha_reg DATETIME;
    
    -- Generar participaciones para cada actividad
    SELECT MIN(id_actividad), MAX(id_actividad) INTO @min_act, @max_act FROM actividades;
    
    SET actividad_id = @min_act;
    
    WHILE actividad_id <= @max_act DO
        -- Obtener la fecha de la actividad
        SELECT fecha INTO act_fecha FROM actividades WHERE id_actividad = actividad_id;
        
        -- Determinar cuántos usuarios participaron (entre 10 y 18 usuarios)
        SET @num_participantes = 10 + FLOOR(RAND() * 9);
        
        -- Para cada participante, generar un registro
        SET i = 1;
        WHILE i <= @num_participantes DO
            -- Seleccionar un usuario aleatorio
            SET usuario_id = FLOOR(1 + RAND() * 20);
            
            -- Verificar si este usuario ya participó en esta actividad
            SELECT COUNT(*) INTO @ya_existe 
            FROM fidelizacion 
            WHERE id_usuario = usuario_id AND id_actividad = actividad_id;
            
            IF @ya_existe = 0 THEN
                -- Obtener puntos máximos de la actividad
                SELECT puntos_maximos INTO @max_puntos FROM actividades WHERE id_actividad = actividad_id;
                -- Generar puntos aleatorios (entre 50% y 100% del máximo)
                SET puntos_ganados = FLOOR((@max_puntos * 0.5) + RAND() * (@max_puntos * 0.5));
                
                -- Fecha de registro (el mismo día o al día siguiente de la actividad)
                SET fecha_reg = DATE_ADD(act_fecha, INTERVAL FLOOR(RAND() * 2) DAY);
                SET fecha_reg = DATE_ADD(fecha_reg, INTERVAL FLOOR(RAND() * 8) + 9 HOUR);
                
                INSERT INTO fidelizacion (id_usuario, id_actividad, puntos, fecha_registro)
                VALUES (usuario_id, actividad_id, puntos_ganados, fecha_reg);
                
                SET i = i + 1;
            END IF;
        END WHILE;
        
        SET actividad_id = actividad_id + 1;
    END WHILE;
END $$
DELIMITER ;

CALL generar_fidelizacion();
DROP PROCEDURE generar_fidelizacion;

USE xyz_company;

-- Vista 1: Resumen de usuarios con su informacion y perfil
CREATE VIEW vw_usuarios_perfiles AS
SELECT 
    u.id_usuario, u.nombre, u.apellido, u.cargo, u.salario, u.fecha_ingreso, u.estado,
    p.nombre AS perfil,
    p.descripcion AS descripcion_perfil
FROM 
    usuarios u
JOIN 
    perfiles p ON u.id_perfil = p.id_perfil;

-- Vista 2: Historial de login por usuario
CREATE VIEW vw_historial_login AS
SELECT 
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido) AS nombre_completo,
    u.cargo,
    l.fecha_hora,
    l.estado_sesion,
    l.ip_direccion
FROM 
    login l
JOIN 
    usuarios u ON l.id_usuario = u.id_usuario
ORDER BY 
    l.fecha_hora DESC;

-- Vista 3: Participacion en actividades
CREATE VIEW vw_participacion_actividades AS
SELECT 
    a.id_actividad,
    a.nombre AS actividad,
    a.fecha,
    COUNT(f.id_usuario) AS total_participantes,
    AVG(f.puntos) AS promedio_puntos,
    MAX(f.puntos) AS max_puntos,
    MIN(f.puntos) AS min_puntos
FROM 
    actividades a
LEFT JOIN 
    fidelizacion f ON a.id_actividad = f.id_actividad
GROUP BY 
    a.id_actividad, a.nombre, a.fecha
ORDER BY 
    a.fecha DESC;

-- Vista 4: Ranking de usuarios por puntos de fidelizacion
CREATE VIEW vw_ranking_fidelizacion AS
SELECT 
    u.id_usuario,
    CONCAT(u.nombre, ' ', u.apellido) AS nombre_completo,
    u.cargo,
    p.nombre AS perfil,
    SUM(f.puntos) AS total_puntos,
    COUNT(DISTINCT f.id_actividad) AS actividades_participadas
FROM 
    usuarios u
JOIN 
    perfiles p ON u.id_perfil = p.id_perfil
LEFT JOIN 
    fidelizacion f ON u.id_usuario = f.id_usuario
GROUP BY 
    u.id_usuario, nombre_completo, u.cargo, perfil
ORDER BY 
    total_puntos DESC;

-- Vista 5: Resumen mensual de fidelizacion
CREATE VIEW vw_resumen_mensual_fidelizacion AS
SELECT 
    YEAR(a.fecha) AS anio,
    MONTH(a.fecha) AS mes,
    COUNT(DISTINCT a.id_actividad) AS total_actividades,
    COUNT(DISTINCT f.id_usuario) AS total_usuarios_participantes,
    SUM(f.puntos) AS total_puntos_otorgados,
    AVG(f.puntos) AS promedio_puntos_por_usuario
FROM 
    actividades a
LEFT JOIN 
    fidelizacion f ON a.id_actividad = f.id_actividad
GROUP BY 
    YEAR(a.fecha), MONTH(a.fecha)
ORDER BY 
    anio, mes;