/*Consultas Complejas - 'consultas_complejas_inventario.sql'

    Realiza una consulta que recupere el total de ventas de un producto durante el mes anterior.

    Utiliza JOINs (INNER, LEFT) para obtener información relacionada entre las tablas productos, proveedores y transacciones.

    Implementa una consulta con subconsultas (subqueries) para obtener productos que no se han vendido durante un período determinado.*/


--Realiza una consulta que recupere el total de ventas de un producto durante el mes anterior.
--Se realza la consulta para enero del 2024, muestra el nombre del producto, la cantidad vendida, la fecha de la transacción y el nombre del proveedor. 
SELECT p.nombre_producto, t.cantidad_producto, t.fecha_transaccion, pr.nombre_proveedor
FROM transacciones t
JOIN productos p ON t.id_producto = p.id_producto
JOIN proveedores pr ON t.id_proveedor = pr.id_proveedor
WHERE t.tipo_transaccion = 'venta' AND fecha_transaccion BETWEEN '2024-01-01' AND '2024-01-31'
ORDER BY t.fecha_transaccion ASC;

--Utiliza JOINs (INNER, LEFT) para obtener información relacionada entre las tablas productos, proveedores y transacciones.
--Muestra todas las transacciones realizadas
SELECT p.nombre_producto, t.tipo_transaccion, t.fecha_transaccion, t.cantidad_producto, pr.nombre_proveedor
FROM transacciones t
INNER JOIN productos p ON t.id_producto = p.id_producto
INNER JOIN proveedores pr ON t.id_proveedor = pr.id_proveedor
ORDER BY t.fecha_transaccion ASC;

--Muestra todos los productos aquellos sin transacciones arrojan solo su nombre y NULL en todos los demás campos
SELECT p.nombre_producto, t.tipo_transaccion, t.fecha_transaccion, t.cantidad_producto, pr.nombre_proveedor
FROM productos p
LEFT JOIN transacciones t ON p.id_producto = t.id_producto
LEFT JOIN proveedores pr ON t.id_proveedor = pr.id_proveedor
ORDER BY p.nombre_producto;

--Implementa una consulta con subconsultas (subqueries) para obtener productos que no se han vendido durante un período determinado.
--Muestra los productos que no se han vendido en enero del 2024 (resultado: Monitor, Tablet y Teclado luego de todos los inserts)
SELECT nombre_producto
FROM productos
WHERE id_producto NOT IN (
    SELECT id_producto
    FROM transacciones
    WHERE tipo_transaccion = 'venta' AND fecha_transaccion BETWEEN '2024-01-01' AND '2024-01-31'
);