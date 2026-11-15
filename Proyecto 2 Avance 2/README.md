# Chatbot Pokémon: Prolog + LLM

Proyecto N°2 · Fundamentos de Inteligencia Artificial · Universidad Andrés Bello

**Integrantes:** Maximiliano Gallardo, Brandon Recabarren, Pablo Contreras

Chatbot que responde preguntas sobre Pokémon (tipos, entrenadores, debilidades y ventajas) en dos versiones que usan **la misma base de conocimiento** en lógica de primer orden (`Pokemon.pl`):

1. **Versión Prolog:** chatbot por consola basado en palabras clave (`Pokemon.pl`).
2. **Versión LLM + Python:** un modelo de lenguaje local (Ollama) entiende la pregunta en lenguaje natural, la traduce a una consulta Prolog y redacta la respuesta. Tiene una interfaz web hecha con Flask.

---

## Estructura del proyecto

```
├── Pokemon.pl           Base de conocimiento (hechos + reglas) y chatbot en Prolog
├── Chatbot_LLM.py       Conexión Python ↔ Prolog ↔ LLM
├── App.py               Servidor web (Flask)
├── templates/
│   └── index.html       Página del chat (HTML + CSS + JavaScript)
├── requirements.txt     Librerías de Python necesarias
└── Informe_Proyecto_2.pdf
```

---

## ¿Cómo funciona?

```
 index.html ──(pregunta)──► App.py ──► Chatbot_LLM.py
                                            │
                              1. LLM traduce la pregunta a Prolog
                                            │
                              2. Prolog la resuelve con Pokemon.pl
                                            │
                              3. LLM redacta la respuesta
                                            │
 index.html ◄──(respuesta)── App.py ◄───────┘
```

La idea principal es que **el LLM no responde con su propio conocimiento**. Solo interpreta la pregunta y redacta la respuesta; todos los datos salen de la base de conocimiento en Prolog. Así se evita que invente información, y cualquier cambio en `Pokemon.pl` se refleja de inmediato en las respuestas.

### `Pokemon.pl`
Contiene los **hechos** (`pokemon/1`, `tipo/2`, `entrenador/1`, `tiene/2`, `fuerte_contra/2`) y las **reglas** (`debil_contra/2`, `doblemente_debil/2`, `entrenador_vulnerable/2`, `tiene_ventaja/2`), además del chatbot de la primera entrega.

### `Chatbot_LLM.py`
- **Conexión con Prolog:** usa la librería `pyswip` para cargar `Pokemon.pl` y ejecutar consultas desde Python.
- **`TRADUCIR` (prompt):** le indica al LLM los predicados disponibles y le da ejemplos para que transforme la pregunta en una consulta Prolog. Ejemplo: *"¿Quién tiene a gyarados?"* → `tiene(E, gyarados)`.
- **`REDACTAR` (prompt):** le indica al LLM que responda en español usando **solo** los resultados de Prolog.
- **`PROHIBIDOS`:** lista de palabras bloqueadas (`halt`, `assert`, `retract`, `shell`, `consult`) para que el LLM no pueda ejecutar consultas que cierren o modifiquen Prolog.
- **`interpretar()`:** convierte los resultados de Prolog en texto simple: `[]` → "No", `[{}]` → "Sí" y `[{'E': 'red'}, {'E': 'misty'}]` → "red, misty".
- **`responder(pregunta)`:** ejecuta los 3 pasos: traducir, consultar Prolog (sin resultados repetidos) y redactar. En la terminal se imprime la consulta generada y los resultados, para poder revisar qué entendió el modelo.

### `App.py`
Servidor web con Flask que tiene dos rutas:
- **`/` (GET):** envía la página `index.html` al navegador.
- **`/preguntar` (POST):** recibe la pregunta en formato JSON, llama a `responder()` y devuelve la respuesta en JSON.

### `templates/index.html`
Página del chat. Al presionar "Enviar", el JavaScript envía la pregunta a `/preguntar` con `fetch`, espera la respuesta y la agrega a la caja del chat.

---

## Instalación

### 1. Programas necesarios
- **Python 3.10 o superior:** https://www.python.org/downloads/ (o Anaconda).
- **SWI-Prolog (64 bits):** https://www.swi-prolog.org/download/stable
  En Windows, durante la instalación marcar **"Add swipl to the system PATH"**.
- **Ollama:** https://ollama.com/download

> Después de instalar SWI-Prolog u Ollama, cierren y vuelvan a abrir la terminal (o VS Code) para que reconozca los programas nuevos.

### 2. Descargar el modelo de lenguaje
```bash
ollama pull qwen2.5:7b
```
Pesa aproximadamente 4,7 GB. Para verificar que quedó instalado:
```bash
ollama list
```

### 3. Instalar las librerías de Python
Desde la carpeta del proyecto:
```bash
pip install -r requirements.txt
```

---

## Ejecución

### Interfaz web (versión LLM)
```bash
python App.py
```
Cuando la terminal muestre `Running on http://127.0.0.1:5000`, abrir esa dirección en el navegador.
La terminal debe quedar abierta mientras se usa la página. Para detener el servidor, presionar `Ctrl + C`.

### Chat por consola (versión LLM)
```bash
python Chatbot_LLM.py
```
Escribir `salir` para terminar.

### Chatbot en Prolog (versión 1)
Abrir `Pokemon.pl` con SWI-Prolog y ejecutar:
```prolog
?- iniciar_chat.
```

---

## Preguntas de ejemplo
- ¿Qué tipo es charizard?
- ¿Quién tiene a gyarados?
- ¿Es charizard débil contra agua?
- ¿Qué pokémon de tipo agua tiene misty?
- ¿Qué pokémon le pueden ganar a gengar?
- ¿A qué tipos de ataque es vulnerable misty?

---

## Configuración

Para usar otro modelo (por ejemplo, uno más liviano si el PC es lento), cambiar esta línea en `Chatbot_LLM.py` y descargarlo con `ollama pull`:
```python
MODELO = "qwen2.5:3b"
```

Para modificar el conocimiento del chatbot, editar `Pokemon.pl` y reiniciar el programa. Ejemplo:
```prolog
pokemon(lucario).
tipo(lucario, lucha).
tipo(lucario, acero).
tiene(ash, lucario).
```

---

## Problemas comunes

| Error | Solución |
|---|---|
| `model 'qwen2.5:7b' not found` | Falta descargar el modelo: `ollama pull qwen2.5:7b` |
| `'ollama' no se reconoce como comando` | Reiniciar la terminal o VS Code después de instalar Ollama |
| Error de conexión con Ollama | Abrir la aplicación Ollama (debe estar corriendo en segundo plano) |
| `pyswip` no encuentra SWI-Prolog | Verificar que SWI-Prolog sea de 64 bits y esté en el PATH (`swipl --version`) |
| `TemplateNotFound: index.html` | El HTML debe estar dentro de una carpeta llamada exactamente `templates` |
| `ERR_CONNECTION_REFUSED` en el navegador | El servidor no está corriendo: ejecutar `python App.py` y dejar la terminal abierta |
| Las respuestas tardan mucho | Usar un modelo más liviano (`qwen2.5:3b`) |
