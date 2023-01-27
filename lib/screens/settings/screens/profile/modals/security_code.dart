import 'package:flutter/material.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/modal.dart';

class SecurityCode extends StatelessWidget {
  const SecurityCode({
    super.key,
    required this.email,
    required this.actionName,
  });

  final String email;
  final String actionName;

  static final inputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Modal(children: [
      Text(
        'Security Code',
        style: Theme.of(context).textTheme.headline6,
      ),
      const SizedBox(height: 20),
      Text('Enter security code which was sent to $email'),
      const SizedBox(height: 16),
      TextField(
        controller: inputController,
        inputFormatters: [noSpace()],
        keyboardType: TextInputType.number,
        maxLength: 6,
        style: const TextStyle(fontSize: 20),
        decoration: const InputDecoration(
          hintText: 'Code',
          counterText: '',
        ),
      ),
      const SizedBox(height: 8),
      ForegroundFilledBtn(
        onPressed: () {},
        child: Text('Confirm and $actionName'),
      ),
      const SizedBox(height: 16),
      const Text('If you did not receive code, resend in 120 seconds'),
    ]);
  }
}
