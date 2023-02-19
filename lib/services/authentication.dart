import 'package:firebase_auth/firebase_auth.dart';
import '../utils/enums.dart';

class Auth {
  final _auth = FirebaseAuth.instance;

  User? get currentUser => _auth.currentUser;

  Future<AuthStatus> createProfile(String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      AuthStatus status;
      switch (e.code) {
        case 'network-request-failed':
          status = AuthStatus.networkError;
          break;
        case 'email-already-in-use':
          status = AuthStatus.emailInUse;
          break;
        case 'weak-password':
          status = AuthStatus.weakPassword;
          break;
        default:
          status = AuthStatus.unknownError;
      }
      return status;
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      AuthStatus status;
      switch (e.code) {
        case 'network-request-failed':
          status = AuthStatus.networkError;
          break;
        case 'user-not-found':
          status = AuthStatus.profileNotFound;
          break;
        case 'wrong-password':
          status = AuthStatus.wrongPassword;
          break;
        default:
          status = AuthStatus.unknownError;
      }
      return status;
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> logout() async {
    try {
      await _auth.signOut();
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> resetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      AuthStatus status;
      switch (e.code) {
        case 'network-request-failed':
          status = AuthStatus.networkError;
          break;
        case 'user-not-found':
          status = AuthStatus.profileNotFound;
          break;
        default:
          status = AuthStatus.unknownError;
      }
      return status;
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.done;
  }
}
