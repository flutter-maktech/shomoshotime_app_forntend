import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  /// Sign in with Google
  /// Returns a Map with user data: {google_id, email, name}
  /// Returns null if sign-in fails or is cancelled
  Future<Map<String, String>?> signInWithGoogle() async {
    try {
      // Use the GoogleSignIn singleton instance
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      // Initialize the instance (required in version 7.0.0+)
      await googleSignIn.initialize();

      // Trigger the Google Sign-In flow (signIn replaced by authenticate)
      final GoogleSignInAccount? googleUser = await googleSignIn.authenticate();

      // If user cancels the sign-in
      if (googleUser == null) {
        return null;
      }

      // Obtain the auth details (authentication is now a sync property)
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );

      final User? user = userCredential.user;

      if (user != null) {
        // Return user data for backend API
        return {
          'google_id': user.uid,
          'email': user.email ?? '',
          'name': user.displayName ?? '',
        };
      }

      return null;
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      print('Error signing in with Google: $e');
      return null;
    }
  }

  /// Sign out from Google and Firebase
  Future<void> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
      await _auth.signOut();
    } catch (e) {
      print('Error signing out: $e');
    }
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;
}
