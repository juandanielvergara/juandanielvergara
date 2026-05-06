# 🛠️ Detalle del Código: El Cargador Simple

Este manual explica cómo funciona el script `03_Cargador_Excel_a_SQLite.py`. Al haber limpiado los datos previamente en la Sesión 03, el código de Python es muy corto y fácil de seguir.

### 1. Carga de Datos Limpios
El script abre el archivo `04_Ventas_Datos_Limpios_S03.xlsx`. 
- **Presupuesto:** Asumimos que los datos ya pasaron por Power Query y no tienen errores de mayúsculas, espacios o tipos de datos.

### 2. Creación de Dimensiones (Normalización)
Aunque el Excel es una tabla plana, en SQL preferimos el **Modelo Estrella**.
- **Producto e ID:** El script busca todos los productos únicos y les asigna un número identificador (`ProductoID`).
- **Ciudad e ID:** Hace lo mismo con las ciudades y les asigna una **Región** (ej. Cali -> Pacífico).

### 3. Generación de la Tabla de Hechos (FactVentas)
Para que las consultas SQL sean potentes y rápidas:
- El script reemplaza los nombres largos de productos y ciudades por sus **IDs numéricos**.
- También convierte la columna de fecha en un número entero (`FechaID`) que es más fácil de filtrar para SQL.

### 4. El Corazón: SQLite
Finalmente, el script crea el archivo físico `Novamarket_S07.db` e inyecta las tablas terminadas en él.

> [!TIP]
> **Simplicidad ante todo:** Al tener un Excel impecable, el código de Python se reduce a poco más de 50 líneas, siendo una excelente introducción a la automatización de datos.
