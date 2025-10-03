-- Active: 1755654599943@@127.0.0.1@3306@inventario
/*Creación de la Base de Datos y Tablas - 'tablas_inventario.sql'

  Utiliza SQL para crear las tablas productos, proveedores y transacciones en la base de datos.

  Define las restricciones de nulidad, llaves primarias y llaves foráneas para garantizar la integridad de los datos.

  Establece el tipo de dato adecuado para cada atributo (por ejemplo, VARCHAR, INT, DECIMAL).*/


-- Tablas para inventario empresa - productocos, proveedores y transacciones
DROP DATABASE IF EXISTS inventario;
CREATE DATABASE IF NOT EXISTS inventario;
USE inventario;
CREATE TABLE productos
(
  id_producto          INT          NOT NULL AUTO_INCREMENT,
  nombre_producto      VARCHAR(100) NOT NULL,
  cantidad_inventario  INT          NOT NULL CHECK (cantidad_inventario >= 0),
  precio_producto      FLOAT        NOT NULL CHECK (precio_producto >= 0),
  descripcion_producto TEXT,
  PRIMARY KEY (id_producto)
);

ALTER TABLE productos
  ADD CONSTRAINT UQ_id_producto UNIQUE (id_producto);

ALTER TABLE productos
  ADD CONSTRAINT UQ_nombre_producto UNIQUE (nombre_producto);

CREATE TABLE proveedores
(
  id_proveedor        INT          NOT NULL AUTO_INCREMENT,
  nombre_proveedor    VARCHAR(100) NOT NULL,
  direccion_proveedor VARCHAR(100) NOT NULL,
  telefono_proveedor  VARCHAR(15)  NOT NULL,
  correo_proveedor    VARCHAR(50)  NOT NULL,
  PRIMARY KEY (id_proveedor)
);

ALTER TABLE proveedores
  ADD CONSTRAINT UQ_id_proveedor UNIQUE (id_proveedor);

CREATE TABLE transacciones
(
  id_transaccion    INT        NOT NULL AUTO_INCREMENT,
  tipo_transaccion  VARCHAR(6) NOT NULL,
  fecha_transaccion DATETIME   NOT NULL,
  cantidad_producto INT        NOT NULL CHECK (cantidad_producto > 0),
  id_proveedor      INT        NOT NULL,
  id_producto       INT        NOT NULL,
  PRIMARY KEY (id_transaccion)
);

ALTER TABLE transacciones
  ADD CONSTRAINT UQ_id_transaccion UNIQUE (id_transaccion);

ALTER TABLE transacciones
  ADD CONSTRAINT FK_proveedores_TO_transacciones
    FOREIGN KEY (id_proveedor)
    REFERENCES proveedores (id_proveedor);

ALTER TABLE transacciones
  ADD CONSTRAINT FK_productos_TO_transacciones
    FOREIGN KEY (id_producto)
    REFERENCES productos (id_producto);

-- Insertar datos de ejemplo en las tablas
INSERT INTO productos (nombre_producto, cantidad_inventario, precio_producto, descripcion_producto) VALUES
('Laptop', 50, 1200.00, 'Laptop de alta gama con 16GB RAM y 512GB SSD'),
('Smartphone', 200, 800.00, 'Smartphone con pantalla OLED y cámara de 48MP'),
('Tablet', 100, 600.00, 'Tablet con pantalla de 10 pulgadas y 128GB almacenamiento');

INSERT INTO proveedores (nombre_proveedor, direccion_proveedor, telefono_proveedor, correo_proveedor) VALUES
('TechCo', '123 Main St, Anytown, USA', '(123) 456-7890', 'n7TtB@example.com'),
('GadgetWorld', '456 Elm St, Othertown, USA', '(987) 654-3210', 'G5M8W@example.com'),
('DeviceHub', '789 Oak St, Sometown, USA', '(555) 123-4567', 'H2P9X@example.com');  

INSERT INTO transacciones (tipo_transaccion, fecha_transaccion, cantidad_producto, id_proveedor, id_producto) VALUES
('compra', '2024-01-15 10:00:00', 20, 1, 1),
('venta', '2024-01-16 11:30:00', 50, 2, 2),
('venta', '2024-01-18 14:45:00', 20, 1, 1),
('venta', '2024-01-20 09:15:00', 5, 1, 1);


