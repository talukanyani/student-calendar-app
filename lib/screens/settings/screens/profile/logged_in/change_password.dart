import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? errorMessage;
  String? oldPasswordErrorMessage;
  String? newPasswordErrorMessage;

  final _oldPasswordInputController = TextEditingController();
  final _newPasswordInputController = TextEditingController();

  _changePassword(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    Show.loading(context);

    authProvider
        .changePassword(
      _oldPasswordInputController.text,
      _newPasswordInputController.text,
    )
        .then((status) {
      Hide.loading(context);

      switch (status) {
        case AuthStatus.weakPassword:
          setState(() {
            newPasswordErrorMessage = 'New password is too weak.';
          });
          break;
        case AuthStatus.wrongPassword:
          setState(() {
            oldPasswordErrorMessage = 'Old password is incorrect.';
          });
          break;
        case AuthStatus.networkError:
          setState(() {
            errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            errorMessage = 'There was an error while changing your password.';
          });
          break;
        default:
          Navigator.pop(context);
          Show.snackBar(
            context,
            text: 'Password was successfully changed.',
            snackBarIcon: SnackBarIcon.done,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Password')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Enter Old Password',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _oldPasswordInputController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 30,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: 'Old Password',
              errorText: oldPasswordErrorMessage,
              counterText: '',
            ),
            onTap: () {
              setState(() => oldPasswordErrorMessage = null);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Enter New Password',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _newPasswordInputController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 30,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: 'New Password',
              errorText: newPasswordErrorMessage,
              counterText: '',
            ),
            onTap: () {
              setState(() => newPasswordErrorMessage = null);
            },
          ),
          const SizedBox(height: 24),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => errorMessage = null);
              _changePassword(context);
            },
            child: const Text('Change Password'),
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
