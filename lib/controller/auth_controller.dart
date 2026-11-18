
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

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

      await userCredential.user?.updateDisplayName(name.trim());

      return true;
    } on FirebaseAuthException catch (e) {
      String message = 'Something went wrong';

      if (e.code == 'email-already-in-use') {
        message = 'This email is already registered';
      } else if (e.code == 'weak-password') {
        message = 'Password is too weak';
      } else if (e.code == 'invalid-email') {
        message = 'Invalid email address';
      }

      Get.snackbar('Signup Failed', message);
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong. Please try again.');
      return false;
    }
  }

  Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password,
      );

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

      Get.snackbar('Login Failed', message);
      return false;
    } catch (e) {
      Get.snackbar('Error', 'Something went wrong');
      return false;
    }
  }
  Future<bool> logout() async {
    try {
      await _auth.signOut();

      debugPrint('LOGOUT SUCCESS: ${_auth.currentUser}');

      return _auth.currentUser == null;
    } on FirebaseAuthException catch (e) {
      debugPrint('LOGOUT FIREBASE ERROR: ${e.code} - ${e.message}');

      Get.snackbar('Logout Failed', e.message ?? 'Please try again.');
      return false;
    } catch (e) {
      debugPrint('LOGOUT ERROR: $e');

      Get.snackbar('Logout Failed', 'Unable to logout. Please try again.');
      return false;
    }
  }
  }

