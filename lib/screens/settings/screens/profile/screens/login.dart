import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'create_profile.dart';
import 'reset_password.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  static final _emailInputController = TextEditingController();
  static final _passwordInputController = TextEditingController();

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
            decoration: const InputDecoration(
              hintText: 'Email',
              counterText: '',
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordInputController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 30,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'Password',
              counterText: '',
            ),
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
            onPressed: () {},
            child: const Text('Log In'),
          ),
          const SizedBox(height: 4),
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
