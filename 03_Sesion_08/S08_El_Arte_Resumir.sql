-- ═══════════════════════════════════════════════════════════════
-- NOVAMARKET TECH — SESIÓN 8: EL ARTE DE RESUMIR
-- Verbo: MEDIR (Agregación)
-- ═══════════════════════════════════════════════════════════════

/* 
RETO: EL VEREDICTO DE LETICIA
En la Sesión 4 (Excel) calculamos la rentabilidad por ciudad.
Descubrimos que Leticia es la "falla estructural" del negocio.
Ahora, vamos a confirmar ese número (Pérdida de $79,342) 
usando SQL y solo 5 líneas de código.
*/

-- 1. INTERROGAR: ¿Cuántas ventas hubo en total?
SELECT COUNT(*) FROM FactVentas;

-- 2. MEDIR: Utilidad Neta por Ciudad
-- Tip: Utilidad = (Precio_Venta * Cantidad) - (Costo_Unitario * Cantidad) - Costo_Envio
-- (Necesitaremos un JOIN en la próxima sesión, por ahora usemos IDs)

SELECT 
    CiudadID, 
    SUM(Precio_Venta * Cantidad) AS Ventas_Totales,
    SUM((FactVentas.Precio_Venta - DimProducto.Costo_Unitario) * Cantidad - FactVentas.Costo_Envio) AS Utilidad_Neta
FROM FactVentas
JOIN DimProducto ON FactVentas.ProductoID = DimProducto.ProductoID
GROUP BY CiudadID
ORDER BY Utilidad_Neta ASC;

-- 3. INVESTIGACIÓN: ¿Por qué Leticia (ID 6) tiene pérdida?
-- Escribe una consulta similar a la anterior pero filtrando solo CiudadID = 6.
-- ¿Qué campo está destruyendo el margen? ¿Son los descuentos o el Costo_Envio?

-- 4. DILEMA ÉTICO (S08):
-- El CEO quiere expandir a zonas aún más remotas basándose en que 
-- el "Volumen de Ventas" en Leticia es alto. Tus datos muestran pérdida estructural.
-- ¿Cómo presentas estos resultados sin que parezca que estás en contra de la expansión?
