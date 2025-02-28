from auth import get_access_token
from fetch_tracks import get_recent_tracks




def main():
    token = get_access_token()
    get_recent_tracks(token)


if __name__ == '__main__':
    main()
