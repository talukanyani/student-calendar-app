import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      padding: const EdgeInsets.all(16),
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(elevation: 0),
          child: const Text('Login'),
        ),
        OutlinedButton(
          onPressed: () {},
          style: OutlinedButton.styleFrom(
            elevation: 0,
            side: BorderSide(
              width: 2,
              color: Theme.of(context).colorScheme.primaryContainer,
            ),
          ),
          child: const Text('Create New Profile'),
        ),
      ],
    );
  }
}
