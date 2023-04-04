import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/services/authentication.dart';
import 'package:sc_app/services/cloud_database.dart';
import '../utils/enums.dart';

class AuthController extends ChangeNotifier {
  User? get currentUser => Auth().currentUser;

  Future<AuthStatus> createProfile({
    required String name,
    required String email,
    required String password,
  }) async {
    var createProfile = await Auth().createProfile(email, password);

    if (createProfile != AuthStatus.done) return createProfile;

    notifyListeners();

    updateName(name);

    return createProfile;
  }

  Future<List> login({required String email, required String password}) async {
    var login = await Auth().login(email, password);

    if (login != AuthStatus.done) return [login];

    notifyListeners();

    var syncedSubjects = await CloudDb().getSyncedSubjects(currentUser?.uid);
    var isSync = syncedSubjects.isNotEmpty;

    return [login, isSync];
  }

  Future<AuthStatus> logout() {
    return Auth().logout().then((status) {
      notifyListeners();
      return status;
    });
  }

  Future<AuthStatus> resetPassword(String email) {
    return Auth().resetPassword(email).then((status) {
      return status;
    });
  }

  Future<AuthStatus> updateName(String displayName) {
    return Auth().updateName(displayName).then((status) {
      notifyListeners();
      return status;
    });
  }

  Future<AuthStatus> changeEmail(
      {required String password, required String newEmail}) {
    return Auth().changeEmail(password, newEmail).then((status) {
      notifyListeners();
      return status;
    });
  }

  Future<AuthStatus> changePassword(
      {required String oldPassword, required String newPassword}) {
    return Auth().changePassword(oldPassword, newPassword).then((status) {
      return status;
    });
  }

  Future<AuthStatus> deleteProfile(String password) async {
    await CloudDb().deleteAllSujects(currentUser?.uid);

    return Auth().deleteProfile(password).then((status) {
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
