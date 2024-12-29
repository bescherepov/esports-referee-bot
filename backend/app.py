from flask import Flask, request, jsonify
MATCHES = [
    {
        'team1': 'Red',
        'team2': 'Blue',
        'team1_score': '2',
        'team2_score': '0'
    }
]

app = Flask(__name__)
app.config.from_object(__name__)

@app.route('/matches', methods=['GET'])
def all_matches():
    return jsonify({
        'status': 'success',
        'matches': MATCHES
    })

if __name__ == '__main__':
    app.run()


