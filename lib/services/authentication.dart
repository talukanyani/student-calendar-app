import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/utils/enums.dart';

class Auth {
  static final _auth = FirebaseAuth.instance;
  final _currentUser = _auth.currentUser;

  User? get currentUser => _currentUser;
  Stream<User?> get userChanges => _auth.userChanges();

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
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> updateName(String displayName) async {
    try {
      await _currentUser?.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'network-request-failed') return AuthStatus.networkError;
      return AuthStatus.unknownError;
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> changeEmail(String password, String newEmail) async {
    final oldEmail = _currentUser?.email ?? '';

    if (newEmail == oldEmail) return AuthStatus.emailInUse;

    try {
      await _currentUser?.updateEmail(newEmail);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return _reauthenticate(oldEmail, password).then((status) {
            if (status == AuthStatus.done) {
              return changeEmail(password, newEmail);
            } else {
              return status;
            }
          });
        case 'network-request-failed':
          return AuthStatus.networkError;
        case 'email-already-in-use':
          return AuthStatus.emailInUse;
        default:
          return AuthStatus.unknownError;
      }
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> changePassword(
    String oldPassword,
    String newPassword,
  ) async {
    final email = _currentUser?.email ?? '';

    try {
      await _currentUser?.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return _reauthenticate(email, oldPassword).then((status) {
            if (status == AuthStatus.done) {
              return changePassword(oldPassword, newPassword);
            } else {
              return status;
            }
          });
        case 'network-request-failed':
          return AuthStatus.networkError;
        case 'weak-password':
          return AuthStatus.weakPassword;
        default:
          return AuthStatus.unknownError;
      }
    }

    return AuthStatus.done;
  }

  Future<AuthStatus> deleteProfile(String password) async {
    final email = _currentUser?.email ?? '';

    try {
      await _currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'requires-recent-login':
          return _reauthenticate(email, password).then((status) {
            if (status == AuthStatus.done) {
              return deleteProfile(password);
            } else {
              return status;
            }
          });
        case 'network-request-failed':
          return AuthStatus.networkError;
        default:
          return AuthStatus.unknownError;
      }
    }

    return AuthStatus.done;
  }

  Future<void> sendVerificationEmail() async {
    try {
      await _currentUser?.sendEmailVerification();
    } catch (e) {
      return;
    }
  }

  Future<bool> checkEmailVerified() async {
    try {
      await _currentUser?.reload();
    } catch (e) {
      return false;
    }

    return _currentUser?.emailVerified ?? false;
  }

  Future<AuthStatus> _reauthenticate(String email, String password) async {
    final credential = EmailAuthProvider.credential(
      email: email,
      password: password,
    );

    try {
      await _currentUser?.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      AuthStatus status;
      switch (e.code) {
        case 'network-request-failed':
          status = AuthStatus.networkError;
          break;
        case 'wrong-password':
          status = AuthStatus.wrongPassword;
          break;
        default:
          status = AuthStatus.unknownError;
      }
      return status;
    }

    return AuthStatus.done;
  }
}
