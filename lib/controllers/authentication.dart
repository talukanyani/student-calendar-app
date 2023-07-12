import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/data.dart';
import '../providers/settings.dart';
import '../services/authentication.dart';
import '../services/cloud_database.dart';

class AuthController extends StateNotifier<User?> {
  AuthController(this.ref) : super(Auth().currentUser);

  final Ref ref;

  Future<AuthStatus> signInWithGoogle() {
    return Auth().signInWithGoogle().then((status) async {
      if (status != AuthStatus.done) return status;

      state = Auth().currentUser;

      var syncedData = await CloudDb().getSyncedData(state?.uid);
      var isSync = syncedData.isNotEmpty;

      if (isSync) {
        ref.read(dataSyncProvider.notifier).set(true, updateData: false);
        ref.read(dataProvider.notifier).updateWithSyncedData();
      }

      return status;
    });
  }

  Future<AuthStatus> signOut() {
    ref.read(dataSyncProvider.notifier).set(false, updateData: false);

    return Auth().signOut().then((status) {
      if (status == AuthStatus.done) state = null;
      return status;
    });
  }

  Future<AuthStatus> updateName(String name) {
    return Auth().updateName(name).then((status) {
      if (status == AuthStatus.done) state = Auth().currentUser;
      return status;
    });
  }

  Future<AuthStatus> deleteProfile() async {
    await CloudDb().deleteAllData(state?.uid);
    ref.read(dataSyncProvider.notifier).set(false, updateData: false);

    return Auth().deleteProfile().then((status) {
      if (status == AuthStatus.done) state = null;
      return status;
    });
  }

  Future<AuthStatus> resignInWithGoogle() async {
    return Auth().resignInWithGoogle().then((status) => status);
  }
}
