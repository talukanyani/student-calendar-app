import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/helpers/helpers.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/bullet_list.dart';
import 'package:sc_app/widgets/loading.dart';
import 'package:sc_app/widgets/input_field_label.dart';

class DeleteProfileScreen extends ConsumerStatefulWidget {
  const DeleteProfileScreen({super.key});

  @override
  ConsumerState<DeleteProfileScreen> createState() =>
      _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends ConsumerState<DeleteProfileScreen> {
  String? errorMessage;
  String? passwordErrorMessage;
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _deleteProfile({required void Function() onDone}) {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .deleteProfile(_inputController.text)
        .then((status) {
      setState(() => _isLoading = false);

      switch (status) {
        case AuthStatus.wrongPassword:
          setState(() {
            passwordErrorMessage = 'Password is incorrect.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            errorMessage = 'There was an error while deleting your profile.';
          });
          break;
        default:
          onDone();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Loading(
        text: 'Please wait while we delete your profile...',
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Delete Profile')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Note that if you delete your profile:',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
          const SizedBox(height: 4),
          BulletList(
            texts: [
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  children: const [
                    TextSpan(text: 'All your synced data/activities will be'),
                    TextSpan(
                      text: 'permanently deleted.',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  children: const [
                    TextSpan(text: 'Your profile will be'),
                    TextSpan(
                      text: 'permanently deleted,',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          const InputFieldLabel(
            label: 'Enter Your Password',
            bottomPadding: 8,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _inputController,
              keyboardType: TextInputType.visiblePassword,
              maxLength: 64,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Password is required.';
                } else {
                  return null;
                }
              },
              obscureText: _isPasswordHidden,
              style: const TextStyle(letterSpacing: 1),
              decoration: InputDecoration(
                hintText: 'Password',
                errorText: passwordErrorMessage,
                counterText: '',
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() => _isPasswordHidden = !_isPasswordHidden);
                  },
                  child: Icon(
                    _isPasswordHidden ? Iconsax.eye : Iconsax.eye_slash,
                    size: 20,
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minHeight: 32,
                  minWidth: 48,
                ),
              ),
              onTap: () {
                setState(() => passwordErrorMessage = null);
              },
            ),
          ),
          const SizedBox(height: 16),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => errorMessage = null);
              if (_formKey.currentState!.validate()) {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmationAlert(
                    title: const Text('Delete Profile?'),
                    content: Text(
                      'This is final! You won\'t be able to revert this action.',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                    action: () => _deleteProfile(
                      onDone: () => Helpers.showSnackBar(
                        context,
                        text: 'Profile was successfully deleted.',
                        snackBarIcon: SnackBarIcon.done,
                      ),
                    ),
                  ),
                );
              }
            },
            child: const Text('Delete'),
          ),
          const SizedBox(height: 4),
          Text(
            errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).colorScheme.error),
          ),
        ],
      ),
    );
  }
}
