import firebase_admin
from firebase_admin import credentials, db
import datetime


# Push to the database


def upload_track_to_firebase(track_info):
    # Initialize Firebase app
    cred = credentials.Certificate("musicbynate-a7be3-firebase-adminsdk-fbsvc-ba6239f92a.json")
    firebase_admin.initialize_app(cred, {
        'databaseURL': 'https://musicbynate-a7be3-default-rtdb.firebaseio.com/'
    })
    ref = db.reference('recent_history')
    ref.push(track_info)




    print("Uploaded to Firebase ")