/*Manipulación de Datos (DML) - 'DML_inventario.sql'

    Inserta datos en las tablas productos, proveedores y transacciones.

    Actualiza la cantidad de inventario de un producto después de una venta o compra.

    Elimina un producto de la base de datos si ya no está disponible.

    Asegúrate de aplicar integridad referencial al actualizar o eliminar registros relacionados.*/


--Inserta datos en las tablas productos, proveedores y transacciones.
--Se añaden 3 productos dando un total de 6 productos
--Se añaden 2 proveedores dando un total de 5 proveedores
--Se añaden 3 transacciones dando un total de 7 transacciones

INSERT INTO productos (nombre_producto, cantidad_inventario, precio_producto, descripcion_producto) VALUES
('Monitor', 20, 300.00, 'Monitor 4K de 27 pulgadas'),
('Teclado', 150, 50.00, 'Teclado mecánico con retroiluminación RGB'),
('Ratón', 150, 30.00, 'Ratón inalámbrico');

INSERT INTO proveedores (nombre_proveedor, direccion_proveedor, telefono_proveedor, correo_proveedor) VALUES
('Tech Supplies Co.', '123 Tech St, Silicon Valley, CA', '123-456-7890', 'RcA9o@example.com'),
('Gadget World', '456 Gadget Ave, New York, NY', '987-654-3210', 'H2P4L@example.com');

INSERT INTO transacciones (tipo_transaccion, fecha_transaccion, cantidad_producto, id_proveedor, id_producto) VALUES
('compra', '2024-01-15 10:00:00', 10, 5, 4),
('compra', '2024-01-17 09:15:00', 20, 3, 3),
('venta', '2024-01-18 11:45:00', 10, 4, 6);

--Actualiza la cantidad de inventario de un producto después de una venta o compra.
--Ejemplo: Actualiza la cantidad de inventario del producto con id_producto = 1 (Laptop) después de una venta (resultado: 30)
UPDATE productos p
JOIN transacciones t ON p.id_producto = t.id_producto
SET p.cantidad_inventario = p.cantidad_inventario - t.cantidad_producto
WHERE t.tipo_transaccion = 'venta' AND p.id_producto = 1;

--Ejemplo: Actualiza la cantidad de inventario del producto con id_producto = 1 (Laptop) después de una compra (resultado: 50)
UPDATE productos p
JOIN transacciones t ON p.id_producto = t.id_producto
SET p.cantidad_inventario = p.cantidad_inventario + t.cantidad_producto
WHERE t.tipo_transaccion = 'compra' AND p.id_producto = 1;


--Elimina un producto de la base de datos si ya no está disponible.
--Desactiva las comprobaciones de claves foráneas temporalmente para evitar errores.
SET FOREIGN_KEY_CHECKS = 0;
DELETE FROM productos WHERE cantidad_inventario = 0;
SET FOREIGN_KEY_CHECKS = 1;

---Asegúrate de aplicar integridad referencial al actualizar o eliminar registros relacionados.--