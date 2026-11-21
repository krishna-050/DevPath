import 'dart:math';

import 'package:dev_path/Widgets/app_snackbar.dart';
import 'package:dev_path/data/avatar_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GetStorage storage = GetStorage();
  final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  bool _googleInitialized = false;

  Future<void> _initializeGoogleSignIn() async {
    if (_googleInitialized) return;

    await _googleSignIn.initialize();
    _googleInitialized = true;
  }

  Future<bool> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      final user = userCredential.user;

      if (user != null) {
        // Save user's name
        await user.updateDisplayName(name.trim());

        // Assign random avatar
        final randomAvatar =
            AvatarData.avatars[Random().nextInt(AvatarData.avatars.length)];

        await storage.write('profileAvatar_${user.uid}', randomAvatar);

        // Send verification email
        await user.sendEmailVerification();
      }

      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong';

      if (e.code == 'email-already-in-use') {
        message = 'This email is already registered';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many requests. Please try again later.';
      }

      AppSnackBar.show(
        title: 'Signup Failed',
        message: message,
        type: SnackBarType.error,
      );
      return false;
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: 'Unable to complete signup. Please try again.',
        type: SnackBarType.error,
      );
      return false;
    }
  }

  Future<bool> login({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

      var user = _auth.currentUser;

      if (user != null) {
        // Refresh latest Firebase user data
        await user.reload();
        user = _auth.currentUser;

        // Block unverified users
        if (user == null || !user.emailVerified) {
          await _auth.signOut();

          AppSnackBar.show(
            title: 'Email Not Verified',
            message: 'Please verify your email before logging in.',
            type: SnackBarType.warning,
          );

          return false;
        }

        // Check whether avatar exists
        final avatarKey = 'profileAvatar_${user.uid}';

        if (storage.read(avatarKey) == null) {
          final randomAvatar =
              AvatarData.avatars[Random().nextInt(AvatarData.avatars.length)];

          await storage.write(avatarKey, randomAvatar);
        }
      }

      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong';

      if (e.code == 'user-not-found') {
        message = 'No account found with this email';
      } else if (e.code == 'wrong-password') {
        message = 'Incorrect password';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      } else if (e.code == 'invalid-credential') {
        message = 'Invalid email or password';
      } else if (e.code == 'too-many-requests') {
        message = 'Too many attempts. Try again later';
      }

      AppSnackBar.show(
        title: 'Login Failed',
        message: message,
        type: SnackBarType.error,
      );
      return false;
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: 'Something went wrong',
        type: SnackBarType.error,
      );
      return false;
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      // Initialize Google Sign-In
      await _initializeGoogleSignIn();

      // Open Google account picker
      final GoogleSignInAccount googleUser = await _googleSignIn.authenticate();

      // Get Google authentication token
      final GoogleSignInAuthentication googleAuth = googleUser.authentication;

      final idToken = googleAuth.idToken;

      if (idToken == null) {
        AppSnackBar.show(
          title: 'Google Sign-In Failed',
          message: 'Unable to get Google authentication token.',
          type: SnackBarType.error,
        );
        return false;
      }

      // Create Firebase credential
      final credential = GoogleAuthProvider.credential(idToken: idToken);

      // Sign in with Firebase
      final userCredential = await _auth.signInWithCredential(credential);

      final user = userCredential.user;

      if (user == null) {
        return false;
      }

      // Save avatar only if it doesn't already exist
      final avatarKey = 'profileAvatar_${user.uid}';

      if (storage.read(avatarKey) == null) {
        final randomAvatar =
            AvatarData.avatars[Random().nextInt(AvatarData.avatars.length)];

        await storage.write(avatarKey, randomAvatar);
      }

      AppSnackBar.show(
        title: 'Welcome',
        message: 'Google Sign-In successful!',
        type: SnackBarType.success,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      AppSnackBar.show(
        title: 'Google Sign-In Failed',
        message: e.message ?? 'Firebase authentication failed.',
        type: SnackBarType.error,
      );
      return false;
    } on GoogleSignInException catch (e) {
      debugPrint('GOOGLE SIGN-IN ERROR: ${e.code}');

      AppSnackBar.show(
        title: 'Google Sign-In Failed',
        message: 'Unable to sign in with Google.',
        type: SnackBarType.error,
      );
      return false;
    } catch (e) {
      debugPrint('GOOGLE SIGN-IN ERROR: $e');

      AppSnackBar.show(
        title: 'Error',
        message: 'Something went wrong. Please try again.',
        type: SnackBarType.error,
      );
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      await _auth.signOut();
      await _googleSignIn.signOut();

      debugPrint('LOGOUT SUCCESS: ${_auth.currentUser}');

      return _auth.currentUser == null;
    } on FirebaseAuthException catch (e) {
      debugPrint('LOGOUT FIREBASE ERROR: ${e.code} - ${e.message}');

      AppSnackBar.show(
        title: 'Logout Failed',
        message: e.message ?? 'Please try again.',
        type: SnackBarType.error,
      );
      return false;
    } catch (e) {
      debugPrint('LOGOUT ERROR: $e');

      AppSnackBar.show(
        title: 'Logout Failed',
        message: 'Unable to logout. Please try again.',
        type: SnackBarType.error,
      );
      return false;
    }
  }

  Future<bool> deleteUnverifiedAccount() async {
    try {
      final user = _auth.currentUser;

      if (user == null) return true;

      await user.reload();

      final currentUser = _auth.currentUser;

      if (currentUser == null) return true;

      // Verified account ko galti se delete nahi karna.
      if (currentUser.emailVerified) {
        AppSnackBar.show(
          title: 'Already Verified',
          message: 'Your email is already verified.',
          type: SnackBarType.info,
        );
        return false;
      }

      final avatarKey = 'profileAvatar_${currentUser.uid}';

      await currentUser.delete();
      await storage.remove(avatarKey);

      return true;
    } on FirebaseAuthException catch (e) {
      AppSnackBar.show(
        title: 'Unable to Cancel Signup',
        message: e.message ?? 'Please try again.',
        type: SnackBarType.error,
      );
      return false;
    } catch (_) {
      AppSnackBar.show(
        title: 'Error',
        message: 'Unable to cancel signup. Please try again.',
        type: SnackBarType.error,
      );
      return false;
    }
  }

  Future<bool> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email.trim());

      AppSnackBar.show(
        title: 'Email Sent',
        message: 'Password reset link has been sent to your email.',
        type: SnackBarType.success,
      );

      return true;
    } on FirebaseAuthException catch (e) {
      AppSnackBar.show(
        title: 'Reset Failed',
        message: e.message ?? 'Unable to send password reset email.',
        type: SnackBarType.error,
      );

      return false;
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: 'Something went wrong. Please try again.',
        type: SnackBarType.error,
      );

      return false;
    }
  }

  Future<bool> updateProfileName(String newName) async {
    try {
      final user = _auth.currentUser;

      if (user == null) return false;

      await user.updateDisplayName(newName.trim());
      await user.reload();

      return _auth.currentUser?.displayName == newName.trim();
    } on FirebaseAuthException catch (e) {
      AppSnackBar.show(
        title: 'Update Failed',
        message: e.message ?? 'Could not update name.',
        type: SnackBarType.error,
      );
      return false;
    } catch (e) {
      AppSnackBar.show(
        title: 'Error',
        message: 'Unable to update profile. Please try again.',
        type: SnackBarType.error,
      );
      return false;
    }
  }

  Future<bool> updateAvatar(String newAvatarPath) async {
    try {
      final user = _auth.currentUser;

      if (user == null) return false;

      await storage.write('profileAvatar_${user.uid}', newAvatarPath);

      return true;
    } catch (e) {
      AppSnackBar.show(
        title: 'Avatar Update Failed',
        message: 'Unable to update avatar. Please try again.',
        type: SnackBarType.error,
      );
      return false;
    }
  }
}
