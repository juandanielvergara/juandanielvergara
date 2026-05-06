-- 💻 LABORATORIO SESIÓN 7: EL INTERROGATORIO (SQL en VS Code)
-- ═══════════════════════════════════════════════════════════════
-- Guía de Referencia: 02_Guia_S07_Antigravity.md
-- Base de Datos: Novamarket_S07.db (500 registros)
-- ═══════════════════════════════════════════════════════════════

-- ══ BLOQUE A — Exploración Inicial ═════════════════════════════

-- A1: Ver las primeras 10 transacciones de 'FactVentas'.
-- Éxito: 10 filas.

SELECT * FROM FactVentas LIMIT 10;

- ¿Ves nombres de ciudad o números en la columna CiudadID? ___________
- ¿Cómo sabes cuál ciudad corresponde a CiudadID=6? __________


-- A2: Contar el total de registros en 'FactVentas'.
-- Éxito: El resultado debe ser 500.

SELECT COUNT(*) AS Total_Transacciones FROM FactVentas;

-- Distribución por ciudad
SELECT CiudadID, COUNT(*) AS Transacciones
FROM FactVentas
GROUP BY CiudadID
ORDER BY Transacciones DESC;
-- (GROUP BY lo aprenderás en detalle en S8)


- ¿Qué CiudadID tiene más transacciones? ___________
- ¿Cuántas tiene CiudadID=6 (Leticia)? ___________


-- A3: Ver el diccionario de productos en 'DimProducto'.
-- Éxito: 4 filas.

-- Productos con margen calculado
SELECT
    Nombre                                           AS Producto,
    Categoria,
    Precio_Unitario,
    Costo_Unitario,
    (Precio_Unitario - Costo_Unitario)               AS Margen_Bruto,
    ROUND((Precio_Unitario - Costo_Unitario)
          / Precio_Unitario * 100, 1)                AS Margen_Pct
FROM DimProducto
ORDER BY Margen_Pct DESC;

-- Ciudades ordenadas por costo de envío
SELECT Nombre, Region, Factor_Envio, Costo_Envio_Base
FROM DimCiudad
ORDER BY Factor_Envio DESC;


- ¿Cuál producto tiene mayor margen %? ___________
- ¿Cuánto cuesta el envío base a Leticia? ___________

---

## Bloque B — SELECT con columnas, cálculos y alias (30 min)

### B1 — Solo las columnas que necesito


-- No siempre SELECT * — solo lo que necesito
SELECT
    TransaccionID,
    FechaID,
    CiudadID,
    Cantidad,
    Precio_Venta,
    Costo_Envio
FROM FactVentas
LIMIT 15;


-- ══ BLOQUE B — Columnas y Cálculos ═════════════════════════════

-- B1: Mostrar TransaccionID, FechaID, Cantidad y Precio_Venta de 'FactVentas'.
-- Éxito: Verás solo las 4 columnas seleccionadas.


SELECT
    TransaccionID,
    FechaID,
    CiudadID,
    Cantidad,
    Precio_Venta,
    Costo_Envio
FROM FactVentas
LIMIT 15;

SELECT
    TransaccionID,
    CiudadID,
    Cantidad,
    Precio_Venta,
    Descuento_Pct,
    (Precio_Venta * Cantidad)                             AS Venta_Bruta,
    (Precio_Venta * Cantidad * Descuento_Pct)             AS Descuento_Monto,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct), 2) AS Venta_Neta
FROM FactVentas
LIMIT 20;

SELECT TransaccionID, FechaID, CiudadID, Cantidad, Precio_Venta, Costo_Envio
FROM FactVentas
WHERE CiudadID = 6
ORDER BY FechaID;

SELECT COUNT(*) AS Transacciones_Leticia
FROM FactVentas
WHERE CiudadID = 6;

-- Ventas con descuento mayor al 15%
SELECT
    TransaccionID, FechaID, CiudadID, Descuento_Pct,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct), 2) AS Venta_Neta
FROM FactVentas
WHERE Descuento_Pct > 0.15
ORDER BY Descuento_Pct DESC;

-- Leticia CON descuento = el mayor destructor de valor
SELECT
    TransaccionID, CiudadID, Descuento_Pct, Costo_Envio,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct), 2) AS Venta_Neta
FROM FactVentas
WHERE CiudadID = 6
  AND Descuento_Pct > 0
ORDER BY Descuento_Pct DESC;

-- Barranquilla (4) y Cartagena (5)
SELECT TransaccionID, CiudadID, Costo_Envio
FROM FactVentas
WHERE CiudadID IN (4, 5)
ORDER BY CiudadID, Costo_Envio DESC
LIMIT 15;

-- FechaID tiene formato AAAAMMDD
-- Noviembre 2023 = del 20231101 al 20231130
SELECT TransaccionID, FechaID, CiudadID, Descuento_Pct, Precio_Venta
FROM FactVentas
WHERE FechaID BETWEEN 20231101 AND 20231130
ORDER BY FechaID
LIMIT 20;

-- Categorías que empiezan por 'S'
SELECT Nombre, Categoria FROM DimProducto
WHERE Categoria LIKE 'S%';

-- Ciudades que contienen 'a'
SELECT Nombre, Region FROM DimCiudad
WHERE Nombre LIKE '%a%';

-- ¿Cuántos días del período NO tienen evento especial?
SELECT COUNT(*) AS Dias_Sin_Evento
FROM DimFecha
WHERE Evento_Especial IS NULL;

-- ¿Y cuántos SÍ tienen evento?
SELECT FechaID, Fecha, Evento_Especial
FROM DimFecha
WHERE Evento_Especial IS NOT NULL;

SELECT TransaccionID, CiudadID, Costo_Envio, Precio_Venta, Cantidad
FROM FactVentas
ORDER BY Costo_Envio DESC
LIMIT 10;

SELECT
    TransaccionID,
    CiudadID,
    Precio_Venta,
    Cantidad,
    Descuento_Pct,
    Costo_Envio,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct) - Costo_Envio, 2)
        AS Margen_Aproximado
FROM FactVentas
ORDER BY Margen_Aproximado ASC
LIMIT 10;

SELECT
    TransaccionID,
    FechaID,
    ProductoID,
    Cantidad,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct), 2) AS Venta_Neta,
    Costo_Envio,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct) - Costo_Envio, 2)
        AS Margen_Aproximado
FROM FactVentas
WHERE CiudadID = 6
ORDER BY Costo_Envio DESC
LIMIT 5;

-- DESAFÍO 1: ¿Cuántas ventas hubo en septiembre 2023?
SELECT COUNT(*) AS Ventas_Sep
FROM FactVentas
WHERE FechaID BETWEEN 20230901 AND 20230930;
-- Resultado: ___ filas

-- Tu consulta aquí:


```

- ¿De qué fecha son la mayoría? ___________
- ¿Qué dice eso sobre el Black Friday? ___________

---


-- E3: (Difícil) ¿Cuántas ventas de Noviembre tuvieron descuento > 20% Y envío > 500?
-- Éxito: 6 filas.

-- Tu consulta aquí:



- Resultado: ___________ filas
- ¿Por qué estas ventas destruyen más valor que las demás? ___________

---

-- ═══════════════════════════════════════════════════════════════
-- Fin del Laboratorio 07