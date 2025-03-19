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
    
    USE xyz_company;

-- Procedimiento 1: Registrar nuevo inicio de sesión
DELIMITER $$
CREATE PROCEDURE sp_registrar_login(
    IN p_id_usuario INT,
    IN p_estado_sesion ENUM('Exitoso', 'Fallido'),
    IN p_ip_direccion VARCHAR(15)
)
BEGIN
    INSERT INTO login (id_usuario, fecha_hora, estado_sesion, ip_direccion)
    VALUES (p_id_usuario, NOW(), p_estado_sesion, p_ip_direccion);
    
    SELECT 'Login registrado exitosamente' AS mensaje;
END $$
DELIMITER ;

-- Procedimiento 2: Registrar participacion en actividad
DELIMITER $$
CREATE PROCEDURE sp_registrar_participacion(
    IN p_id_usuario INT,
    IN p_id_actividad INT,
    IN p_puntos INT
)
BEGIN
    DECLARE v_existe INT;
    DECLARE v_max_puntos INT;
    
    -- Verificar si el usuario ya participó en esta actividad
    SELECT COUNT(*) INTO v_existe 
    FROM fidelizacion 
    WHERE id_usuario = p_id_usuario AND id_actividad = p_id_actividad;
    
    -- Verificar puntos máximos de la actividad
    SELECT puntos_maximos INTO v_max_puntos 
    FROM actividades 
    WHERE id_actividad = p_id_actividad;
    
    IF v_existe > 0 THEN
        SELECT 'El usuario ya participó en esta actividad' AS mensaje;
    ELSEIF p_puntos > v_max_puntos THEN
        SELECT CONCAT('Error: Los puntos no pueden superar el máximo de la actividad (', v_max_puntos, ')') AS mensaje;
    ELSE
        INSERT INTO fidelizacion (id_usuario, id_actividad, puntos, fecha_registro)
        VALUES (p_id_usuario, p_id_actividad, p_puntos, NOW());
        
        SELECT 'Participación registrada exitosamente' AS mensaje;
    END IF;
END $$
DELIMITER ;

-- Procedimiento 3: Crear nueva actividad
DELIMITER $$
CREATE PROCEDURE sp_crear_actividad(
    IN p_nombre VARCHAR(100),
    IN p_descripcion TEXT,
    IN p_fecha DATE,
    IN p_puntos_maximos INT
)
BEGIN
    INSERT INTO actividades (nombre, descripcion, fecha, puntos_maximos)
    VALUES (p_nombre, p_descripcion, p_fecha, p_puntos_maximos);
    
    SELECT 'Actividad creada exitosamente' AS mensaje;
END $$
DELIMITER ;

-- Procedimiento 4: Obtener reporte de fidelización por período
DELIMITER $$
CREATE PROCEDURE sp_reporte_fidelizacion(
    IN p_fecha_inicio DATE,
    IN p_fecha_fin DATE
)
BEGIN
    SELECT 
        u.id_usuario,
        CONCAT(u.nombre, ' ', u.apellido) AS nombre_completo,
        u.cargo,
        p.nombre AS perfil,
        COUNT(DISTINCT f.id_actividad) AS actividades_participadas,
        SUM(f.puntos) AS total_puntos
    FROM 
        usuarios u
    JOIN 
        perfiles p ON u.id_perfil = p.id_perfil
    LEFT JOIN 
        fidelizacion f ON u.id_usuario = f.id_usuario
    LEFT JOIN 
        actividades a ON f.id_actividad = a.id_actividad
    WHERE 
        a.fecha BETWEEN p_fecha_inicio AND p_fecha_fin
    GROUP BY 
        u.id_usuario, nombre_completo, u.cargo, perfil
    ORDER BY 
        total_puntos DESC;
END $$
DELIMITER ;

-- Procedimiento 5: Cambiar estado de usuario
DELIMITER $$
CREATE PROCEDURE sp_cambiar_estado_usuario(
    IN p_id_usuario INT,
    IN p_nuevo_estado ENUM('Activo', 'Inactivo')
)
BEGIN
    UPDATE usuarios
    SET estado = p_nuevo_estado
    WHERE id_usuario = p_id_usuario;
    
    SELECT CONCAT('Estado del usuario actualizado a: ', p_nuevo_estado) AS mensaje;
END $$
DELIMITER ;

-- consultas 
-- 1. Ver todos los usuarios con sus perfiles
SELECT * FROM vw_usuarios_perfiles;

-- 2. Ver historial de login de los ultimos 30 días
SELECT * FROM vw_historial_login
WHERE fecha_hora >= DATE_SUB(CURDATE(), INTERVAL 30 DAY);

-- 3. Consultar el ranking de fidelización
SELECT * FROM vw_ranking_fidelizacion;

-- 4. Ver usuarios que participaron en más del 50% de las actividades
SELECT 
    nombre_completo, 
    perfil,
    actividades_participadas,
    total_puntos,
    ROUND((actividades_participadas / (SELECT COUNT(*) FROM actividades)) * 100, 2) AS porcentaje_participacion
FROM 
    vw_ranking_fidelizacion
WHERE 
    (actividades_participadas / (SELECT COUNT(*) FROM actividades)) * 100 > 50
ORDER BY 
    porcentaje_participacion DESC;

-- 5. Consultar resumen mensual de fidelizacion
SELECT * FROM vw_resumen_mensual_fidelizacion;

-- 6. Consultar las actividades con mayor participacion
SELECT 
    id_actividad,
    actividad,
    fecha,
    total_participantes,
    promedio_puntos
FROM 
    vw_participacion_actividades
ORDER BY 
    total_participantes DESC
LIMIT 5;

-- 7. Calcular el promedio de salario por perfil
SELECT 
    p.nombre AS perfil,
    ROUND(AVG(u.salario), 2) AS salario_promedio,
    COUNT(u.id_usuario) AS total_usuarios
FROM 
    usuarios u
JOIN 
    perfiles p ON u.id_perfil = p.id_perfil
GROUP BY 
    p.nombre
ORDER BY 
    salario_promedio DESC;

-- 8. Obtener el total de puntos de fidelizacion por departamento (perfil)
SELECT 
    p.nombre AS perfil,
    SUM(f.puntos) AS total_puntos,
    COUNT(DISTINCT u.id_usuario) AS total_usuarios,
    ROUND(SUM(f.puntos) / COUNT(DISTINCT u.id_usuario), 2) AS promedio_por_usuario
FROM 
    perfiles p
JOIN 
    usuarios u ON p.id_perfil = u.id_perfil
LEFT JOIN 
    fidelizacion f ON u.id_usuario = f.id_usuario
GROUP BY 
    p.nombre
ORDER BY 
    total_puntos DESC;

USE xyz_company;

-- Indices para la tabla de usuarios
CREATE INDEX idx_usuarios_perfil ON usuarios(id_perfil);
CREATE INDEX idx_usuarios_estado ON usuarios(estado);
CREATE INDEX idx_usuarios_cargo ON usuarios(cargo);
CREATE INDEX idx_usuarios_fecha_ingreso ON usuarios(fecha_ingreso);

-- Indices para la tabla de login
CREATE INDEX idx_login_usuario ON login(id_usuario);
CREATE INDEX idx_login_fecha ON login(fecha_hora);
CREATE INDEX idx_login_estado ON login(estado_sesion);

-- Indices para la tabla de actividades
CREATE INDEX idx_actividades_fecha ON actividades(fecha);

-- Indices para la tabla de fidelizacion
CREATE INDEX idx_fidelizacion_usuario ON fidelizacion(id_usuario);
CREATE INDEX idx_fidelizacion_actividad ON fidelizacion(id_actividad);
CREATE INDEX idx_fidelizacion_fecha ON fidelizacion(fecha_registro);
CREATE INDEX idx_fidelizacion_puntos ON fidelizacion(puntos);

-- Indice compuesto para análisis de participaciin por usuario y fecha
CREATE INDEX idx_fidelizacion_usuario_fecha ON fidelizacion(id_usuario, fecha_registro);

USE xyz_company;

-- Trigger 1: Auditoría de cambios en usuarios
DELIMITER $$
CREATE TABLE IF NOT EXISTS auditoria_usuarios (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    accion ENUM('INSERT', 'UPDATE', 'DELETE') NOT NULL,
    campo_modificado VARCHAR(50),
    valor_antiguo VARCHAR(255),
    valor_nuevo VARCHAR(255),
    usuario_bd VARCHAR(100),
    fecha_hora DATETIME
);

DELIMITER $$

CREATE TRIGGER trg_usuarios_after_update
AFTER UPDATE ON usuarios
FOR EACH ROW
BEGIN
    -- Verificar si el campo 'nombre' ha cambiado
    IF OLD.nombre != NEW.nombre THEN
        INSERT INTO auditoria_usuarios (id_usuario, accion, campo_modificado, valor_antiguo, valor_nuevo, usuario_bd, fecha_hora)
        VALUES (NEW.id_usuario, 'UPDATE', 'nombre', OLD.nombre, NEW.nombre, USER(), NOW());
    END IF;
    
    -- Verificar si el campo 'apellido' ha cambiado
    IF OLD.apellido != NEW.apellido THEN
        INSERT INTO auditoria_usuarios (id_usuario, accion, campo_modificado, valor_antiguo, valor_nuevo, usuario_bd, fecha_hora)
        VALUES (NEW.id_usuario, 'UPDATE', 'apellido', OLD.apellido, NEW.apellido, USER(), NOW());
    END IF;
    
    -- Verificar si el campo 'estado' ha cambiado
    IF OLD.estado != NEW.estado THEN
        INSERT INTO auditoria_usuarios (id_usuario, accion, campo_modificado, valor_antiguo, valor_nuevo, usuario_bd, fecha_hora)
        VALUES (NEW.id_usuario, 'UPDATE', 'estado', OLD.estado, NEW.estado, USER(), NOW());
    END IF;
    
    -- Verificar si el campo 'cargo' o 'salario' ha cambiado
    IF OLD.cargo != NEW.cargo OR OLD.salario != NEW.salario THEN
        INSERT INTO auditoria_usuarios (id_usuario, accion, campo_modificado, valor_antiguo, valor_nuevo, usuario_bd, fecha_hora)
        VALUES (NEW.id_usuario, 'UPDATE', 'cargo_salario', CONCAT(OLD.cargo, ' / ', OLD.salario), CONCAT(NEW.cargo, ' / ', NEW.salario), USER(), NOW());
    END IF;
END$$

DELIMITER ;

-- Trigger 2
DELIMITER $$

-- Trigger 2: Validación de puntos en fidelizacion
CREATE TRIGGER trg_fidelizacion_before_insert
BEFORE INSERT ON fidelizacion
FOR EACH ROW
BEGIN
    DECLARE v_max_puntos INT;
    
    -- Obtener los puntos maximos de la actividad
    SELECT puntos_maximos INTO v_max_puntos 
    FROM actividades 
    WHERE id_actividad = NEW.id_actividad;
    
    -- Validar que los puntos no excedan el máximo
    IF NEW.puntos > v_max_puntos THEN
        SET NEW.puntos = v_max_puntos;
    END IF;
END$$


DELIMITER ;

DELIMITER $$

-- Trigger 3: Actualizar automáticamente la fecha de registro en fidelización
CREATE TRIGGER trg_fidelizacion_before_insert_fecha
BEFORE INSERT ON fidelizacion
FOR EACH ROW
BEGIN
    -- Verificar si la fecha de registro es nula
    IF NEW.fecha_registro IS NULL THEN
        SET NEW.fecha_registro = NOW(); -- Asignar la fecha y hora actual
    END IF;
END$$

DELIMITER ;

DELIMITER $$
-- Trigger 4: Registro automático de login exitoso al insertar un nuevo usuario
CREATE TRIGGER trg_usuarios_after_insert
AFTER INSERT ON usuarios
FOR EACH ROW
BEGIN
    INSERT INTO login (id_usuario, fecha_hora, estado_sesion, ip_direccion)
    VALUES (NEW.id_usuario, NOW(), 'Exitoso', '127.0.0.1');
END $$
DELIMITER ;