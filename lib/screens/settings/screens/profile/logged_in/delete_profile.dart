import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/alerts.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/bullet_list.dart';

class DeleteProfileScreen extends StatefulWidget {
  const DeleteProfileScreen({super.key});

  @override
  State<DeleteProfileScreen> createState() => _DeleteProfileScreenState();
}

class _DeleteProfileScreenState extends State<DeleteProfileScreen> {
  String? errorMessage;
  String? passwordErrorMessage;

  final _inputController = TextEditingController();

  _deleteProfile(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    Show.loading(context);

    authProvider
        .deleteProfile(
      _inputController.text,
    )
        .then((status) {
      Hide.loading(context);

      switch (status) {
        case AuthStatus.wrongPassword:
          setState(() {
            passwordErrorMessage = 'Password is incorrect.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            errorMessage = 'There was an error while deleting your profile.';
          });
          break;
        default:
          Navigator.pop(context);
          Show.snackBar(
            context,
            text: 'Profile was successfully deleted.',
            snackBarIcon: SnackBarIcon.done,
          );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Delete Profile')),
      body: ListView(
        primary: false,
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            'Note that if you delete your profile:',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          const SizedBox(height: 4),
          BulletList(
            texts: [
              Text(
                'All your synchronised data/activities will be deleted.',
                style: TextStyle(color: Theme.of(context).errorColor),
              ),
              RichText(
                text: TextSpan(
                  text: 'Your profile will be ',
                  style: TextStyle(color: Theme.of(context).errorColor),
                  children: const <TextSpan>[
                    TextSpan(
                      text: 'permanantly deleted,',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    TextSpan(
                      text: ' and you won\'t be able to revert this action.',
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            'Enter Your Password',
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: CustomColorScheme.grey4,
                ),
          ),
          const SizedBox(height: 8),
          TextField(
            controller: _inputController,
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
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => errorMessage = null);
              Show.modal(
                context,
                modal: Alert(
                  title: Text(
                    'Delete Profile',
                    style: TextStyle(color: Theme.of(context).errorColor),
                  ),
                  titleIcon: Icon(
                    FluentIcons.warning_24_filled,
                    color: Theme.of(context).errorColor,
                  ),
                  content: const Text(
                    'Are you sure you want to delete this profile.\nYou won\'t be able to revert this action.',
                  ),
                  actionName: 'Delete',
                  action: () => _deleteProfile(context),
                ),
              );
            },
            child: const Text('Permanantly Delete'),
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
