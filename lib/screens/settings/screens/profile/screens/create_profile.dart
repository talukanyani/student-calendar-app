import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/helpers/text_input_formatters.dart';
import 'package:sc_app/widgets/buttons.dart';
import '../widgets/loading.dart';
import 'login.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  String? errorMessage;
  String? emailErrorMessage;
  String? passwordErrorMessage;

  static final _nameInputController = TextEditingController();
  static final _emailInputController = TextEditingController();
  static final _passwordInputController = TextEditingController();

  void createProfile(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    showLoading(context);

    authProvider
        .createProfile(
      _emailInputController.text,
      _passwordInputController.text,
    )
        .then((value) {
      Navigator.pop(context);

      switch (value) {
        case 'email-already-in-use':
          setState(() {
            emailErrorMessage = 'Email is already on an existing profile.';
          });
          break;
        case 'weak-password':
          setState(() {
            passwordErrorMessage = 'Password is too weak.';
          });
          break;
        case 'error':
          setState(() {
            errorMessage = 'There was an error while creating your profile.';
          });
          break;
        default:
          Navigator.pop(context);
      }
    });
  }

  @override
  void dispose() {
    _nameInputController.clear();
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
            'Create a Profile',
            style: Theme.of(context).textTheme.headline4,
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _nameInputController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.words,
            maxLength: 20,
            inputFormatters: [
              noSpaceAtStart(),
              noDoubleSpace(),
            ],
            style: const TextStyle(fontSize: 20),
            decoration: const InputDecoration(
              hintText: 'Name',
              counterText: '',
            ),
          ),
          const SizedBox(height: 16),
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
          const SizedBox(height: 16),
          ForegroundFilledBtn(
            onPressed: () {
              createProfile(context);
            },
            child: const Text('Create a profile'),
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
                  builder: (context) => const LoginScreen(),
                ),
              );
            },
            child: Text(
              'Already have a profile?',
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
