import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseDebug {
  static Future<void> checkFirebaseConnection() async {
    try {
      print('🔥 Checking Firebase connection...');
      
      // Check if Firebase is initialized
      if (Firebase.apps.isEmpty) {
        print('❌ Firebase not initialized');
        return;
      }
      print('✅ Firebase initialized');
      
      // Check Firestore connection
      try {
        await FirebaseFirestore.instance.enableNetwork();
        print('✅ Firestore network enabled');
        
        // Try to read a test document
        final testDoc = await FirebaseFirestore.instance
            .collection('test')
            .doc('connection')
            .get();
        print('✅ Firestore read test successful');
      } catch (e) {
        print('❌ Firestore connection failed: $e');
      }
      
      // Check Auth connection
      try {
        final auth = FirebaseAuth.instance;
        print('✅ Firebase Auth initialized');
        print('Current user: ${auth.currentUser?.email ?? 'No user logged in'}');
      } catch (e) {
        print('❌ Firebase Auth failed: $e');
      }
      
    } catch (e) {
      print('❌ Firebase debug check failed: $e');
    }
  }
  
  static Future<void> testFirestoreWrite() async {
    try {
      print('🧪 Testing Firestore write...');
      
      await FirebaseFirestore.instance
          .collection('test')
          .doc('write_test')
          .set({
        'timestamp': DateTime.now().toIso8601String(),
        'message': 'Test write from SANGAM app',
      });
      
      print('✅ Firestore write test successful');
    } catch (e) {
      print('❌ Firestore write test failed: $e');
    }
  }
  
  static Future<void> testCounterWrite() async {
    try {
      print('🧪 Testing counter write...');
      
      await FirebaseFirestore.instance
          .collection('counters')
          .doc('user_counter')
          .set({
        'count': 0,
        'last_updated': DateTime.now().toIso8601String(),
      });
      
      print('✅ Counter write test successful');
    } catch (e) {
      print('❌ Counter write test failed: $e');
    }
  }
}
