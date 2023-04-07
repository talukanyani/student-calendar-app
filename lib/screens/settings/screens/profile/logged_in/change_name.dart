import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/loading.dart';

class ChangeNameScreen extends ConsumerStatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  ConsumerState<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends ConsumerState<ChangeNameScreen> {
  String? errorMessage;
  bool _isLoading = false;

  final inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _changeName({required void Function() onDone}) {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .updateName(inputController.text.trim())
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
          Text(
            'Enter New Name',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          Form(
            key: _formKey,
            child: TextFormField(
              controller: inputController,
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
              if (_formKey.currentState!.validate()) {
                _changeName(
                  onDone: () {
                    Navigator.pop(context);
                    Show.snackBar(
                      context,
                      text: 'Name was successfully changed.',
                      snackBarIcon: SnackBarIcon.done,
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
