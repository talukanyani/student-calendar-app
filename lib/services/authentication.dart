import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<String> createProfile(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') return e.code;
      if (e.code == 'weak-password') return e.code;
      return 'error';
    } catch (e) {
      return 'error';
    }

    return 'done';
  }

  Future<String> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') return e.code;
      if (e.code == 'wrong-password') return e.code;
      return 'error';
    } catch (e) {
      return 'error';
    }

    return 'done';
  }

  Future<String> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      return 'error';
    }

    return 'done';
  }
}
