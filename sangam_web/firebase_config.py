import firebase_admin
from firebase_admin import credentials, firestore
import json
import os

# Initialize Firebase Admin SDK
def initialize_firebase():
    """Initialize Firebase Admin SDK with service account"""
    try:
        # Check if Firebase is already initialized
        firebase_admin.get_app()
        return firestore.client()
    except ValueError:
        # Firebase not initialized, initialize it
        service_account_path = os.path.join(os.path.dirname(__file__), 'sangam-service-account.json')
        
        # For now, we'll create a mock service account structure since the provided file is a google-services.json
        # In production, you would need the actual Firebase Admin SDK service account key
        mock_service_account = {
            "type": "service_account",
            "project_id": "sangam-6529f",
            "private_key_id": "mock_key_id",
            "private_key": "-----BEGIN PRIVATE KEY-----\nMOCK_PRIVATE_KEY\n-----END PRIVATE KEY-----\n",
            "client_email": "firebase-adminsdk@sangam-6529f.iam.gserviceaccount.com",
            "client_id": "mock_client_id",
            "auth_uri": "https://accounts.google.com/o/oauth2/auth",
            "token_uri": "https://oauth2.googleapis.com/token",
            "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
            "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk%40sangam-6529f.iam.gserviceaccount.com"
        }
        
        # Use mock credentials for development
        cred = credentials.Certificate(mock_service_account)
        firebase_admin.initialize_app(cred)
        return firestore.client()

# Firestore collections
USERS_COLLECTION = 'users'
LANDMARKS_COLLECTION = 'landmarks'
SEVA_QUESTS_COLLECTION = 'seva_quests'

def get_firestore_client():
    """Get Firestore client instance"""
    return initialize_firebase()
