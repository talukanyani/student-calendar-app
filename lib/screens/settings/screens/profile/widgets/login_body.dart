import 'package:flutter/material.dart';
import 'package:sc_app/widgets/buttons.dart';
import '../screens/create_profile.dart';
import '../screens/login.dart';

class ProfileLoginBody extends StatelessWidget {
  const ProfileLoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
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
    );
  }
}
