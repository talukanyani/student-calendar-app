import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/services/authentication.dart';
import '../utils/enums.dart';

class AuthenticationController extends ChangeNotifier {
  User? get currentUser => Auth().currentUser;

  Future<AuthStatus> createProfile(String email, String password) {
    return Auth().createProfile(email, password).then((status) {
      notifyListeners();
      return status;
    });
  }

  Future<AuthStatus> login(String email, String password) {
    return Auth().login(email, password).then((status) {
      notifyListeners();
      return status;
    });
  }

  Future<AuthStatus> logout() {
    return Auth().logout().then((status) {
      notifyListeners();
      return status;
    });
  }

  Future<AuthStatus> resetPassword(String email) {
    return Auth().resetPassword(email).then((status) {
      notifyListeners();
      return status;
    });
  }

  Future<AuthStatus> updateName(String displayName) {
    return Auth().updateName(displayName).then((status) {
      notifyListeners();
      return status;
    });
  }

  Future<void> sendVerificationEmail() {
    return Auth().sendVerificationEmail();
  }

  Future<bool> checkEmailVerified() {
    return Auth().checkEmailVerified().then((result) {
      if (result) notifyListeners();
      return result;
    });
  }
}
