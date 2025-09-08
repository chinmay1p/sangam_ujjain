# Firebase Setup Instructions for SANGAM App

## 1. Firebase Console Setup

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Select your project: `sangam-6529f`
3. Enable the following services:

### Authentication
1. Go to Authentication > Sign-in method
2. Enable "Email/Password" provider
3. Save the configuration

### Firestore Database
1. Go to Firestore Database
2. Click "Create database"
3. Choose "Start in test mode" (for development)
4. Select a location (choose closest to your users)
5. Click "Done"

### Security Rules (IMPORTANT)
1. Go to Firestore Database > Rules
2. Replace the default rules with:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Allow all reads and writes for development
    // TODO: Implement proper security rules for production
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
```

3. Click "Publish"

## 2. Get Configuration Files

### For Android
1. Go to Project Settings > General
2. Scroll down to "Your apps"
3. Click on Android app or add one if not exists
4. Package name: `com.example.sangam_app`
5. Download `google-services.json`
6. Replace the existing file in `android/app/google-services.json`

### For Web (if needed)
1. In the same "Your apps" section
2. Click on Web app or add one
3. Copy the configuration object
4. Update `lib/firebase_options.dart` with the real values

## 3. Service Account (for server-side operations)
1. Go to Project Settings > Service accounts
2. Click "Generate new private key"
3. Download the JSON file
4. This is your `sangam-service-account.json` file

## 4. Test the Setup
1. Run the app: `flutter run`
2. Try to register a new user
3. Check Firestore console to see if data is being written

## 5. Production Security Rules (for later)
Once development is complete, update Firestore rules to:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read and write their own user document
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid != null;
    }
    
    // Users can read and write the counter document for generating SANGAM IDs
    match /counters/{counterId} {
      allow read, write: if request.auth != null;
    }
    
    // Allow authenticated users to read other users' basic info for family connections
    match /users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && 
        (request.auth.uid == userId || 
         // Allow family member updates
         resource.data.familyMemberIds.hasAny(request.auth.uid) ||
         // Allow pending request updates
         resource.data.pendingFamilyRequests.hasAny(request.auth.uid));
    }
  }
}
```

## Current Issue
The app is getting permission denied errors because:
1. Firestore security rules are blocking operations
2. Need to set up proper authentication
3. Need to configure the database in test mode

## Quick Fix
1. Go to Firebase Console > Firestore Database > Rules
2. Replace with: `allow read, write: if true;`
3. Publish the rules
4. Try running the app again
