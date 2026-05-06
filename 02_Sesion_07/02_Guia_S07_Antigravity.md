# Sesión 07 | Laboratorio Antigravity
## Guía: El Interrogatorio (SQL con NovaMarket)

Esta guía es el compañero práctico de la **Guía Conceptual 01**. Aquí aplicarás los conceptos de `SELECT`, `WHERE` y `ORDER BY` sobre tu base de datos local `Novamarket_S07.db`.

---

## 1. Conexión con SQLTools
Asegúrate de estar conectado a la base de datos que generaste con Python.
1.  **Nombre:** `NovaMarket_S07`
2.  **Database File:** `/Users/macbookpro/Developer/Learning/SQL/02_Sesion_07/Novamarket_S07.db`

---

## 2. El Interrogatorio (Bloques A - E)
Escribe tus consultas en el archivo **`06_Laboratorio_Consultas.sql`**. Al finalizar cada bloque, verifica que el número de filas obtenidas coincida con el **Criterio de Éxito**.

### **Bloque A: Exploración Inicial**
*(Referencia: Guía Conceptual Sección A)*
| # | Ejercicio | Criterio de Éxito |
|---|---|---|
| A1 | Ver las primeras 10 transacciones de la tabla `FactVentas`. | Se muestran 10 filas. |
| A2 | Contar el total de registros en la tabla `FactVentas`. | 1 sola fila con el valor **500**. |
| A3 | Consultar la tabla `DimProducto` con el margen bruto calculado. | 4 filas (los 4 productos). |

### **Bloque B: Columnas y Cálculos**
*(Referencia: Guía Conceptual Sección B)*
| # | Ejercicio | Criterio de Éxito |
|---|---|---|
| B1 | Mostrar `TransaccionID`, `Cantidad`, `Precio_Venta` y `Costo_Envio` de `FactVentas`. | Solo las columnas pedidas. |
| B2 | Calcular `Venta_Bruta` y `Venta_Neta` (redondeada a 2 decimales) en `FactVentas`. | Verás las nuevas columnas. |

### **Bloque C: Filtros WHERE (La Precisión)**
*(Referencia: Guía Conceptual Sección C)*
| # | Ejercicio | Criterio de Éxito |
|---|---|---|
| C1 | Filtrar ventas de **Leticia** (`CiudadID = 6`). | Debes obtener **76 filas**. |
| C2 | Ventas con **Descuento agresivo** (`Descuento_Pct > 0.15`). | Debes obtener **46 filas**. |
| C3 | Ventas de Leticia **CON** descuento (`AND`). | Debes obtener **38 filas**. |
| C4 | Ventas en ciudades del Caribe (**Barranquilla=4, Cartagena=5**). | Debes obtener **154 filas**. |
| C5 | Ventas realizadas en **Noviembre** (`BETWEEN 20231101 AND 20231130`). | Debes obtener **155 filas**. |
| C6 | Buscar productos de la categoría que empieza por **'S'** (`LIKE`). | Debes obtener **2 filas**. |
| C7 | ¿Hay algún registro en `DimFecha` sin nombre de mes? (`IS NULL`). | Debes obtener **0 filas**. |

### **Bloque D: Orden y Límites**
*(Referencia: Guía Conceptual Sección D)*
| # | Ejercicio | Criterio de Éxito |
|---|---|---|
| D1 | Las 10 transacciones con el **Costo de Envío más alto**. | Top 10 visible. |
| D2 | Las 10 transacciones con **Peor Margen Aproximado** (Venta_Neta - Costo_Envio). | Valores negativos arriba. |
| D3 | Las 5 ventas de Leticia con mayor costo de envío. | 5 filas específicas. |

### **Bloque E: Desafíos Autónomos (ENTREGABLES)**
*(Referencia: Guía Conceptual Sección E)*
| # | Desafío | Criterio de Éxito |
|---|---|---|
| E1 | (Fácil) ¿Cuántas ventas hubo en **Septiembre 2023**? | Debes obtener **153 filas**. |
| E2 | (Medio) 10 ventas con más descuento que **NO** sean de Leticia. | 10 filas filtradas. |
| E3 | (Difícil) Ventas de Noviembre con desc. > 20% y Envío > 500. | Debes obtener **6 filas**. |

---
*Sesión 07 | Antigravity Lab | NovaMarket Tech*
