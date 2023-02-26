import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';

class ChangeNameScreen extends StatefulWidget {
  const ChangeNameScreen({super.key});

  @override
  State<ChangeNameScreen> createState() => _ChangeNameScreenState();
}

class _ChangeNameScreenState extends State<ChangeNameScreen> {
  String? errorMessage;

  final inputController = TextEditingController();

  _changeName(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    Show.loading(context);

    authProvider.updateName(inputController.text).then((status) {
      Hide.loading(context);

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
          Navigator.pop(context);
          Show.snackBar(
            context,
            text: 'Name was successfully edited.',
            snackBarIcon: SnackBarIcon.done,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Name')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Enter New Name',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: inputController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            maxLength: 20,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'Name',
              counterText: '',
            ),
          ),
          const SizedBox(height: 12),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => errorMessage = null);
              _changeName(context);
            },
            child: const Text('Save'),
          ),
          const SizedBox(height: 4),
          Text(
            errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
        ],
      ),
    );
  }
}
