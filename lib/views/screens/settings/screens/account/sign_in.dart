import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/snackbar.dart';

import 'account_settings.dart';
import 'widgets/google_logo.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

@override
class _SignInScreenState extends ConsumerState<SignInScreen> {
  _signInWithGoogle() {
    ref.read(authProvider.notifier).signInWithGoogle().then((status) {
      switch (status) {
        case AuthStatus.done:
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const AccountSettingsScreen(),
            ),
          );
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              text: 'You are successfully signed in.',
              snackBarIcon: SnackBarIcon.done,
            ),
          );
          break;
        case AuthStatus.networkError:
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              text: 'Network error, check your internet connection.',
              snackBarIcon: SnackBarIcon.error,
            ),
          );
          break;
        default:
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              text: 'An error occurred while signing you in.',
              snackBarIcon: SnackBarIcon.error,
            ),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.surface,
        title: const Text('Sign In'),
      ),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Icon(
            FluentIcons.person_circle_32_regular,
            size: 64,
            color: context.grey3,
          ),
          const SizedBox(height: 16),
          Text(
            'Personalise Your App',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          const Text(
            'Sign in to enable data sync and back up.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Center(
            child: OutlinedButton(
              onPressed: () => _signInWithGoogle(),
              style: OutlinedButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onBackground,
                backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
                side: BorderSide(
                  width: 2,
                  color: Theme.of(context).colorScheme.background,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.all(24),
                maximumSize: const Size.fromWidth(320),
              ),
              child: const Row(
                children: [
                  GoogleLogo(size: 16),
                  SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      'Sign In With Google',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
