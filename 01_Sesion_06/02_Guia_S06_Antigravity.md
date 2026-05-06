# Sesión 06 | Laboratorio Antigravity
## Guía de Ejecución Local (SQLite)

Esta es tu guía práctica para realizar la sesión 6 de manera local usando **VS Code y Antigravity**. Aquí encontrarás todos los comandos y bloques de código listos para ejecutar.

---

## 1. Preparación del Entorno (Crear la Base de Datos)

Para que VS Code pueda ejecutar SQL, primero debemos crear el **archivo físico** de la base de datos. Sin este archivo, no tendrás dónde guardar tus tablas.

1.  **Limpiar:** Si ves un archivo llamado `01_Base_Datos_S06.db` pero está en el lugar equivocado, bórralo.
2.  **Ubicación en Terminal:** Abre tu terminal integrada (`Ctrl + ñ` o `Cmd + J`) y asegúrate de estar en la carpeta correcta:
    ```bash
    cd /Users/macbookpro/Developer/Learning/SQL/01_Sesion_06
    ```
3.  **CREAR EL ARCHIVO (Paso Crítico):** Copia y pega este comando. Es el que "da vida" a tu base de datos:
    ```bash
    sqlite3 01_Base_Datos_S06.db "VACUUM;"
    ```
    *(Verás que ahora el archivo aparece en tu explorador de la izquierda. Si no aparece, la extensión de SQL no tendrá a qué conectarse).*

---

## 2. Conexión en VS Code (SQLTools)

Si usas la extensión **SQLTools** (el icono de base de datos en la barra lateral), sigue estos pasos para "vincular" tu archivo `.sql` con tu base de datos:

1.  Haz clic en el icono de **SQLTools** en la barra lateral.
2.  Haz clic en **Add New Connection**.
3.  Selecciona **SQLite**.
4.  Configura así:
    *   **Connection name:** `Sesion_06`
    *   **Database file:** `/Users/macbookpro/Developer/Learning/SQL/01_Sesion_06/01_Base_Datos_S06.db`
5.  Haz clic en **Save Connection** y luego en el icono del **enchufe (Connect)**.
6.  **Para ejecutar:** Selecciona tu código en el editor y presiona **`Cmd + E`**.

---

## 3. Desarrollo de la Sesión (Bloques A-D)

### Bloque A | Verificar Estructura
En SQLite no necesitamos `CREATE DATABASE`. Puedes pasar directamente a crear las tablas.

### Bloque B | Crear DimProducto (El Contrato)
Escribe esto en tu archivo de laboratorio y ejecútalo con `Cmd + E`:

```sql
CREATE TABLE DimProducto (
    ProductoID   INTEGER       PRIMARY KEY,      -- Identificador único
    Nombre       VARCHAR(100)  NOT NULL,          -- No puede estar vacío
    Categoria    VARCHAR(50)   NOT NULL,          
    Precio       DECIMAL(10,2) NOT NULL,          
    Costo        DECIMAL(10,2) NOT NULL           
);
```

**Verificación:** Para ver si la tabla se creó correctamente, ejecuta:
```sql
PRAGMA table_info('DimProducto');
```

---

### Bloque C | Insertar y Consultar Datos
Ahora "firma" el contrato insertando los primeros productos:

```sql
INSERT INTO DimProducto (ProductoID, Nombre, Categoria, Precio, Costo) VALUES
    (1, 'Laptop Gamer Z',      'Laptops',     2500.00, 1800.00),
    (2, 'Smartphone Pro',      'Smartphones', 1200.00,  800.00),
    (3, 'Smartwatch Q',        'Wearables',    300.00,  180.00),
    (4, 'Audifonos Bluetooth', 'Audio',        150.00,   90.00);
```

**Consulta de prueba (Margen Bruto):**
```sql
SELECT
    Nombre,
    Precio,
    Costo,
    (Precio - Costo) AS Margen_Bruto
FROM DimProducto;
```

---

### Bloque D | DimCiudad + Foreign Key (Desafío Final)
Crea la tabla de ciudades y luego la tabla de ventas para probar la integridad referencial.

**1. Crear DimCiudad:**
```sql
CREATE TABLE DimCiudad (
    CiudadID       INTEGER       PRIMARY KEY,
    Nombre         VARCHAR(100)  NOT NULL,
    Region         VARCHAR(50)   NOT NULL,
    Factor_Envio   DECIMAL(4,2)  NOT NULL,
    Es_Zona_Remota INTEGER       DEFAULT 0
);
```

**2. Insertar Ciudades:**
```sql
INSERT INTO DimCiudad (CiudadID, Nombre, Region, Factor_Envio, Es_Zona_Remota) VALUES
    (1, 'Bogotá', 'Centro', 1.00, 0),
    (6, 'Leticia', 'Amazonia', 8.00, 1);
```

**3. La Prueba de Oro (Foreign Key):**
Crea esta tabla demo y luego intenta insertar una ciudad que NO existe (ej. ID 99). 

> [!IMPORTANT]
> **Activar Reglas:** En SQLite debes activar manualmente las llaves foráneas ejecutando: 
> `PRAGMA foreign_keys = ON;`

```sql
PRAGMA foreign_keys = ON;

CREATE TABLE FactVentas_Demo (
    TransaccionID INTEGER PRIMARY KEY,
    CiudadID      INTEGER NOT NULL,
    Cantidad      INTEGER NOT NULL,
    FOREIGN KEY (CiudadID) REFERENCES DimCiudad(CiudadID)
);

-- ESTO DEBE DAR ERROR:
INSERT INTO FactVentas_Demo VALUES (101, 99, 5); 
```

---

## 4. Próximos Pasos

Si lograste que SQLite rechazara el último `INSERT`, ¡felicidades! Has hecho que el motor SQL trabaje para ti previniendo errores de datos.

👉 **Siguiente Sesión:** [05_Puente_S07.md](file:///Users/macbookpro/Developer/Learning/SQL/01_Sesion_06/05_Puente_S07.md)

---
*Sesión 06 | Antigravity Lab | NovaMarket Tech*
