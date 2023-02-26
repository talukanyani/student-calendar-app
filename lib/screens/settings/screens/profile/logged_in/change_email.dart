import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';

import 'email_verification.dart';

class ChangeEmailScreen extends StatefulWidget {
  const ChangeEmailScreen({super.key});

  @override
  State<ChangeEmailScreen> createState() => _ChangeEmailScreenState();
}

class _ChangeEmailScreenState extends State<ChangeEmailScreen> {
  String? errorMessage;
  String? emailErrorMessage;
  String? passwordErrorMessage;

  final _passwordInputController = TextEditingController();
  final _emailInputController = TextEditingController();

  _changeEmail(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    Show.loading(context);

    authProvider
        .changeEmail(
      _passwordInputController.text,
      _emailInputController.text,
    )
        .then((status) {
      Hide.loading(context);

      switch (status) {
        case AuthStatus.emailInUse:
          setState(() {
            emailErrorMessage = 'Email is already on an existing profile.';
          });
          break;
        case AuthStatus.wrongPassword:
          setState(() {
            passwordErrorMessage = 'Password is incorrect.';
          });
          break;
        case AuthStatus.networkError:
          setState(() {
            errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            errorMessage = 'There was an error while changing your email.';
          });
          break;
        default:
          authProvider.sendVerificationEmail();
          Navigator.pop(context);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const EmailVerificationScreen(),
            ),
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Change Email')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Enter Your Password',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _passwordInputController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 30,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: 'Password',
              errorText: passwordErrorMessage,
              counterText: '',
            ),
            onTap: () {
              setState(() => passwordErrorMessage = null);
            },
          ),
          const SizedBox(height: 16),
          Text(
            'Enter New Email',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _emailInputController,
            inputFormatters: [noSpace()],
            keyboardType: TextInputType.emailAddress,
            maxLength: 50,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              hintText: 'Email',
              errorText: emailErrorMessage,
              counterText: '',
            ),
            onTap: () {
              setState(() => emailErrorMessage = null);
            },
          ),
          const SizedBox(height: 12),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => errorMessage = null);
              _changeEmail(context);
            },
            child: const Text('Change'),
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
