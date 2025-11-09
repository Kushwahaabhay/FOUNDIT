import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../core/constants.dart';
import '../models/user_model.dart';
import 'firebase_service.dart';

/// Authentication service for FOUNDIT app
/// Handles Google Sign-In with college email domain restriction
class AuthService {
  final FirebaseAuth _auth = FirebaseService.auth;
  final FirebaseFirestore _firestore = FirebaseService.firestore;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  
  /// Get current user stream
  Stream<User?> get authStateChanges => _auth.authStateChanges();
  
  /// Get current user
  User? get currentUser => _auth.currentUser;
  
  /// Sign in with Google (college email only)
  /// Returns UserCredential if successful, throws exception otherwise
  Future<UserCredential> signInWithGoogle() async {
    try {
      // Trigger Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      
      if (googleUser == null) {
        throw Exception('Sign-in cancelled by user');
      }
      
      // Check if email domain is allowed (IMPORTANT: Domain restriction)
      if (!googleUser.email.toLowerCase().endsWith(AppConstants.allowedEmailDomain.toLowerCase())) {
        await _googleSignIn.signOut();
        throw Exception(
          'Only ${AppConstants.collegeShort} email addresses (${AppConstants.allowedEmailDomain}) are allowed'
        );
      }
      
      // Get authentication details
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      
      // Create credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      
      // Sign in to Firebase
      final userCredential = await _auth.signInWithCredential(credential);
      
      // Check if user document exists, create if not
      await _ensureUserDocument(userCredential.user!);
      
      return userCredential;
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw Exception('Sign-in failed: ${e.toString()}');
    }
  }
  
  /// Create or update user profile after authentication
  Future<void> completeUserProfile({
    required String name,
    required String rollNo,
    String? phone,
  }) async {
    try {
      final user = currentUser;
      if (user == null) throw Exception('No user signed in');
      
      final userModel = UserModel(
        uid: user.uid,
        name: name,
        rollNo: rollNo,
        email: user.email!,
        phone: phone,
        isAdmin: false, // Default to false; admin must be set manually in Firestore
        createdAt: DateTime.now(),
      );
      
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set(userModel.toJson(), SetOptions(merge: true));
    } catch (e) {
      throw Exception('Failed to update profile: ${e.toString()}');
    }
  }
  
  /// Get user profile from Firestore
  Future<UserModel?> getUserProfile(String uid) async {
    try {
      final doc = await _firestore
          .collection(AppConstants.usersCollection)
          .doc(uid)
          .get();
      
      if (!doc.exists) return null;
      return UserModel.fromFirestore(doc);
    } catch (e) {
      throw Exception('Failed to get user profile: ${e.toString()}');
    }
  }
  
  /// Get current user profile
  Future<UserModel?> getCurrentUserProfile() async {
    final user = currentUser;
    if (user == null) return null;
    return getUserProfile(user.uid);
  }
  
  /// Check if current user is admin
  Future<bool> isAdmin() async {
    try {
      final profile = await getCurrentUserProfile();
      return profile?.isAdmin ?? false;
    } catch (e) {
      return false;
    }
  }
  
  /// Sign out
  Future<void> signOut() async {
    try {
      await Future.wait([
        _auth.signOut(),
        _googleSignIn.signOut(),
      ]);
    } catch (e) {
      throw Exception('Sign-out failed: ${e.toString()}');
    }
  }
  
  /// Ensure user document exists in Firestore
  Future<void> _ensureUserDocument(User user) async {
    final doc = await _firestore
        .collection(AppConstants.usersCollection)
        .doc(user.uid)
        .get();
    
    if (!doc.exists) {
      // Create basic user document (profile completion required)
      final userModel = UserModel(
        uid: user.uid,
        name: user.displayName ?? '',
        rollNo: '', // To be filled during profile completion
        email: user.email!,
        phone: user.phoneNumber,
        isAdmin: false,
        createdAt: DateTime.now(),
      );
      
      await _firestore
          .collection(AppConstants.usersCollection)
          .doc(user.uid)
          .set(userModel.toJson());
    }
  }
  
  /// Handle Firebase Auth exceptions
  String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'account-exists-with-different-credential':
        return 'An account already exists with this email';
      case 'invalid-credential':
        return 'Invalid credentials. Please try again';
      case 'operation-not-allowed':
        return 'This sign-in method is not enabled';
      case 'user-disabled':
        return 'This account has been disabled';
      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'invalid-verification-code':
        return 'Invalid verification code';
      case 'invalid-verification-id':
        return 'Invalid verification ID';
      default:
        return 'Authentication failed: ${e.message}';
    }
  }
}
