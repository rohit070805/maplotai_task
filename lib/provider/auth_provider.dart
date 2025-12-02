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


  Future<String?> signUp(String email, String password, String name) async {
    try {
      setLoading(true);

      UserCredential cred = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password
      );


      if (cred.user != null) {
        await cred.user!.updateDisplayName(name);
        await cred.user!.reload();
      }

      setLoading(false);
      return null;
    } on FirebaseAuthException catch (e) {
      setLoading(false);
      return e.message ?? "An error occurred during sign up.";
    } catch (e) {
      setLoading(false);
      return "Unknown error: $e";
    }
  }


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


  Future<void> signOut() async {
    await _auth.signOut();
    notifyListeners();
  }
}