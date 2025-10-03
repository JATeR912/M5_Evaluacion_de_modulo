/*Consultas Básicas - 'consultas_basicas_inventario.sql'

    Realiza consultas básicas utilizando el lenguaje SQL:

    Recupera todos los productos disponibles en el inventario.

    Recupera todos los proveedores que suministran productos específicos.

    Consulta las transacciones realizadas en una fecha específica.

    Realiza consultas de selección con funciones de agrupación, como COUNT() y SUM(), para calcular el número total de productos vendidos o el valor total de las compras.*/


--Recupera todos los productos disponibles en el inventario.
SELECT p.cantidad_inventario, p.nombre_producto
FROM productos p
WHERE p.cantidad_inventario >= 1;

--Recupera todos los proveedores que suministran productos específicos.
SELECT pr.nombre_proveedor, p.nombre_producto
FROM proveedores pr
JOIN transacciones t ON pr.id_proveedor = t.id_proveedor
JOIN productos p ON t.id_producto = p.id_producto
WHERE p.nombre_producto = 'Laptop';

--Consulta las transacciones realizadas en una fecha específica.
--Entraga las transacciones del 15 de enero de 2024 - deberia devolver 1 compra
SELECT *
FROM transacciones
WHERE DATE(fecha_transaccion) = '2024-01-15';


--Realiza consultas de selección con funciones de agrupación, como COUNT() y SUM(), para calcular el número total de productos vendidos o el valor total de las compras.SELECT p.cantidad_inventario, p.nombre_producto
--Entrega el total de las ventas por producto (cantidad y valor total)
SELECT p.nombre_producto, SUM(t.cantidad_producto) AS cantidad_vendida, SUM(t.cantidad_producto*p.precio_producto) AS total_venta
FROM productos p
JOIN transacciones t ON p.id_producto = t.id_producto
WHERE t.tipo_transaccion = 'venta'
GROUP BY p.nombre_producto;