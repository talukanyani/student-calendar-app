import 'package:flutter/material.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/widgets/buttons.dart';

class LoginMessage extends StatelessWidget {
  const LoginMessage({super.key, required this.sendName});

  final String sendName;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('To send us a $sendName, you have to log in with your profile.'),
        RichText(
          text: TextSpan(
            text: 'Alternatively, you can',
            style: Theme.of(context).textTheme.bodyMedium,
            children: [
              WidgetSpan(
                child: InlineBtn(
                  onPressed: () => Helpers.launchLink(
                    'mailto:tmlab.tech@hotmail.com',
                  ),
                  label: 'email us',
                ),
              ),
              TextSpan(text: 'your $sendName.'),
            ],
          ),
        ),
      ],
    );
  }
}
