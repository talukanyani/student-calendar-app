import 'package:flutter/material.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/widgets/buttons.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  static final _emailInputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Reset Password',
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
          const SizedBox(height: 8),
          ForegroundFilledBtn(
            onPressed: () {},
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}
