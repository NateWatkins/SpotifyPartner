from auth import get_access_token
from fetch_tracks import get_recent_tracks
from uploadToFirebase import upload_track_to_firebase



def main():
    token = get_access_token()
    track_info = get_recent_tracks(token)
    if track_info:
        upload_track_to_firebase(track_info)
    else:
        print("No track info found.")

if __name__ == '__main__':
    main()


