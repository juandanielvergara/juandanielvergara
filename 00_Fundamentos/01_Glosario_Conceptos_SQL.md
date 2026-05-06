# 📙 GLOSARIO: Conceptos Básicos de SQL (NovaMarket)

Este documento es una "hoja de ruta" para que los estudiantes entiendan qué está pasando bajo el capó.

---

## 1. El Entorno de Trabajo

### ¿Qué es la Terminal?
Es la ventana de texto (la línea de comandos) donde "hablamos" directamente con el sistema operativo. En este laboratorio, la usamos para ejecutar el motor de base de datos.

### ¿Qué es SQLite / SQLite3?
Es el **Motor de Base de Datos**. A diferencia de otros (como MySQL o Oracle), SQLite no necesita un servidor complejo; toda la base de datos es un simple archivo en tu computadora.
*   `sqlite3`: Es el comando que activa el motor en la terminal.

### ¿Qué es el archivo `.db` (`novamarket_v3.db`)?
Es el **Contenedor**. Aquí es donde vive toda la información (ventas, productos, ciudades). Si borras este archivo, borras todo el negocio.

### ¿Qué es un archivo `.sql`?
Es un **Guion (Script)**. Es una lista de instrucciones que ya escribiste en un editor (como VS Code) para no tener que teclearlas una por una en la terminal cada vez.

---

## 2. Los Comandos de Poder

| Comando | Tipo | ¿Para qué sirve? |
| :--- | :--- | :--- |
| `sqlite3 archivo.db` | Terminal | Abre la base de datos y activa el motor. |
| `.tables` | Punto | Muestra un índice de todas las tablas en la base de datos. |
| `.schema Tabla` | Punto | Te enseña "cómo fue construida" la tabla (sus columnas). |
| `.headers on` | Punto | **¡Crucial!** Muestra los nombres de las columnas arriba del resultado. |
| `.mode box` | Punto | Dibuja una caja con bordes bonitos alrededor de tus datos (Estilo Pro). |
| `.shell clear` | Punto | Pide a la computadora que limpie la terminal por completo. |
| `Cmd + K` | Atajo Mac | El secreto rápido para limpiar la terminal en VS Code. |
| `.exit` | Punto | Cierra la conexión y vuelve a la terminal normal de Mac. |
| `SELECT ...;` | SQL | La pregunta mágica. Sirve para extraer datos específicos. |
| `PRAGMA ...;` | SQL | Comandos especiales de SQLite para consultar metadatos técnicos. |
| `.echo on` | Punto | Repite tu comando SQL antes de dar el resultado (Para no perderse). |

---

## 3. ¿Qué significan estos nombres raros?

### `sqlite_master` 📖
Es la **Tabla Mestra**. Es el "libro de registro" secreto que SQLite usa para acordarse de qué tablas has creado. Si le preguntas a esta tabla, ella te dirá todo lo que sabe sobre la estructura de tu proyecto.

### `PRAGMA table_info('MiTabla');` 🔍
Es como hacerle una "radiografía" a una tabla. Nos dice:
1.  Qué columnas tiene.
2.  Qué tipo de dato acepta (Número, Texto, Fecha).
3.  Si es obligatorio llenar ese dato (`NOT NULL`).

---

## 4. Diferencia entre Terminal y Extensiones (VS Code)

*   **En la Terminal:** Es el camino puro. Ves los datos como texto plano. Perfecto para rapidez y diagnóstico.
*   **En las Extensiones (SQLTools / SQLite Viewer):** Es el camino visual. Ves los datos en tablas bonitas (como Excel) y puedes ejecutar el código con un clic (`Cmd + E`).

> [!TIP]
> **Para el estudiante:** Aprende primero en la terminal para entender la lógica, y luego usa las extensiones para aumentar tu productividad.

---

## 5. Git y GitHub: El Guardado de Partida (Backups)

Imagina que Git es como el **"Guardado"** de un videojuego. Para esta actualización, seguimos estos pasos exactos para que tus cambios suban a Internet:

1.  `git status` **(La Inspección):**
    *   *Qué hace:* Nos dice qué archivos modificamos (aparecen en rojo). Es como preguntar: "¿Qué ha cambiado desde la última vez?".

2.  `git add .` **(La Maleta):**
    *   *Qué hace:* Prepara todos los cambios (`.`) para ser guardados. Imagina que estás empacando la maleta antes de un viaje.

3.  `git commit -m "mensaje"` **(La Etiqueta):**
    *   *Qué hace:* Crea un "Checkpoint" o punto de guardado oficial con una nota descriptiva. Es donde decimos oficialmente: "Esto es lo que hice".

4.  `git push origin main` **(El Lanzamiento):**
    *   *Qué hace:* Envía tus cambios desde tu computadora local hacia los servidores de **GitHub** en la nube. ¡Ahora tus cambios son visibles para el mundo!

---

## ¿Por qué lo hicimos así?

Para la actualización de los archivos SQL que me pediste, usamos este flujo porque garantiza que:
1. No perdamos el progreso.
2. Podamos volver atrás si algo falla.
3. Tengas una copia segura en GitHub de todo tu aprendizaje.

---

## 6. Saber dónde estás parado (¡No te confundas!)

Es vital saber a quién le estás hablando en la terminal:

### 💻 Si veas `macbookpro@Username %` (o similar):
*   **Estás en:** La Terminal de Mac (el sistema operativo).
*   **Comandos permitidos:** `git status`, `git add`, `git push`.
*   **Aquí es donde:** Abres la base de datos con `sqlite3 novamarket_v3.db`.

### 🗄️ Si veas `sqlite>`:
*   **Estás en:** El Motor de Base de Datos (SQLite3).
*   **Comandos permitidos:** `SELECT ... ;`, `.tables`, `.exit`.
*   **ERROR COMÚN:** Intentar usar `git` aquí no funcionará. Debes salir con `.exit` primero.

---

## 7. El "Branch" (La Línea Temporal)

Es como un universo paralelo para tu código:
*   `main`: Es el tronco principal del árbol (el juego oficial).
*   **Branches:** Son ramas donde puedes "experimentar" sin romper el tronco principal.

---

## 8. Local vs. Remoto (Borrador vs. Galería)

*   **Local (Tu PC):** Tu taller privado. Aquí haces `git commit`. Solo tú lo ves.
*   **Remoto (GitHub):** La galería pública. Aquí haces `git push`. Todo el mundo lo ve.

---

## 9. Bash, Zsh y los "Modelos" de Terminal

No te asustes si ves nombres raros al abrir la terminal. Son solo "marcas" de intérpretes de comandos:

*   **Bash:** El "clásico" universal. Casi todos los tutoriales en internet lo usan. Es sencillo y robusto.
*   **Zsh (Z Shell):** El moderno que usa **Mac** por defecto. Es el que ves en estas clases. Te ayuda con colores y autocompletado de comandos.
*   **SQL Console / SQLite:** Una terminal "especializada" que SOLO entiende bases de datos. No intentes usar `git` aquí.
*   **JS Debug Terminal:** Una terminal que ya viene con herramientas para encontrar errores en código JavaScript.

> [!IMPORTANT]
> **El Punto y Coma (`;`):** En SQL es como el "punto final". Si no lo pones, SQLite se queda esperando a que termines la frase. ¡No lo olvides!

> [!TIP]
> **Para el estudiante:** Para este curso de SQL, los comandos de Git (`add`, `commit`, `push`) funcionan igual en **Bash** o **Zsh**. ¡No te preocupes por la diferencia!
