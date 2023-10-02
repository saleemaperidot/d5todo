import 'package:firebase_auth/firebase_auth.dart';

class Firebaseservice {
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<User?> signinwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("signing out");
    }
  }

  Future<User?> signiUpwithemailandpassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("signing out");
    }
  }
}
