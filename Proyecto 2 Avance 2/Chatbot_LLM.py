from pyswip import Prolog 
import ollama
from pathlib import Path

#Modelo de lenguaje a utilizar
MODELO = "qwen2.5:7b"

#Base de conocimiento de prolog
prolog = Prolog()
#Ruta completa al archivo, para que funcione sin importar desde donde se ejecute
RUTA_PL = (Path(__file__).parent / "Pokemon.pl").as_posix()
prolog.consult(RUTA_PL)

#Prompt para traducir la pregunta del usuario a una consulta de Prolog
TRADUCIR = """ Traduce la pregunta del usuario a UNA consulta que pueda ser respondida por la base de conocimiento de Prolog.
Predicados y Reglas disponibles:
- pokemon(P)
- tipo(P, T)
- entrenador(E)
- tiene(E, P)
- fuerte_contra(TipoAtaque, TipoDefensa)
- debil_contra(P, TipoAtaque)
- doblemente_debil(P, TipoAtaque)
- entrenador_vulnerable(E, TipoAtaque)
- tiene_ventaja(P1, P2)
Nombres solo en minuscula y sin tildes(ej: psiquico,electrico,ho_oh). Utiliza variables en Mayuscula. No agregues explicaciones ni comentarios. Solo devuelve la consulta de Prolog.
Sin punto final ni explicaciones, Nunca uses _ como variable. Usa siempre variables como E, P o T, "ganarle", "vencer" o "ser fuerte contra" un pokémon significa tiene_ventaja(Atacante, Defensor).
Ejemplos:
¿Qué tipo es charizard? -> tipo(charizard, T)
¿Quién tiene a gyarados? -> tiene(E, gyarados)
¿Contra qué pokémon es fuerte charizard? -> tiene_ventaja(charizard, P)
¿Qué pokémon de tipo agua tiene misty? -> tiene(misty, P), tipo(P, agua)
¿Qué pokémon le pueden ganar a gengar? -> tiene_ventaja(P, gengar)

"""
#Redcar la respuesta de Prolog al usuario
REDACTAR = """Responde la pregunta en español, de forma breve, usando SOLO los resultados de Prolog.
Si los resultados son una lista de nombres, menciónalos TODOS en tu respuesta.
Si el resultado dice "Sí" o "No", responde con eso.
No agregues ni inventes información que no esté en los resultados.
Si la pregunta es de tipo "qué/quién/cuál" y el resultado es falso o vacío, responde que esa información no está en la base de conocimiento."""

#Palabras prohibidas para evitar que el usuario haga consultas directas a Prolog
PROHIBIDOS = ["halt", "assert", "retract", "shell", "consult"]

def solicitud_al_llm(instrucciones,mensaje):
    r = ollama.chat(
        model = MODELO,
        messages = [{"role": "system", "content": instrucciones},
                    {"role": "user", "content": mensaje}],
                    options = {"temperature": 0},
    )
    return r["message"]["content"].strip()

def interpretar(resultados):
    if resultados == []:
        return "No (Prolog indica falso)."
    elif resultados == [{}]:
        return "Sí (Prolog indica verdadero)."
    else:
        #Convierte [{'E': 'red'}, {'E': 'misty'}] en "red, misty"
        valores = []
        for r in resultados:
            valores.append(" - ".join(str(v) for v in r.values()))
        return ", ".join(valores)
    

def responder(pregunta):
    #Traduccion de la pregunta a consulta de Prolog
    consulta = solicitud_al_llm(TRADUCIR, pregunta)
    consulta = consulta.strip("`").replace("?-","").strip().rstrip(".")
    print("Consulta generada:", consulta)  #para depurar: muestra lo que entendio el LLM

    if any(p in consulta for p in PROHIBIDOS):
        return "No se permiten consultas directas a Prolog."

    #Ejecucion de la consulta en Prolog
    try:
        resultados = list(prolog.query(consulta))
    except Exception:
        return "No logro entender la pregunta, por favor intenta con otra."

    #Evita duplicados en los resultados (se hace ANTES de interpretar,
    #porque interpretar convierte la lista en texto)
    sin_repetir = []
    for r in resultados:
        if r not in sin_repetir:
            sin_repetir.append(r)
    print("Resultados de Prolog:", sin_repetir)
    resultados = interpretar(sin_repetir)

    datos = f"Pregunta: {pregunta}\nConsulta: {consulta}\nResultados: {resultados}"
    return solicitud_al_llm(REDACTAR, datos)

if __name__ == "__main__":
    while True:
        pregunta = input("Pregunta: ")
        if pregunta.lower() in ["salir", "exit"]:
            break
        print("Bot:", responder(pregunta))

