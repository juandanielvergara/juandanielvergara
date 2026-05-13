# Sesión Express | El Veredicto en SQL
## Guía del Estudiante — S8+S9 condensadas
**GROUP BY + JOIN: de 500 filas a 6 verdades, con nombres reales**

> Énfasis II – Análisis de Datos | NovaMarket Tech

---

| Dato | Información |
|---|---|
| Archivo | `03_Laboratorio_Consultas.sql` |
| Conceptos | GROUP BY, SUM, COUNT, INNER JOIN |
| Meta de la sesión | Reproducir el dashboard de S4 en SQL — con nombres, no con números |

> **Tu misión hoy:** En S7 tenías 500 filas. La Junta necesita 6 decisiones. Y necesita ver `'Leticia'`, no `'6'`. Hoy resuelves las dos cosas.

---

## Referencia rápida

```sql
-- GROUP BY: comprime filas en grupos
SELECT columna, SUM(metrica)
FROM tabla
GROUP BY columna;

-- JOIN: une dos tablas por la columna en común (Versión explícita)
FROM FactVentas
INNER JOIN DimCiudad ON FactVentas.CiudadID = DimCiudad.CiudadID
-- Ahora puedes usar DimCiudad.Ciudad → 'Leticia' en lugar de 6

-- JOIN (Versión con "apodos"): Usar iniciales (f y c) por pereza para no escribir tanto
FROM FactVentas f
INNER JOIN DimCiudad c ON f.CiudadID = c.CiudadID
-- Ahora puedes usar c.Ciudad → 'Leticia'
```

---

## El "Orden Sagrado" de SQL

Para que una consulta funcione, SQL exige que las piezas se pongan en un orden específico. Si cambias el orden, la base de datos no entenderá la instrucción.

Esta es la estructura jerárquica o "esqueleto":

```sql
SELECT    -- 1. ¿Qué columnas quiero mostrar? (f.Columna, c.Columna)
FROM      -- 2. ¿Cuál es mi tabla principal? (La que tiene los hechos/números)
JOIN      -- 3. ¿Con qué tabla la quiero unir? (La que tiene los nombres)
  ON      -- 4. ¿Cuál es la columna que tienen en común? (El "hilo" que las une)
WHERE     -- 5. ¿Qué filas quiero filtrar? (Ej: Solo Leticia)
ORDER BY  -- 6. ¿Cómo quiero ordenar los resultados? (Opcional)
LIMIT     -- 7. ¿Cuántas filas quiero ver? (Opcional)
```

### Una regla de oro para ellos:

A diferencia del lenguaje humano, donde podríamos decir "Dame las ventas de Leticia de la tabla FactVentas", en SQL el orden es rígido:

1. **SELECT** (Columnas)
2. **FROM** (Tablas + JOIN)
3. **WHERE** (Filtros)
4. **LIMIT** (Recorte)

> [!TIP]
> **Dato curioso para la clase:** Aunque nosotros escribimos el `SELECT` primero, SQL en realidad lee primero el `FROM` para saber de dónde sacar los datos, luego el `JOIN` para pegarlos, después el `WHERE` para filtrar, y **al final de todo** decide qué columnas mostrarte con el `SELECT`.

| Orden | Cláusula | ¿Qué hace? |
|:---:|---|---|
| **1** | `SELECT` | Define qué columnas quieres ver. |
| **2** | `FROM` | Define la tabla principal (con su "apodo" o alias). |
| **3** | `JOIN` / `ON` | Pega otra tabla usando una columna común (el hilo). |
| **4** | `WHERE` | Filtra las filas (Ej: solo una ciudad o un mes). |
| **5** | `GROUP BY` | Comprime las filas (pasa de 500 registros a solo 6 ciudades). |
| **6** | `ORDER BY` | Ordena el resultado final (ASC o DESC). |
| **7** | `LIMIT` | Recorta el resultado (Ej: ver solo los primeros 10). |

> [!NOTE]
> **¿Qué significa `INNER`?**
> Es un "pegamento exigente". Solo muestra las filas que tienen pareja en **ambas** tablas. Si una venta no tiene ciudad, o una ciudad no tiene ventas, el `INNER JOIN` las ignora para que el resultado sea exacto.

### ¿Y si quiero agrupar por dos cosas? (Doble Agrupación)
Si en el `GROUP BY` pones dos columnas (separadas por coma), SQL creará subgrupos.
*   `GROUP BY c.Ciudad`: Te da una fila por ciudad (Ej: Leticia).
*   `GROUP BY c.Ciudad, p.Producto`: Te dará una fila por cada combinación (Ej: Leticia + Smartphone, Leticia + Laptop, Medellín + Smartphone, etc.).

**Regla de oro:** Todas las columnas que pongas en el `SELECT` que NO tengan una función (como `SUM` o `COUNT`), **deben** estar en el `GROUP BY`.

---

## Parte 1 — GROUP BY (30 min)

### Paso 1 — El problema de las 500 filas

```sql
-- Esto no ayuda a la Junta:
SELECT CiudadID, Precio_Venta, Costo_Envio FROM FactVentas LIMIT 5;

-- Esto sí:
SELECT CiudadID, COUNT(*) AS Filas FROM FactVentas GROUP BY CiudadID;
```

| Pregunta | Tu respuesta |
|---|---|
| ¿Cuántas filas retorna GROUP BY? ¿Por qué? | |

### Paso 2 — El veredicto de Leticia con GROUP BY

```sql
SELECT
    CiudadID,
    COUNT(*)                                               AS Transacciones,
    ROUND(SUM(Precio_Venta * Cantidad * (1-Descuento_Pct)), 2) AS Venta_Neta,
    ROUND(SUM(Costo_Envio), 2)                             AS Costo_Envio_Total,
    ROUND(SUM(
        Precio_Venta * Cantidad * (1-Descuento_Pct)
        - Costo_Envio
    ), 2)                                                  AS Margen_Aproximado
FROM FactVentas
GROUP BY CiudadID
ORDER BY Margen_Aproximado ASC;
```

| Pregunta | Tu respuesta |
|---|---|
| ¿Qué CiudadID tiene Margen_Aproximado negativo? | |
| ¿Cuánto es esa pérdida? | |
| ¿Coincide con el número de Power BI de S4? | SÍ / NO |

### Paso 3 — SUM vs AVG: el mismo debate de S2

```sql
SELECT
    CiudadID,
    ROUND(SUM(Costo_Envio), 2) AS Costo_TOTAL,
    ROUND(AVG(Costo_Envio), 2) AS Costo_PROMEDIO
FROM FactVentas
WHERE CiudadID = 6
GROUP BY CiudadID;
```

| Pregunta | Tu respuesta |
|---|---|
| ¿Para decidir si cerrar Leticia, cuál usarías: SUM o AVG? | |

---

## Parte 2 — JOIN (30 min)

### Paso 4 — El primer JOIN: 'Leticia' en lugar de '6'

```sql
SELECT
    f.TransaccionID,
    c.Ciudad    AS Ciudad,    -- viene de DimCiudad
    f.Costo_Envio
FROM FactVentas f
INNER JOIN DimCiudad c ON f.CiudadID = c.CiudadID
WHERE c.Ciudad = 'Leticia'
LIMIT 5;
```

Esta consulta es el "puente" que permite pasar de ver números (IDs) a ver nombres reales. Aquí te explico qué hace cada parte como si se lo explicaras a tus estudiantes:

#### 1. El "Qué queremos ver" (SELECT)
*   Aquí elegimos qué columnas mostrar.
*   Nota que usamos `f.` para las columnas que vienen de las ventas y `c.` para la que viene de la tabla de ciudades.
*   Gracias al JOIN, ahora podemos pedir `c.Ciudad` para ver el nombre "Leticia" en lugar de ver un simple "6".

#### 2. El Origen y los "Apodos" (FROM y Aliases)
*   Le decimos a SQL que nuestra tabla principal es `FactVentas`.
*   Le ponemos el apodo `f` para no tener que escribir el nombre largo cada vez que queramos una de sus columnas.

#### 3. El Puente (INNER JOIN)
*   Esta es la magia. Estamos pegando la tabla de ciudades (`DimCiudad`, con apodo `c`) a nuestra tabla de ventas.
*   `ON f.CiudadID = c.CiudadID`: Es la condición de pegado. Le decimos: *"Busca el código de ciudad en las ventas y emparéjalo con el mismo código en la lista de ciudades"*.

#### 4. El Filtro y el Límite (WHERE y LIMIT)
*   **WHERE**: Ahora que las tablas están unidas, podemos filtrar directamente por el nombre de la ciudad. SQL busca en la tabla unida todas las filas donde el nombre sea 'Leticia'.
*   **LIMIT 5**: Solo nos muestra las primeras 5 filas para no inundar la pantalla, ideal para verificar que la consulta funciona.

> [!TIP]
> **En resumen para los estudiantes:**
> "Estamos usando el CiudadID como un hilo para coser la tabla de ventas con la de ciudades, y así poder preguntarle a la base de datos por 'Leticia' en lugar de por el número 6."

| Pregunta | Tu respuesta |
|---|---|
| ¿Qué columna une las dos tablas? | |
| ¿Por qué ahora aparece 'Leticia' y no '6'? | |

### Paso 5 — Doble JOIN: ciudad Y producto

```sql
SELECT
    f.TransaccionID,
    c.Ciudad    AS Ciudad,
    p.Producto  AS Producto,
    f.Cantidad,
    ROUND(f.Precio_Venta * f.Cantidad * (1-f.Descuento_Pct), 2) AS Venta_Neta
FROM FactVentas f
INNER JOIN DimCiudad   c ON f.CiudadID   = c.CiudadID
INNER JOIN DimProducto p ON f.ProductoID = p.ProductoID
LIMIT 10;
```

---

## La consulta maestra — JOIN + GROUP BY (30 min)

Esta es la consulta más importante de la Unidad 2. Reproduce el dashboard de S4 en SQL:

```sql
SELECT
    c.Ciudad                                               AS Ciudad,
    COUNT(*)                                               AS Transacciones,
    ROUND(SUM(f.Precio_Venta * f.Cantidad * (1-f.Descuento_Pct)), 2) AS Venta_Neta,
    ROUND(SUM(f.Costo_Envio), 2)                           AS Costo_Envio_Total,
    ROUND(SUM(
        f.Precio_Venta * f.Cantidad * (1-f.Descuento_Pct)
        - f.Costo_Envio
    ), 2)                                                  AS Margen_Aproximado
FROM FactVentas f
INNER JOIN DimCiudad c ON f.CiudadID = c.CiudadID
GROUP BY c.Ciudad
ORDER BY Margen_Aproximado ASC;
```

| Pregunta | Tu respuesta |
|---|---|
| ¿Aparece 'Leticia' con Margen_Aproximado negativo? | SÍ / NO |
| ¿Cuánto es esa pérdida? | |
| ¿Coincide este resultado con el dashboard de Power BI de S4? | |

---

## Práctica autónoma (ENTREGABLE)

### Ejercicio 1
Muestra nombre del producto, categoría y venta neta total de cada producto. Ordena de mayor a menor.

```sql
-- Tu consulta:
```

### Ejercicio 2
¿Cuál producto vendió más en Leticia? Usa JOIN + WHERE + GROUP BY.

```sql
-- Tu consulta:
```

### Ejercicio 3
Reproduce la tabla del dashboard de S4 completa: Ciudad, Ventas, Utilidad, Margen%. Con nombres reales.

```sql
-- Ya la escribiste arriba — ¿coincide con S4?
```

---

## Lo que aprendiste en la Unidad 2

| Sesión | Comando clave | Pregunta que responde |
|---|---|---|
| S6 | CREATE TABLE + INSERT | ¿Cómo estructuro y cargo los datos? |
| S7 | SELECT + WHERE + ORDER BY | ¿Cómo filtro y ordeno? |
| S8 | GROUP BY + SUM | ¿Cuánto suma cada ciudad? |
| S9 | JOIN | ¿Cómo veo 'Leticia' en lugar de '6'? |

---

## Lo que viene en Python

La próxima sesión arrancas Python en Google Colab. Sin instalación. Sin drivers. Sin `No database selected`. Solo abres el navegador, cargas el CSV de NovaMarket y en 3 líneas de código describes el dataset completo. El mismo que has analizado desde S3.

---
*Sesión Express S8+S9 | El Veredicto en SQL | NovaMarket Tech*
