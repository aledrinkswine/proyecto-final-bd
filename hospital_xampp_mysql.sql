
-- =============================================
-- HOSPITAL DATABASE FOR MYSQL (XAMPP)
-- Compatible with MySQL / MariaDB
-- =============================================

DROP DATABASE IF EXISTS hospital;
CREATE DATABASE hospital;
USE hospital;

-- ===========================
-- TABLA PACIENTES
-- ===========================
CREATE TABLE pacientes (
    id_paciente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    tipo_doc VARCHAR(10),
    dni VARCHAR(30) UNIQUE,
    fecha_nacimiento DATE,
    genero VARCHAR(10),
    tipo_sangre VARCHAR(5),
    alergias TEXT,
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- ===========================
-- TABLA MEDICOS
-- ===========================
CREATE TABLE medicos (
    id_medico INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50),
    apellidos VARCHAR(50),
    dni VARCHAR(30) UNIQUE,
    especialidad VARCHAR(50),
    telefono VARCHAR(20),
    email VARCHAR(100)
);

-- ===========================
-- TABLA DEPARTAMENTOS
-- ===========================
CREATE TABLE departamentos (
    id_departamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT
);

-- ===========================
-- TABLA HABITACIONES
-- ===========================
CREATE TABLE habitaciones (
    id_habitacion INT AUTO_INCREMENT PRIMARY KEY,
    id_departamento INT,
    numero VARCHAR(10),
    tipo VARCHAR(20),
    estado VARCHAR(20),
    piso VARCHAR(10),
    FOREIGN KEY (id_departamento) REFERENCES departamentos(id_departamento)
);

-- ===========================
-- TABLA CONSULTAS
-- ===========================
CREATE TABLE consultas (
    id_consulta INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    fecha DATETIME,
    motivo TEXT,
    diagnostico TEXT,
    tratamiento TEXT,
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

-- ===========================
-- TABLA HOSPITALIZACIONES
-- ===========================
CREATE TABLE hospitalizaciones (
    id_hospitalizacion INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_habitacion INT,
    fecha_ingreso DATETIME,
    fecha_salida DATETIME NULL,
    motivo TEXT,
    estado VARCHAR(20),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion)
);

-- ===========================
-- TABLA MEDICAMENTOS
-- ===========================
CREATE TABLE medicamentos (
    id_medicamento INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    descripcion TEXT,
    presentacion VARCHAR(50),
    stock INT,
    unidad VARCHAR(20),
    fecha_vencimiento DATE,
    proveedor VARCHAR(100)
);

-- ===========================
-- TABLA FACTURAS
-- ===========================
CREATE TABLE facturas (
    id_factura INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    fecha DATETIME DEFAULT NOW(),
    subtotal DECIMAL(12,2),
    impuestos DECIMAL(12,2),
    total DECIMAL(12,2),
    estado VARCHAR(20),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente)
);

-- ===========================
-- TABLA DETALLE FACTURA
-- ===========================
CREATE TABLE detalle_factura (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_factura INT,
    concepto VARCHAR(255),
    cantidad INT,
    precio_unitario DECIMAL(12,2),
    total DECIMAL(12,2),
    FOREIGN KEY (id_factura) REFERENCES facturas(id_factura)
);

-- ===========================
-- TABLA CITAS
-- ===========================
CREATE TABLE citas (
    id_cita INT AUTO_INCREMENT PRIMARY KEY,
    id_paciente INT,
    id_medico INT,
    fecha DATETIME,
    estado VARCHAR(20),
    FOREIGN KEY (id_paciente) REFERENCES pacientes(id_paciente),
    FOREIGN KEY (id_medico) REFERENCES medicos(id_medico)
);

-- ===========================
-- DATOS BASE
-- ===========================
INSERT INTO departamentos (nombre, descripcion) VALUES
('Urgencias','Atención inmediata'),
('Cardiología','Corazón y sistema circulatorio'),
('Pediatría','Atención infantil'),
('Cirugía','Procedimientos quirúrgicos');

INSERT INTO medicos (nombre, apellidos, dni, especialidad, telefono, email) VALUES
('Carlos','Gomez','MED1001','Cardiología','3000000001','carlos@hospital.com'),
('Ana','Martinez','MED1002','Urgencias','3000000002','ana@hospital.com');

INSERT INTO pacientes (nombre, apellidos, tipo_doc, dni, fecha_nacimiento, genero, tipo_sangre, alergias, telefono, email) VALUES
('José','Pérez','CC','PAC1001','1985-04-12','M','O+','Ninguna','3200000001','jose@example.com'),
('María','López','CC','PAC1002','1992-11-05','F','A-','Penicilina','3200000002','maria@example.com');

