import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/services/authentication.dart' show AuthStatus;
import 'package:sc_app/utils/input_formatter.dart';
import 'package:sc_app/utils/input_validator.dart';
import 'package:sc_app/views/widgets/buttons.dart';
import 'package:sc_app/views/widgets/modal.dart';
import 'package:sc_app/views/widgets/snackbar.dart';

class EditNameModal extends ConsumerStatefulWidget {
  const EditNameModal({super.key});

  @override
  ConsumerState<EditNameModal> createState() => _EditNameModalState();
}

class _EditNameModalState extends ConsumerState<EditNameModal> {
  bool _isLoading = false;

  final _inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? get _currentName => ref.watch(userProvider)?.displayName;

  void _changeName() {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .updateName(_inputController.text.trim())
        .then((status) {
      setState(() => _isLoading = false);
      Navigator.pop(context);

      switch (status) {
        case AuthStatus.done:
          ScaffoldMessenger.of(context).showSnackBar(
            mySnackBar(
              context,
              text: 'Name was successfully edited.',
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
              text: 'An error occurred while changing your name.',
              snackBarIcon: SnackBarIcon.error,
            ),
          );
      }
    });
  }

  @override
  void initState() {
    Future(() {
      _inputController.text = _currentName ?? '';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Modal(
      children: [
        Text(
          'Edit Name',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: 24),
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
        const SizedBox(height: 16),
        Row(
          children: [
            const Spacer(),
            TextButton(
              onPressed: () => Navigator.pop(context),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onBackground,
              ),
              child: const Text('Cancel'),
            ),
            const SizedBox(width: 16),
            ForegroundFilledBtn(
              onPressed: _isLoading
                  ? null
                  : () {
                      if (_inputController.text.trim() == _currentName) {
                        Navigator.pop(context);
                        return;
                      }

                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      _changeName();
                    },
              child: Text(_isLoading ? 'Saving...' : 'Save'),
            ),
          ],
        ),
      ],
    );
  }
}
