import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/services/authentication.dart';

class AuthenticationController extends ChangeNotifier {
  User? get currentUser => Auth().currentUser;

  Future<String> createProfile(String email, String password) {
    return Auth().createProfile(email, password).then((value) {
      notifyListeners();
      return value;
    });
  }

  Future<String> login(String email, String password) {
    return Auth().login(email, password).then((value) {
      notifyListeners();
      return value;
    });
  }

  Future<String> logout() {
    return Auth().logout().then((value) {
      notifyListeners();
      return value;
    });
  }
}
