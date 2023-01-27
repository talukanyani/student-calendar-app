import 'package:flutter/material.dart';
import 'package:sc_app/widgets/buttons.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.all(16),
      children: [
        ForegroundFilledBtn(
          onPressed: () {},
          child: const Text('Login'),
        ),
        ForegroundBorderBtn(
          onPressed: () {},
          child: const Text('Create New Profile'),
        ),
      ],
    );
  }
}
