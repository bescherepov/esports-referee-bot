from flask import Flask, request, jsonify
from flask_cors import CORS
import edgedb

username = 'Bogdus'

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

client = edgedb.create_client()

client.close()

@app.route('/matches', methods=['GET'])
def all_matches():
    return jsonify({
        'status': 'success',
        'matches': MATCHES
    })

@app.route('/profile', methods=['GET'])
def profile():
    #TODO auth check
    profile_info = client.query_json(
        'SELECT Referee {name, refRole, tg, vk, matches_count, tour_gameRef_count, tour_count, lan_count, externalTournaments_count} FILTER .name = <str>$name', name=username
    )
    return {
        'status': 'success',
        'profile_info': profile_info
    }

if __name__ == '__main__':
    app.run()



