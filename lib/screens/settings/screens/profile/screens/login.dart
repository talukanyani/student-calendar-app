import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';
import '../widgets/loading.dart';
import 'create_profile.dart';
import 'reset_password.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? errorMessage;
  String? emailErrorMessage;
  String? passwordErrorMessage;

  static final _emailInputController = TextEditingController();
  static final _passwordInputController = TextEditingController();

  login(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    showLoading(context);

    authProvider
        .login(
      _emailInputController.text,
      _passwordInputController.text,
    )
        .then((value) {
      hideLoading(context);

      switch (value) {
        case AuthStatus.profileNotFound:
          setState(() {
            emailErrorMessage = 'There is no profile for this email.';
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
            errorMessage = 'There was an error while logging you in.';
          });
          break;
        default:
          Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _emailInputController.clear();
    _passwordInputController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Log In',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _emailInputController,
            keyboardType: TextInputType.emailAddress,
            maxLength: 50,
            inputFormatters: [noSpace()],
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
          const SizedBox(height: 16),
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
          const SizedBox(height: 4),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ResetPasswordScreen(),
                ),
              );
            },
            child: Text(
              'Forgot password?',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: CustomColorScheme.grey4,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => errorMessage = null);
              login(context);
            },
            child: const Text('Log In'),
          ),
          const SizedBox(height: 2),
          Text(
            errorMessage ?? '',
            style: TextStyle(color: Theme.of(context).errorColor),
          ),
          SizedBox(height: errorMessage == null ? 0 : 2),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const CreateProfileScreen(),
                ),
              );
            },
            child: Text(
              'Don\'t have a profile?',
              textAlign: TextAlign.end,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                    color: CustomColorScheme.grey4,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          const Divider(indent: 8, endIndent: 8),
          const SizedBox(height: 16),
          GreyFilledBtn(
            onPressed: () {},
            child: Row(
              children: const [
                Text('Continue With Google'),
              ],
            ),
          ),
          GreyFilledBtn(
            onPressed: () {},
            child: Row(
              children: const [
                Text('Continue With Facebook'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
