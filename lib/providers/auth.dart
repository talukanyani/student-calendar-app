import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/controllers/authentication.dart';

final authProvider = StateNotifierProvider<AuthController, User?>((ref) {
  return AuthController(ref);
});

final isLoggedInProvider = Provider<bool>((ref) {
  return ref.watch(authProvider) != null;
});

final userIdProvider = Provider<String?>((ref) {
  return ref.watch(authProvider)?.uid;
});

final userEmailProvider = Provider<String?>((ref) {
  return ref.watch(authProvider)?.email;
});

final userNameProvider = Provider<String?>((ref) {
  return ref.watch(authProvider)?.displayName;
});
