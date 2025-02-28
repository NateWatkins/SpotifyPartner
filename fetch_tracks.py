import requests
from auth import refresh_access_token


def get_recent_tracks(access_token):
    url = 'https://api.spotify.com/v1/me/player/recently-played?limit=1'
    headers = {'Authorization': f'Bearer {access_token}'}

    response = requests.get(url, headers=headers)

    # If token expired, refresh it and retry
    if response.status_code == 401:
        print('Access token expired, refreshing...')
        access_token = refresh_access_token()
        headers['Authorization'] = f'Bearer {access_token}'
        response = requests.get(url, headers=headers)

    data = response.json()


    track_info = []


    for item in data.get('items', []):
        track = item['track']
        
        artists = ', '.join(artist['name'] for artist in track['artists'])
        print(f"{track['name']} by {artists}")
        album_name = track['album']['name']
        album_art_url = track['album']['images'][0]['url']  # Typically, the first image is the largest
        
        track_info = {
            'name': track['name'],
            'artists': artists,
            'album': album_name,
            'album_art': album_art_url
        }
    print(track_info)
