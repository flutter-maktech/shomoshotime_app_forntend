import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import '../../all_utils/log.dart';

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
      await _auth.signOut();
      if (Platform.isAndroid) {
        await GoogleSignIn.instance.signOut();
      }
    } catch (e) {
      AppLogger.log('Error signing out: $e');
    }
  }

  Future<Map<String, String>?> signInWithApple() async {
    try {
      final appleCredential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );

      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: appleCredential.identityToken,
        accessToken: appleCredential.authorizationCode,
      );

      final userCredential = await FirebaseAuth.instance.signInWithCredential(
        oauthCredential,
      );

      final user = userCredential.user;

      if (user != null) {
        return {
          'google_id': user.uid,
          'email': user.email ?? '',
          'name': user.displayName ?? 'App User',
          'image':
              user.photoURL ??
              "https://img.freepik.com/free-vector/illustration-gallery-icon_53876-27002.jpg",
        };
      }

      return null;
    } catch (e) {
      AppLogger.log('Apple Sign-In Error: $e');
      return null;
    }
  }

  /// Get current user
  User? get currentUser => _auth.currentUser;
}
