import requests
import json
import os

CLIENT_ID = '889684e616114392ab4887e5a46de842'
CLIENT_SECRET = 'c4df094176bb40eb8b731df6e40e4aa4'
REDIRECT_URI = 'http://localhost:8888/callback'
TOKEN_URL = 'https://accounts.spotify.com/api/token'
TOKEN_FILE = 'tokens.json'


def load_tokens():
    if os.path.exists(TOKEN_FILE):
        with open(TOKEN_FILE, 'r') as f:
            return json.load(f)
    return None


def save_tokens(tokens):
    with open(TOKEN_FILE, 'w') as f:
        json.dump(tokens, f)


def get_access_token():
    tokens = load_tokens()

    if tokens:
        # If token is not expired, return it
        return tokens['access_token']

    # If no tokens exist, ask for an auth code to get tokens for the first time
    auth_code = input('Enter the Spotify authorization code from URL: ')

    response = requests.post(TOKEN_URL, data={
        'grant_type': 'authorization_code',
        'code': auth_code,
        'redirect_uri': REDIRECT_URI,
        'client_id': CLIENT_ID,
        'client_secret': CLIENT_SECRET,
    })

    tokens = response.json()
    print(tokens)
    save_tokens(tokens)

    return tokens['access_token']


def refresh_access_token():
    tokens = load_tokens()

    response = requests.post(TOKEN_URL, data={
        'grant_type': 'refresh_token',
        'refresh_token': tokens['refresh_token'],
        'client_id': CLIENT_ID,
        'client_secret': CLIENT_SECRET,
    })

    new_tokens = response.json()

    # Keep the old refresh token if Spotify doesn't send a new one
    if 'refresh_token' not in new_tokens:
        new_tokens['refresh_token'] = tokens['refresh_token']

    save_tokens(new_tokens)

    return new_tokens['access_token']
