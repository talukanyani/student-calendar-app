import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/utils/input_formatter.dart';
import 'package:sc_app/utils/input_validator.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/input_field_label.dart';
import 'package:sc_app/views/widgets/loading.dart';
import 'package:sc_app/views/widgets/snackbar.dart';

class ChangeNameScreen extends ConsumerStatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  ConsumerState<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends ConsumerState<ChangeNameScreen> {
  String? errorMessage;
  bool _isLoading = false;

  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _changeName({required void Function() onDone}) {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .updateName(_inputController.text.trim())
        .then((status) {
      setState(() => _isLoading = false);

      switch (status) {
        case AuthStatus.networkError:
          setState(() {
            errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            errorMessage = 'There was an error while changing your name.';
          });
          break;
        default:
          onDone();
      }
    });
  }

  @override
  void initState() {
    Future(() {
      _inputController.text = ref.watch(userProvider)?.displayName ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Loading(
        text: 'Please wait while we change your user name',
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Name')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          const InputFieldLabel(
            label: 'Enter New Name',
            bottomPadding: 8,
          ),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: _inputController,
              keyboardType: TextInputType.text,
              textCapitalization: TextCapitalization.words,
              maxLength: 15,
              inputFormatters: [
                InputFormatter.noSpaceAtStart(),
                InputFormatter.noDoubleSpace(),
              ],
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Name is required.';
                } else if (!InputValidator.isValidName(value.trim())) {
                  return 'Enter a valid name.';
                } else {
                  return null;
                }
              },
              style: const TextStyle(letterSpacing: 1),
              decoration: const InputDecoration(
                hintText: 'Name',
                counterText: '',
              ),
            ),
          ),
          const SizedBox(height: 12),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => errorMessage = null);

              final currentName = ref.watch(userProvider)?.displayName;

              if (_inputController.text.trim() == currentName) {
                Navigator.pop(context);
                return;
              }

              if (_formKey.currentState!.validate()) {
                _changeName(
                  onDone: () {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      mySnackBar(
                        context,
                        text: 'Name was successfully edited.',
                        snackBarIcon: SnackBarIcon.done,
                      ),
                    );
                  },
                );
              }
            },
            child: const Text('Save'),
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
