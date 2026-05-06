# Sesión 7 | El Interrogatorio
## Guía del Estudiante
**Haz las preguntas correctas — la respuesta depende de la pregunta**

> Énfasis II – Análisis de Datos | Semana 7 | Unidad 2: SQL | NovaMarket Tech

---

## Ficha de la sesión

| Dato | Información |
|---|---|
| Sesión | 7 — El Interrogatorio |
| Proceso analítico | **INTERROGAR** — la calidad de la respuesta depende de la calidad de la pregunta |
| Herramienta | MySQL Workbench / [dbfiddle.uk](https://dbfiddle.uk) (MySQL 8.0) |
| Archivo Lab Local | `02_Guia_S07_Antigravity.md` (Si usas VS Code) |
| Archivo de práctica | `06_Laboratorio_Consultas.sql` |

> **Tu misión hoy:** En S6 cargaste 500 transacciones de NovaMarket en una base de datos relacional. Hoy las interrogas. Al final de esta sesión habrás escrito más de 20 consultas SQL sobre datos reales — cada una responde una pregunta específica del caso.

---

## Verificación inicial — Antes de empezar (5 min)

Ejecuta esto para confirmar que la BD de S6 está correctamente cargada:

```sql
-- En SQLite la conexión se hace vía SQLTools a Novamarket_S07.db

SELECT 'DimProducto' AS Tabla, COUNT(*) AS Registros FROM DimProducto
UNION ALL SELECT 'DimCiudad',  COUNT(*) FROM DimCiudad
UNION ALL SELECT 'DimFecha',   COUNT(*) FROM DimFecha
UNION ALL SELECT 'FactVentas', COUNT(*) FROM FactVentas;

-- Resultado esperado:
-- DimProducto: 4 | DimCiudad: 6 | DimFecha: 91 | FactVentas: 500
```

> Si FactVentas **no** tiene 500 registros, avisa al docente antes de continuar.

---

## Referencia rápida — Los operadores WHERE

| Operador | Para qué | Ejemplo |
|---|---|---|
| `=` | Igual exacto | `WHERE CiudadID = 6` |
| `<>` | Diferente de | `WHERE CiudadID <> 6` |
| `>` `>=` `<` `<=` | Comparación numérica | `WHERE Descuento_Pct > 0.20` |
| `BETWEEN a AND b` | Rango inclusivo | `WHERE FechaID BETWEEN 20231101 AND 20231130` |
| `IN (lista)` | Uno de varios valores | `WHERE CiudadID IN (4, 5)` |
| `NOT IN (lista)` | Ninguno de la lista | `WHERE CiudadID NOT IN (4, 5, 6)` |
| `LIKE 'patrón'` | Texto parcial (`%` = comodín) | `WHERE Categoria LIKE 'S%'` |
| `IS NULL` | Valor ausente | `WHERE Evento_Especial IS NULL` |
| `IS NOT NULL` | Valor presente | `WHERE Evento_Especial IS NOT NULL` |
| `AND` | Ambas condiciones | `WHERE CiudadID = 6 AND Descuento_Pct > 0` |
| `OR` | Al menos una condición | `WHERE CiudadID = 4 OR CiudadID = 5` |

> ⚠️ **Regla de precedencia:** `AND` se evalúa antes que `OR`. Cuando mezcles ambos, usa paréntesis. `WHERE (CiudadID = 6 OR CiudadID = 4) AND Descuento_Pct > 0.15`

> ⚠️ **Alias en WHERE:** Si defines `AS Venta_Neta` en el SELECT, **no puedes** usar ese nombre en el WHERE. WHERE se ejecuta antes que SELECT — el alias todavía no existe. Repite la expresión completa: `WHERE (Precio_Venta * Cantidad * (1 - Descuento_Pct)) > 5000`

---

## Bloque A — El primer vistazo (20 min)

### A1 — Las primeras filas de FactVentas

```sql
SELECT * FROM FactVentas LIMIT 10;
```

- ¿Ves nombres de ciudad o números en la columna CiudadID? ___________
- ¿Cómo sabes cuál ciudad corresponde a CiudadID=6? ___________

### A2 — ¿Cuántas transacciones hay?

```sql
SELECT COUNT(*) AS Total_Transacciones FROM FactVentas;

-- Distribución por ciudad
SELECT CiudadID, COUNT(*) AS Transacciones
FROM FactVentas
GROUP BY CiudadID
ORDER BY Transacciones DESC;
-- (GROUP BY lo aprenderás en detalle en S8)
```

- ¿Qué CiudadID tiene más transacciones? ___________
- ¿Cuántas tiene CiudadID=6 (Leticia)? ___________

### A3 — El diccionario: productos y ciudades

```sql
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
```

- ¿Cuál producto tiene mayor margen %? ___________
- ¿Cuánto cuesta el envío base a Leticia? ___________

---

## Bloque B — SELECT con columnas, cálculos y alias (30 min)

### B1 — Solo las columnas que necesito

```sql
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
```

### B2 — Columnas calculadas con AS

SQL puede crear columnas nuevas en el momento de la consulta — sin modificar la tabla.

```sql
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
```

> ⚠️ **Importante:** `Venta_Neta` existe solo en el resultado — no puedes escribir `WHERE Venta_Neta > 5000`. Usa la expresión completa: `WHERE (Precio_Venta * Cantidad * (1 - Descuento_Pct)) > 5000`

---

## Bloque C — WHERE: filtrar con precisión (40 min)

### C1 — Igual (=) — Todas las ventas de Leticia

```sql
SELECT TransaccionID, FechaID, CiudadID, Cantidad, Precio_Venta, Costo_Envio
FROM FactVentas
WHERE CiudadID = 6
ORDER BY FechaID;

SELECT COUNT(*) AS Transacciones_Leticia
FROM FactVentas
WHERE CiudadID = 6;
```

- ¿Cuántas transacciones tiene Leticia? ___________

### C2 — Mayor que (>) — Descuentos agresivos

```sql
-- Ventas con descuento mayor al 15%
SELECT
    TransaccionID, FechaID, CiudadID, Descuento_Pct,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct), 2) AS Venta_Neta
FROM FactVentas
WHERE Descuento_Pct > 0.15
ORDER BY Descuento_Pct DESC;
```

- ¿Cuántas ventas tienen descuento > 15%? ___________
- ¿De qué fecha son casi todas? ¿Qué evento fue ese día? ___________

### C3 — AND — El peor escenario: Leticia con descuento

```sql
-- Leticia CON descuento = el mayor destructor de valor
SELECT
    TransaccionID, CiudadID, Descuento_Pct, Costo_Envio,
    ROUND(Precio_Venta * Cantidad * (1 - Descuento_Pct), 2) AS Venta_Neta
FROM FactVentas
WHERE CiudadID = 6
  AND Descuento_Pct > 0
ORDER BY Descuento_Pct DESC;
```

### C4 — IN — Ciudades del Caribe

```sql
-- Barranquilla (4) y Cartagena (5)
SELECT TransaccionID, CiudadID, Costo_Envio
FROM FactVentas
WHERE CiudadID IN (4, 5)
ORDER BY CiudadID, Costo_Envio DESC
LIMIT 15;
```

### C5 — BETWEEN — Ventas de noviembre (mes del Black Friday)

```sql
-- FechaID tiene formato AAAAMMDD
-- Noviembre 2023 = del 20231101 al 20231130
SELECT TransaccionID, FechaID, CiudadID, Descuento_Pct, Precio_Venta
FROM FactVentas
WHERE FechaID BETWEEN 20231101 AND 20231130
ORDER BY FechaID
LIMIT 20;
```

- ¿Cuántas ventas hay en noviembre en total? ___________

### C6 — LIKE — Buscar texto en dimensiones

```sql
-- Categorías que empiezan por 'S'
SELECT Nombre, Categoria FROM DimProducto
WHERE Categoria LIKE 'S%';

-- Ciudades que contienen 'a'
SELECT Nombre, Region FROM DimCiudad
WHERE Nombre LIKE '%a%';
```

### C7 — IS NULL — Días sin evento especial

```sql
-- ¿Cuántos días del período NO tienen evento especial?
SELECT COUNT(*) AS Dias_Sin_Evento
FROM DimFecha
WHERE Evento_Especial IS NULL;

-- ¿Y cuántos SÍ tienen evento?
SELECT FechaID, Fecha, Evento_Especial
FROM DimFecha
WHERE Evento_Especial IS NOT NULL;
```

- ¿Cuántos días tienen evento especial? ___________
- ¿Cuál es ese evento y en qué fecha? ___________

---

## Bloque D — ORDER BY + LIMIT: los extremos revelan la verdad (20 min)

### D1 — Las 10 ventas con mayor costo de envío

```sql
SELECT TransaccionID, CiudadID, Costo_Envio, Precio_Venta, Cantidad
FROM FactVentas
ORDER BY Costo_Envio DESC
LIMIT 10;
```

- ¿Qué CiudadID domina el top 10? ___________
- ¿Coincide con lo que aprendiste sobre Leticia en S4? ___________

### D2 — Las 10 transacciones con peor margen aproximado

```sql
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
```

- ¿El peor margen es negativo? ¿De qué ciudad? ___________

### D3 — Combinando todo: las 5 ventas de Leticia con mayor costo

```sql
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
```

---

## Bloque E — Desafíos autónomos (ENTREGABLE) (30 min)

> **Instrucciones:** Escribe las consultas sin mirar los bloques anteriores. Cada desafío debe tener: (1) un comentario con la pregunta de negocio, (2) la consulta SQL completa, (3) el número de filas que retornó como comentario al final.

**Formato esperado:**
```sql
-- DESAFÍO 1: ¿Cuántas ventas hubo en septiembre 2023?
SELECT COUNT(*) AS Ventas_Sep
FROM FactVentas
WHERE FechaID BETWEEN 20230901 AND 20230930;
-- Resultado: ___ filas
```

---

### Desafío 1 — Fácil

**Pregunta:** ¿Cuántas ventas hubo en septiembre de 2023?
*(FechaID entre 20230901 y 20230930)*

```sql
-- Tu consulta aquí:


```

Resultado: ___________ filas

---

### Desafío 2 — Medio

**Pregunta:** Muestra las 10 transacciones con mayor `Descuento_Pct` que **no** sean de Leticia (`CiudadID <> 6`). Columnas: `TransaccionID`, `CiudadID`, `Descuento_Pct`, `Precio_Venta`.

```sql
-- Tu consulta aquí:


```

- ¿De qué fecha son la mayoría? ___________
- ¿Qué dice eso sobre el Black Friday? ___________

---

### Desafío 3 — Difícil

**Pregunta:** ¿Cuántas ventas del mes de noviembre tuvieron un `Descuento_Pct` mayor al 20% **Y** un `Costo_Envio` mayor a 500? Estas son las ventas que más destruyen valor en todo el dataset.

```sql
-- Tu consulta aquí:


```

- Resultado: ___________ filas
- ¿Por qué estas ventas destruyen más valor que las demás? ___________

---

## Reflexión de cierre

> **La pregunta que todavía no puedes responder completamente:**
>
> En todos los ejercicios viste `CiudadID=6` pero no el nombre `'Leticia'`. Para verlo necesitas unir `FactVentas` con `DimCiudad`.
>
> Escribe con tus palabras (no en SQL todavía): ¿qué columna de `FactVentas` debería conectarse con qué columna de `DimCiudad`, y para qué? Esa idea es exactamente lo que aprenderás en S9 con `JOIN`.

Tu respuesta:

___________________________________________________________________________

___________________________________________________________________________

---

## Para la próxima sesión — S8: El Arte de Resumir

En S7 filtraste filas individuales con `WHERE`. En S8 aprenderás a comprimir esas filas en totales con `GROUP BY`. La primera consulta que escribirás en S8 reproducirá el análisis de S4: **utilidad total por ciudad** — sin Power BI, solo SQL.

---
*Sesión 7 | El Interrogatorio | NovaMarket Tech | Análisis de Datos para la Toma de Decisiones*
---
## Siguiente Paso: ¡A interrogar los datos!

Si estás usando la web, continúa con los bloques A-E. Si estás en local con **VS Code**, abre ahora tu guía práctica: 
👉 **[02_Guia_S07_Antigravity.md](file:///Users/macbookpro/Developer/Learning/SQL/02_Sesion_07/02_Guia_S07_Antigravity.md)**

---
*Sesión 7 | El Interrogatorio | NovaMarket Tech*
