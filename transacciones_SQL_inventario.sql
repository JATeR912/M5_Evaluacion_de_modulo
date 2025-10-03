/*Transacciones SQL - 'transacciones_SQL_inventario.sql'

  Realiza una transacción para registrar una compra de productos. Utiliza el comando BEGIN TRANSACTION, COMMIT y ROLLBACK para asegurar que los cambios se apliquen correctamente.

  Asegúrate de que los cambios en la cantidad de inventario y las transacciones se realicen de forma atómica.

  Utiliza el modo AUTOCOMMIT para manejar operaciones individuales si es necesario.*/


--Procedimiento almacenado para registrar una compra y actualizar el inventario
DELIMITER $$
DROP PROCEDURE IF EXISTS registrar_compra $$

CREATE PROCEDURE registrar_compra(
    IN p_cantidad INT,
    IN p_id_proveedor INT,
    IN p_id_producto INT
)
proc: BEGIN
  DECLARE v_existe_producto INT DEFAULT 0;
  DECLARE v_existe_proveedor INT DEFAULT 0;

  START TRANSACTION;

  -- Validar que los parámetros no sean nulos ni inválidos (no se ralicen compras de 0 o menos productos y ademas ids no sean 0)
  IF p_id_producto IS NULL OR p_cantidad IS NULL OR p_id_proveedor IS NULL OR p_cantidad <= 0 THEN
    ROLLBACK;
    SELECT 'ERROR: parámetros inválidos o cantidad <= 0' AS estado;
    LEAVE proc;
  END IF;

  -- Verificar que el producto exista
  SELECT COUNT(*) INTO v_existe_producto 
  FROM productos 
  WHERE id_producto = p_id_producto;

  IF v_existe_producto = 0 THEN
    ROLLBACK;
    SELECT 'ERROR: el producto no existe' AS estado;
    LEAVE proc;
  END IF;

  -- Verificar que el proveedor exista
  SELECT COUNT(*) INTO v_existe_proveedor 
  FROM proveedores 
  WHERE id_proveedor = p_id_proveedor;

  IF v_existe_proveedor = 0 THEN
    ROLLBACK;
    SELECT 'ERROR: el proveedor no existe' AS estado;
    LEAVE proc;
  END IF;

  -- Insertar la transacción de tipo 'compra' con la fecha actual
  INSERT INTO transacciones (
    tipo_transaccion, 
    fecha_transaccion, 
    cantidad_producto, 
    id_proveedor, 
    id_producto
  )
  VALUES (
    'compra', 
    NOW(), 
    p_cantidad, 
    p_id_proveedor, 
    p_id_producto
  );

  -- Actualizar inventario: se suma los productos comprados
  UPDATE productos 
  SET cantidad_inventario = cantidad_inventario + p_cantidad 
  WHERE id_producto = p_id_producto;

  COMMIT;
  SELECT 'OK: compra registrada correctamente' AS estado;
END $$

DELIMITER ;

--Llamada de ejemplo a la procedimiento almacenado (cantidad_producto, id_proveedor, id_producto)
--Compra correcta
CALL registrar_compra(50, 1, 3);

--Compra con error (producto no existe)
CALL registrar_compra(50, 1, 99);

--Compra con error (proveedor no existe)
CALL registrar_compra(50, 99, 1);

--Compra con error (cantidad 0 o negativa)
CALL registrar_compra(0, 1, 1);