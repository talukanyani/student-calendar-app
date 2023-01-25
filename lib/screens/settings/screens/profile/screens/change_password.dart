import 'package:flutter/material.dart';
import 'package:sc_app/helpers/show_modal.dart';
import 'package:sc_app/themes/color_scheme.dart';
import '../modals/security_code.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key, required this.email});

  final String email;

  static final inputController = TextEditingController();

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
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: CustomColorScheme.grey4,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: inputController,
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
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: CustomColorScheme.grey4,
            ),
          ),
          const SizedBox(height: 4),
          TextField(
            controller: inputController,
            keyboardType: TextInputType.visiblePassword,
            maxLength: 30,
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'New Password',
              counterText: '',
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              showModal(
                context,
                modal: SecurityCode(
                  email: email,
                  actionName: 'change',
                ),
              );
            },
            style: ElevatedButton.styleFrom(elevation: 0),
            child: const Text('Change Password'),
          ),
        ],
      ),
    );
  }
}
