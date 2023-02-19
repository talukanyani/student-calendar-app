import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/services/authentication.dart';
import '../utils/enums.dart';

class AuthenticationController extends ChangeNotifier {
  User? get currentUser => Auth().currentUser;

  Future<AuthStatus> createProfile(String email, String password) {
    return Auth().createProfile(email, password).then((value) {
      notifyListeners();
      return value;
    });
  }

  Future<AuthStatus> login(String email, String password) {
    return Auth().login(email, password).then((value) {
      notifyListeners();
      return value;
    });
  }

  Future<AuthStatus> logout() {
    return Auth().logout().then((value) {
      notifyListeners();
      return value;
    });
  }

  Future<AuthStatus> resetPassword(String email) {
    return Auth().resetPassword(email).then((value) {
      notifyListeners();
      return value;
    });
  }
}
