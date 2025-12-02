import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authprovider extends ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Sign Up Function (Saves Name to Auth Profile)
  Future<String?> signUp(String email, String password, String name) async {
    try {
      setLoading(true);

      // 1. Create the User
      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );

      // 2. Update the "Display Name" in Firebase Auth directly
      if (cred.user != null) {
        await cred.user!.updateDisplayName(name);
        await cred.user!.reload(); // Refresh the user to see the change
      }

      setLoading(false);
      return null; // Success
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      return e.message ?? "An error occurred during sign up.";
    } catch (e) {
      setLoading(false);
      return "Unknown error: $e";
    }
  }

  // Sign In Function
  Future<String?> signIn(String email, String password) async {
    try {
      setLoading(true);
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      setLoading(false);
      return null;
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      return e.message ?? "An error occurred during login.";
    } catch (e) {
      setLoading(false);
      return "Unknown error: $e";
    }
  }

  // Sign Out
  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}