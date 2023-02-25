import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/widgets/buttons.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  static final _oldPasswordInputController = TextEditingController();
  static final _newPasswordInputController = TextEditingController();

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
            decoration: const InputDecoration(
              hintText: 'Old Password',
              counterText: '',
            ),
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
            decoration: const InputDecoration(
              hintText: 'New Password',
              counterText: '',
            ),
          ),
          const SizedBox(height: 24),
          ForegroundFilledBtn(
            onPressed: () {},
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
