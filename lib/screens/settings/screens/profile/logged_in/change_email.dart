import 'package:flutter/material.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';

class ChangeEmail extends StatelessWidget {
  const ChangeEmail({super.key});

  static final _passwordInputController = TextEditingController();
  static final _emailInputController = TextEditingController();

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
            decoration: const InputDecoration(
              hintText: 'Password',
              counterText: '',
            ),
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
            decoration: const InputDecoration(
              hintText: 'Email',
              counterText: '',
            ),
          ),
          const SizedBox(height: 12),
          ForegroundFilledBtn(
            onPressed: () {},
            child: const Text('Change'),
          ),
        ],
      ),
    );
  }
}
