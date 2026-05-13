# Guía de Conexión y Uso de Antigravity (Sesión 8 y 9 Express)

¡Hola! Para esta sesión express hemos simplificado el entorno. **Ya no tienes que crear la base de datos**. Te la hemos entregado lista, con todos los 500 registros y las tablas completas.

Tu único objetivo es ejecutar las consultas SQL. Sigue estos simples pasos:

## Paso 1: Abrir la carpeta en VS Code
Asegúrate de estar posicionado en la raíz de tu repositorio `SQL_NovaMarket` en VS Code, y luego navega a la carpeta `03_Sesion_08_09`.

## Paso 2: Conectar la Base de Datos
1. Abre el panel lateral de VS Code y haz clic en el ícono de **SQLTools** (el cilindro de base de datos).
2. Deberías ver tus conexiones anteriores. Si no tienes una conexión que apunte a la base de datos actual, haz clic en **"Add New Connection"** (Añadir nueva conexión).
3. Selecciona **SQLite (Node)**.
4. En **Connection name**, escribe `NovaMarket_S08S09`.
5. En **Database file**, haz clic en el botón para buscar el archivo y selecciona `Novamarket_S08S09.db` que está dentro de esta misma carpeta (`03_Sesion_08_09`).
6. Haz clic en **Save Connection** y luego en **Connect Now**.
7. Verás un punto verde indicando que estás conectado.

## Paso 3: Abrir el Laboratorio
1. Abre el archivo `03_Laboratorio_Consultas.sql` que se encuentra en esta carpeta.
2. Asegúrate de que en la esquina superior del archivo (o en la barra de estado de abajo) aparezca la conexión `NovaMarket_S08S09`. Si dice "No active connection", haz clic ahí y selecciona la conexión que acabas de crear.

## Paso 4: Ejecutar Consultas
* Para ejecutar una consulta, simplemente selecciona el bloque de código SQL con tu ratón.
* Presiona `Cmd + E` (en Mac) o `Ctrl + E` (en Windows) para que Antigravity ejecute la consulta.
* Los resultados aparecerán en un panel a la derecha o en la parte inferior.

¡Eso es todo! Lee la guía conceptual `01_Guia_S08S09_Conceptual.md` y ve resolviendo los ejercicios dentro del archivo `03_Laboratorio_Consultas.sql`.
