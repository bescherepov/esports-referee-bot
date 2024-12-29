from flask import Flask, request, jsonify
from flask_cors import CORS
MATCHES = [
    {
        'tournament': 'Tournament #1',
        'team1': 'Red',
        'team2': 'Blue',
        'score': '2:0',
    }
]

app = Flask(__name__)
app.config.from_object(__name__)
CORS(app, resources={r'/*': {'origins': '*'}})

@app.route('/matches', methods=['GET'])
def all_matches():
    return jsonify({
        'status': 'success',
        'matches': MATCHES
    })

if __name__ == '__main__':
    app.run()


