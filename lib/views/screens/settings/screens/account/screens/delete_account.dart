import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/views/widgets/bullet_list.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/snackbar.dart';

class DeleteProfileScreen extends ConsumerStatefulWidget {
  const DeleteProfileScreen({super.key});

  @override
  ConsumerState<DeleteProfileScreen> createState() =>
      _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends ConsumerState<DeleteProfileScreen> {
  String? _errorMessage;
  bool _isDeleting = false;
  bool _isReAuthenticating = false;
  bool _reAuthed = false;

  void _deleteProfile() {
    setState(() => _isDeleting = true);

    ref.read(authProvider.notifier).deleteProfile().then((status) {
      setState(() => _isDeleting = false);

      switch (status) {
        case AuthStatus.networkError:
          setState(() {
            _errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.done:
          Navigator.pop(context);
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              text: 'Your profile was successfully deleted.',
              snackBarIcon: SnackBarIcon.done,
            ),
          );
          break;
        default:
          setState(() {
            _errorMessage = 'An error occurred while deleting your profile.';
          });
          break;
      }
    });
  }

  void _resignIn() {
    setState(() => _isReAuthenticating = true);

    ref.read(authProvider.notifier).resignInWithGoogle().then((status) {
      setState(() => _isReAuthenticating = false);

      switch (status) {
        case AuthStatus.networkError:
          setState(() {
            _errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.userMismatch:
        case AuthStatus.userNotFound:
          setState(() {
            _errorMessage = 'User does not match, \nPlease use '
                '${ref.read(userProvider)?.email ?? 'email for this profile'}'
                ' to sign in.';
          });
          break;
        case AuthStatus.done:
          setState(() {
            _reAuthed = true;
          });
          break;
        default:
          setState(() {
            _errorMessage = 'An error occurred while resigning you in.';
          });
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Delete Profile')),
      body: ListView(
        primary: false,
        padding: (availWidth < 480)
            ? const EdgeInsets.symmetric(horizontal: 16)
            : EdgeInsets.symmetric(horizontal: ((availWidth - 480) / 2) + 16),
        children: [
          Text(
            'Note that if you delete your profile:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const BulletList(
            texts: [
              Text(
                'All your synced data (subjects and activities) '
                'will be permanently deleted.',
              ),
              Text(
                'Your profile will be permanently deleted, '
                'you won\'t be able to retrieve it.',
              ),
            ],
          ),
          const SizedBox(height: 28),
          Text(
            'For security reasons, you are required to sign in again.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
          ForegroundFilledBtn(
            onPressed: (_isReAuthenticating || _reAuthed)
                ? null
                : () {
                    setState(() => _errorMessage = null);
                    _resignIn();
                  },
            child: Text(
              _isReAuthenticating ? 'Signing in...' : 'Sign in again',
            ),
          ),
          const SizedBox(height: 8),
          FilledBtn(
            onPressed: (_isDeleting || !_reAuthed)
                ? null
                : () {
                    setState(() => _errorMessage = null);
                    _deleteProfile();
                  },
            backgroundColor: Theme.of(context).colorScheme.error,
            foregroundColor: Theme.of(context).colorScheme.onError,
            child: Text(_isDeleting ? 'Deleting...' : 'Delete'),
          ),
          const SizedBox(height: 16),
          Text(
            _errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
    );
  }
}
