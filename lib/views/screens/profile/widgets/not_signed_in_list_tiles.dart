import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/snackbar.dart';

import 'google_logo.dart';

class NotSignedInListTiles extends ConsumerStatefulWidget {
  const NotSignedInListTiles({super.key});

  @override
  ConsumerState<NotSignedInListTiles> createState() =>
      _NotLoggedInListTilesState();
}

@override
class _NotLoggedInListTilesState extends ConsumerState<NotSignedInListTiles> {
  _signInWithGoogle() {
    ref.read(authProvider.notifier).signInWithGoogle().then((status) {
      switch (status) {
        case AuthStatus.networkError:
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              text: 'Network error, check your internet connection.',
              snackBarIcon: SnackBarIcon.error,
            ),
          );
          break;
        case AuthStatus.done:
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              text: 'Successfully signed in.',
              snackBarIcon: SnackBarIcon.done,
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
    return Material(
      type: MaterialType.transparency,
      child: ListTile(
        onTap: () => _signInWithGoogle(),
        title: const Text('Sign in with Google'),
        leading: Column(
          children: [
            const Spacer(),
            GoogleLogo(
              size: 16,
              color: context.grey4,
            ),
            const Spacer(),
          ],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }
}
