import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sc_app/controllers/authentication.dart';

final authProvider = StateNotifierProvider<AuthController, User?>((ref) {
  return AuthController(ref);
});

final userProvider = Provider<User?>((ref) {
  return ref.watch(authProvider);
});
