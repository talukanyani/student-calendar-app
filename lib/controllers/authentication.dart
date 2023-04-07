import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/data.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/services/authentication.dart';
import 'package:sc_app/services/cloud_database.dart';
import 'package:sc_app/utils/enums.dart';

class AuthController extends StateNotifier<User?> {
  AuthController(this.ref) : super(Auth().currentUser);

  final Ref ref;

  Future<AuthStatus> createProfile({
    required String name,
    required String email,
    required String password,
  }) {
    return Auth().createProfile(email, password).then((status) {
      if (status != AuthStatus.done) return status;

      state = Auth().currentUser;

      updateName(name);

      return status;
    });
  }

  Future<AuthStatus> login({required String email, required String password}) {
    return Auth().login(email, password).then((status) async {
      if (status != AuthStatus.done) return status;

      state = Auth().currentUser;

      var syncedData = await CloudDb().getSyncedData(Auth().currentUser?.uid);
      var isSync = syncedData.isNotEmpty;

      if (isSync) {
        ref.read(dataSyncProvider.notifier).set(true, updateData: false);
        ref.read(dataProvider.notifier).updateWithSynceddata();
      }

      return status;
    });
  }

  Future<AuthStatus> logout() {
    ref.read(dataSyncProvider.notifier).set(false, updateData: false);

    return Auth().logout().then((status) {
      if (status == AuthStatus.done) state = Auth().currentUser;
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
      if (status == AuthStatus.done) state = Auth().currentUser;
      return status;
    });
  }

  Future<AuthStatus> changeEmail({
    required String password,
    required String newEmail,
  }) {
    return Auth().changeEmail(password, newEmail).then((status) {
      if (status == AuthStatus.done) state = Auth().currentUser;
      return status;
    });
  }

  Future<AuthStatus> changePassword({
    required String oldPassword,
    required String newPassword,
  }) {
    return Auth().changePassword(oldPassword, newPassword).then((status) {
      return status;
    });
  }

  Future<AuthStatus> deleteProfile(String password) async {
    await CloudDb().deleteAllData(Auth().currentUser?.uid);
    ref.read(dataSyncProvider.notifier).set(false, updateData: false);

    return Auth().deleteProfile(password).then((status) {
      if (status == AuthStatus.done) state = Auth().currentUser;
      return status;
    });
  }

  Future<void> sendVerificationEmail() => Auth().sendVerificationEmail();

  Future<bool> checkEmailVerified() {
    return Auth().checkEmailVerified().then((isVerified) {
      if (isVerified) state = Auth().currentUser;
      return isVerified;
    });
  }
}
