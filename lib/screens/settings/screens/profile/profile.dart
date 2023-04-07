import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'logged_in/logged_in.dart';
import 'not_logged_in/not_logged_in.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(isLoggedInProvider)) {
      return const LoggedInScreen();
    } else {
      return const NotLoggedInScreen();
    }
  }
}
