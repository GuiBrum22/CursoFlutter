import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthFirebase {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //métodos Registro
  Future<void> signUp(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      print(e.toString());
    }
  }

  //método Login
  Future<User?> signIn(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password);
      return _auth.currentUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //logout
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
