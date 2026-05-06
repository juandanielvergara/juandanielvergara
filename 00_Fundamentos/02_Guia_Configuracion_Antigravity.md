# 🛠️ Guía de Configuración: Entorno de Datos NovaMarket

Esta guía te permitirá configurar tu entorno profesional de análisis de datos de forma robusta. Sigue cada paso prestando atención al **Dónde**, el **Qué**, el **Cuándo** y el **Por qué**.

---

## Paso 0: Identidad y Control (Git) ⚙️
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En la Terminal de VS Code (**Carpeta Raíz**). |
| **¿Qué?** | Instalar Git y configurar tu nombre/correo. |
| **¿Cuándo?** | **Una sola vez** al inicio del curso. |
| **¿Por qué?** | Para que tus cambios tengan autoría y el profesor pueda calificar tu trabajo en GitHub. |

**Instrucción:**
1.  **Descargar:** Baja el instalador de la web oficial: [https://git-scm.com/download/](https://git-scm.com/download/)
2.  **Instalar:** Haz doble clic en el archivo descargado y sigue los pasos del asistente en tu computadora.
3.  **Configurar identidad:** Abre la Terminal de VS Code y escribe estos dos comandos con tu información real:
    ```bash
    git config --global user.name "Tu Nombre Real"
    git config --global user.email "tu@email.com"
    ```

---

## Paso 1: El Motor de Datos (Python) 🐍
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En la Terminal de VS Code (**Cualquier carpeta**). |
| **¿Qué?** | Instalar Python y las librerías de datos (`pandas`, `openpyxl`). |
| **¿Cuándo?** | **Una sola vez** antes de ejecutar scripts `.py`. |
| **¿Por qué?** | Python es el motor que transforma archivos Excel en bases de datos `.db`. |

**Instrucción:**
1.  **Descargar:** Baja el instalador de la web oficial.
2.  **Instalar en tu PC (Doble Clic):** Ejecuta el archivo descargado en tu computadora y sigue los pasos del asistente. 
    *   *Súper Importante (Windows):* Debes marcar la casilla **"Add Python to PATH"** al principio de la instalación. Si no lo haces, nada funcionará.
3.  **Verificar:** Para confirmar que se instaló bien en tu sistema, abre la terminal de VS Code y escribe:
    ```bash
    python --version
    ```
4.  **Instalar Librerías:** Solo después de que el paso anterior funcione, instala los "módulos" de datos:
    ```bash
    pip install pandas openpyxl
    ```

---

## Paso 2: El Motor de Ejecución (Node.js) ⚙️
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En la web oficial de Node.js y luego en la Terminal. |
| **¿Qué?** | Instalar el "entorno de ejecución" Node.js. |
| **¿Cuándo?** | **Una sola vez** antes de instalar las extensiones de VS Code. |
| **¿Por qué?** | SQLTools usa Node.js para poder leer tus archivos `.db` sin errores. |

**Instrucción:**
1.  **Descargar:** Entra a [https://nodejs.org/](https://nodejs.org/) y descarga la versión que dice **"LTS"** (es la más estable).
2.  **Instalar:** Ejecuta el instalador y presiona "Siguiente" a todo. 
3.  **Verificar:** En la terminal de VS Code, escribe:
    ```bash
    node --version
    ```
    *Si te sale un número (ej: v20.12.0), ¡estás listo para el siguiente paso!*

> [!CAUTION]
> **ORDEN CRÍTICO:** Debes completar este paso ANTES de configurar SQLTools en el siguiente paso. Si lo haces al revés, entrarás en un ciclo de errores infinito.

---

## Paso 3: Visualización y Herramientas (VS Code) 🧩
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En el menú de Extensiones de VS Code (`Cmd + Shift + X`). |
| **¿Qué?** | Instalar SQLTools y SQLite Viewer. |
| **¿Cuándo?** | **Una sola vez** después de instalar Node.js. |
| **¿Por qué?** | Estas herramientas te permiten ver tus tablas como si fueran Excel y ejecutar código SQL. |

**Extensiones necesarias:**
*   **SQLTools** + **SQLTools SQLite Driver** (Autor: Matheus Teixeira).
*   **SQLite Viewer** (Autor: florianpircher).

---

## Paso 4: Tu Espacio de Trabajo (Fork & Clone) 🍴
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En el navegador (GitHub) y luego en la Terminal de VS Code. |
| **¿Qué?** | Crear tu copia (Fork) y descargarla (Clone). |
| **¿Cuándo?** | **Una sola vez** para iniciar el curso o reiniciar el proyecto. |
| **¿Por qué?** | Para tener tu propio repositorio privado donde subir tus soluciones. |

**Instrucción:**
1.  **Fork:** En GitHub, presiona el botón **Fork** en el repositorio del profesor.
2.  **Clone:** En TU repositorio (el fork), haz clic en el botón verde **<> Code**, selecciona la pestaña **HTTPS** y copia el enlace. En tu terminal escribe:
    ```bash
    git clone https://github.com/TU_USUARIO/SQL_NovaMarket.git
    ```
3.  **Vincular con el Profesor (Súper importante):** Para recibir material nuevo, dile a tu PC quién es el profesor:
    ```bash
    git remote add upstream https://github.com/edwardzd/SQL_NovaMarket.git
    ```

---

## Paso 4.5: Recibir Material Nuevo (Sync & Pull) 📥
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En la Terminal de VS Code (**Carpeta Raíz del proyecto**). |
| **¿Qué?** | Comando `git pull upstream main`. |
| **¿Cuándo?** | **Al inicio de cada clase** para bajar la base de datos y el laboratorio nuevo. |
| **¿Por qué?** | Para descargar guías y laboratorios nuevos directamente del profesor a tu PC. |

**Instrucción:**
Escribe este comando único para actualizarte:
```bash
git pull upstream main
```

---

## Paso 5: El Origen de tus Datos (.db) 💡
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En la Terminal de VS Code (Dentro de la carpeta de la sesión). |
| **¿Qué?** | Crear o generar el archivo físico de la base de datos `.db`. |
| **¿Cuándo?** | **Al inicio de cada laboratorio**, antes de conectar SQLTools. |
| **¿Por qué?** | Sin el archivo `.db`, SQLTools no tendrá datos que mostrar y dará error. |

**Instrucción de Ubicación:**
Antes de crear el archivo, debes estar "parado" dentro de la carpeta de la sesión:
*   **Opción A (Rápida):** Clic derecho sobre la carpeta en el explorador $\rightarrow$ **"Open in Integrated Terminal"**.
*   **Opción B (Comando `cd`):** Escribe `cd` seguido del nombre de la carpeta (ej: `cd 01_Sesion_06`).
*   *Verificación:* Escribe `ls` (Mac) o `dir` (Windows) para confirmar que ves los archivos de esa sesión.

**Instrucción de Creación:**
*   **Sesión 06 (Manual):**
    1.  **Terminal:** Escribe `sqlite3 01_Base_Datos_S06.db "VACUUM;"`.
    2.  **Explorador:** Clic en **"Nuevo Archivo"**, ponle el nombre exacto terminando en `.db`.
*   **Sesión 07 (Automática):**
    1.  Ejecuta el script de Python proporcionado (ej: `05_Puente_S07.py`) para transformar el Excel en una base de datos `.db`.

> [!IMPORTANT]
> **REGLA DE ORO DE LOS NOMBRES:** Para que el profesor identifique tu trabajo, **debes incluir tu nombre** en el archivo (ej: `01_Base_Datos_S06_TuNombre.db` o `Novamarket_S07_TuNombre.db`). Solo los archivos que empiecen con estos nombres oficiales se subirán a GitHub; cualquier otro nombre será ignorado.


---

## Paso 6: Conexión a la Base de Datos ⚡
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En el panel de SQLTools (icono del cilindro). |
| **¿Qué?** | Crear la conexión al archivo `.db` generado en el paso anterior. |
| **¿Cuándo?** | **Cada vez** que cambies de laboratorio o de base de datos. |
| **¿Por qué?** | Para vincular VS Code con tus datos y poder ejecutar consultas. |

**Instrucción:**
1.  Add New Connection > SQLite.
2.  **Database File:** Usa "Copy Path" sobre tu archivo `.db` (ej: `Novamarket_S07.db`) y pégalo allí.
3.  **SAVE & CONNECT**.

---

## Paso 7: Guardar tu Trabajo (Add, Commit & Push) 🚀
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En la Terminal de VS Code (**Carpeta Raíz del proyecto**). |
| **¿Qué?** | Comandos `add`, `commit` y `push`. |
| **¿Cuándo?** | **Al final de la clase**, una vez que hayas terminado tus scripts. |
| **¿Por qué?** | Para que tu avance se guarde en la nube y el profesor pueda calificarlo. |

**Instrucción (El ciclo de 3 pasos):**
```bash
git add .
git commit -m "Solución Sesión 07 terminada"
git push origin main
```

---

## Paso 8: Entrega y Calificación 📤
| Pregunta | Respuesta |
|---|---|
| **¿Dónde?** | En el navegador (Tu perfil de GitHub). |
| **¿Qué?** | Copiar la URL HTTPS de tu repositorio. |
| **¿Cuando?** | Una sola vez para registrar tu trabajo con el profesor. |
| **¿Por qué?** | Para que el profesor pueda entrar a tu código y calificarlo. |

**Instrucción:**
1.  Entra a GitHub y busca tu repositorio `SQL_NovaMarket`.
2.  Copia la URL de la barra de direcciones (ej: `https://github.com/TuUsuario/SQL_NovaMarket`).
3.  **Verificación:** Asegúrate de que el enlace tenga TU nombre de usuario y no el del profesor (`edwardzd`).
4.  Entrega el link por el medio que se te indique (Classroom, chat, etc.).

---


## 🧭 Manual de Supervivencia: Navegación en la Terminal
Si te pierdes o no sabes si estás en la **Raíz**, usa estos comandos "brújula":

| Comando | Acción | Sistema |
|---|---|---|
| `pwd` | **¿Dónde estoy?** | Mac, Windows y Linux |
| `ls` | **¿Qué hay aquí?** | Mac, Windows y Linux |
| `cd ..` | **Ir hacia atrás** | Mac, Windows y Linux |

> [!NOTE]
> **Compatibilidad:** Aunque Windows y Mac son diferentes, la terminal de VS Code es inteligente y acepta estos comandos por igual en ambos sistemas.

> [!TIP]
> **EL TRUCO MAESTRO (Sin códigos):**
> Si quieres abrir la terminal directamente en una carpeta específica:
> 1.  En el explorador de VS Code (izquierda), haz **Clic Derecho** sobre la carpeta.
> 2.  Selecciona **"Open in Integrated Terminal"**.
> 3.  ¡Listo! Ya estás parado exactamente donde necesitas.

---

## 🔄 ¿Necesitas empezar de cero? (Reiniciar sin miedo)
Si sientes que tu carpeta se desordenó o algo dejó de funcionar, puedes borrar la carpeta del proyecto y empezar de nuevo **sin tener que reinstalar nada**.

**Lo que NO tienes que repetir:**
*   ❌ No instales Git de nuevo.
*   ❌ No instales Python ni las librerías (`pandas`, `openpyxl`).
*   ❌ No instales Node.js de nuevo.
*   ❌ No vuelvas a configurar tu nombre y correo.

**Lo ÚNICO que debes hacer:**
1.  Borra la carpeta física en tu computadora.
2.  Repite el **Paso 4 (Clone)** para bajar una copia limpia.
3.  Repite el **Paso 6 (Conexión)** para que SQLTools encuentre la base de datos en su nueva ubicación.

---


## Resumen de Reglas de Oro ✨
1.  **Carpeta Raíz:** Todos los comandos de Git (`push`, `pull`, `commit`) deben ejecutarse estando "parado" en la carpeta principal del proyecto.
2.  **Punto y Coma:** Todas las sentencias SQL terminan en `;`.
3.  **Atajos Universales:** Usa `Ctrl + E` (Windows) o `Cmd + E` (Mac) para ejecutar SQL. 
4.  **Ruta Absoluta:** Usa siempre "Copy Path" para conectar tu base de datos.
5.  **Git es Entregable:** Si no haces `push`, el profesor no puede ver tus respuestas.

---
*Sesión 07 | NovaMarket Tech | Configuración con Antigravity*
