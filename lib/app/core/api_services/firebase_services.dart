import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shomoshotime/app/all_utils/log.dart';

class FirebaseAuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<Map<String, String>?> signInWithGoogle() async {
    try {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;

      await googleSignIn.initialize();

      final GoogleSignInAccount googleUser = await googleSignIn.authenticate();

      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
      );

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
          'image': user.photoURL ?? '',
        };
      }

      return null;
    } on FirebaseAuthException catch (e) {
      AppLogger.log('Firebase Auth Error: ${e.code} - ${e.message}');
      return null;
    } catch (e) {
      AppLogger.log('Error signing in with Google: $e');
      return null;
    }
  }

  /// Sign out from Google and Firebase
  Future<void> signOut() async {
    try {
      await GoogleSignIn.instance.signOut();
      await _auth.signOut();
    } catch (e) {
      AppLogger.log('Error signing out: $e');
    }
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;
}
