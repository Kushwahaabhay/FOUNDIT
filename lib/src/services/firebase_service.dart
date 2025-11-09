import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// Firebase initialization and configuration service
/// This service handles all Firebase setup and provides access to Firebase instances
/// Note: Firebase Storage is replaced with Cloudinary for image hosting
class FirebaseService {
  static FirebaseAuth get auth => FirebaseAuth.instance;
  static FirebaseFirestore get firestore => FirebaseFirestore.instance;
  
  /// Initialize Firebase
  /// Call this in main() before runApp()
  static Future<void> initialize() async {
    await Firebase.initializeApp();
    
    // Enable Firestore offline persistence
    firestore.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }
  
  /// Get current user ID
  static String? get currentUserId => auth.currentUser?.uid;
  
  /// Get current user email
  static String? get currentUserEmail => auth.currentUser?.email;
  
  /// Check if user is signed in
  static bool get isSignedIn => auth.currentUser != null;
  
  /// Get Firestore collection reference
  static CollectionReference collection(String path) {
    return firestore.collection(path);
  }
  
  /// Get Firestore document reference
  static DocumentReference document(String path) {
    return firestore.doc(path);
  }
  

}
