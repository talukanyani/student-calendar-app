import 'package:flutter/material.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'create_profile.dart';
import 'login.dart';

class NotLoggedInScreen extends StatelessWidget {
  const NotLoggedInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          ForegroundFilledBtn(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return const LoginScreen();
                }),
              );
            },
            child: const Text('Login'),
          ),
          ForegroundBorderBtn(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) {
                    return const CreateProfileScreen();
                  },
                ),
              );
            },
            child: const Text('Create New Profile'),
          ),
        ],
      ),
    );
  }
}
