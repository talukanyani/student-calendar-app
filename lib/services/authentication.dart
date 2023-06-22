import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum AuthStatus {
  done,
  unknownError,
  networkError,
  userNotFound,
  userMismatch,
  resignIn,
}

class Auth {
  static final _auth = FirebaseAuth.instance;
  final _currentUser = _auth.currentUser;

  User? get currentUser => _currentUser;

  Future<AuthStatus> signInWithGoogle() async {
    final credential = await _googleSignIn();

    try {
      await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'network-request-failed':
          return AuthStatus.networkError;
        default:
          return AuthStatus.unknownError;
      }
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      return AuthStatus.unknownError;
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> updateName(String name) async {
    try {
      await _currentUser?.updateDisplayName(name);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'network-request-failed':
          return AuthStatus.networkError;
        default:
          return AuthStatus.unknownError;
      }
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> deleteProfile() async {
    try {
      await _currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return AuthStatus.resignIn;
        case 'network-request-failed':
          return AuthStatus.networkError;
        default:
          return AuthStatus.unknownError;
      }
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> resignInWithGoogle() async {
    final credential = await _googleSignIn();

    try {
      await _currentUser?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'network-request-failed':
          return AuthStatus.networkError;
        case 'user-mismatch':
          return AuthStatus.userMismatch;
        case 'user-not-found':
          return AuthStatus.userNotFound;
        default:
          return AuthStatus.unknownError;
      }
    }

    return AuthStatus.done;
  }

  Future<AuthCredential> _googleSignIn() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser?.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return credential;
  }
}
