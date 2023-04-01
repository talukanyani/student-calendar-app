import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'logged_in/logged_in.dart';
import 'not_logged_in/not_logged_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthenticationController>(context).currentUser;
    bool isLoggedIn = user != null;

    if (isLoggedIn) {
      return const LoggedInScreen();
    } else {
      return const NotLoggedInScreen();
    }
  }
}
