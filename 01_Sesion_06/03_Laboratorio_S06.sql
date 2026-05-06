-- 💻 LABORATORIO SESIÓN 6: EL CONTRATO (Antigravity)
-- ═══════════════════════════════════════════════════════════════
-- Guía de Referencia: 02_Guia_S06_Antigravity.md
-- ═══════════════════════════════════════════════════════════════
-- INSTRUCCIONES:
-- 1. Escribe tu código debajo de cada bloque.
-- 2. Para ejecutar: Selecciona con el mouse y presiona Cmd + E.
-- 3. Observa los resultados en la terminal o pestaña de resultados.
-- ══ BLOQUE B — Crear DimProducto ═══════════════════════════════
-- (YA EJECUTADO: La tabla DimProducto ya ha sido creada)
CREATE TABLE IF NOT EXISTS DimProducto (
    ProductoID INTEGER PRIMARY KEY,
    -- llave primaria
    Nombre VARCHAR(100) NOT NULL,
    Categoria VARCHAR(50) NOT NULL,
    Precio DECIMAL(10, 2) NOT NULL,
    Costo DECIMAL(10, 2) NOT NULL
);
PRAGMA table_info('DimProducto');
--ya ejecutado
-- ══ BLOQUE C — Insertar y Consultar Datos ══════════════════════
-- Escribe aquí los INSERT del Bloque C según la guía:
INSERT INTO DimProducto
    (Nombre, Categoria, Precio, Costo)
VALUES
    ('Laptop Gamer Z', 'Laptops', 2500.00, 1800.00),
    ('Smartphone Pro', 'Smartphones', 1200.00, 800.00),
    ('Smartwatch Q', 'Wearables', 300.00, 180.00),
    ('Audifonos Bluetooth', 'Audio', 150.00, 90.00);
SELECT COUNT(*)
FROM DimProducto;
--Bloque ejecutado
--Ver Margen
SELECT Nombre AS Producto,
    Precio,
    Costo,
    (Precio - Costo) AS Margen_Bruto,
    ROUND((Precio - Costo) * 100.0 / Precio, 2) AS Margen_Pct
FROM DimProducto
ORDER BY Margen_Pct DESC;
-- ══ BLOQUE D — DimCiudad + Foreign Key (Desafío) ═══════════════
-- Escribe aquí la creación de DimCiudad y FactVentas_Demo:
CREATE TABLE DimCiudad (
    CiudadID INTEGER PRIMARY KEY,
    Nombre VARCHAR(100) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    Factor_Envio DECIMAL(4, 2) NOT NULL,
    Es_Zona_Remota INTEGER DEFAULT 0 -- 0 = no, 1 = sí
);
INSERT INTO DimCiudad (
        CiudadID,
        Nombre,
        Region,
        Factor_Envio,
        Es_Zona_Remota
    )
VALUES (1, 'Bogotá', 'Centro', 1.00, 0),
    (2, 'Medellín', 'Andina', 1.20, 0),
    (3, 'Cali', 'Pacífico', 1.30, 0),
    (4, 'Barranquilla', 'Caribe', 1.50, 0),
    (5, 'Cartagena', 'Caribe', 1.60, 0),
    (6, 'Leticia', 'Amazonia', 8.00, 1);
SELECT *
FROM DimCiudad
ORDER BY Factor_Envio DESC;

-- ═══════════════════════════════════════════════════════════════
-- Fin del Laboratorio 06