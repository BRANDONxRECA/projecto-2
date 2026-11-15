from Chatbot_LLM import responder
from flask import Flask, request, jsonify,render_template

app = Flask(__name__)

@app.route('/')
def inicio():
    return render_template("index.html")

@app.route('/preguntar', methods=['POST'])
def preguntar():
    pregunta = request.json.get('pregunta')
    return jsonify({'respuesta': responder(pregunta)})

if __name__ == '__main__':
    app.run(debug=True,use_reloader=False,threaded=False)


