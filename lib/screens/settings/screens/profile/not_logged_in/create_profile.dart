import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/helpers/show.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';
import '../logged_in/email_verification.dart';
import 'login.dart';

class CreateProfileScreen extends StatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  State<CreateProfileScreen> createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  String? _errorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;

  bool _isPasswordHidden = true;

  final _nameInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _createProfile(BuildContext context) {
    final authProvider =
        Provider.of<AuthenticationController>(context, listen: false);

    Show.loading(context);

    authProvider
        .createProfile(
      _emailInputController.text,
      _passwordInputController.text,
    )
        .then((value) {
      Hide.loading(context);

      switch (value) {
        case AuthStatus.emailInUse:
          setState(() {
            _emailErrorMessage = 'Email is already on an existing profile.';
          });
          break;
        case AuthStatus.weakPassword:
          setState(() {
            _passwordErrorMessage = 'Password is too weak.';
          });
          break;
        case AuthStatus.networkError:
          setState(() {
            _errorMessage = 'Network error, check your internet connection.';
          });
          break;
        case AuthStatus.unknownError:
          setState(() {
            _errorMessage = 'There was an error while creating your profile.';
          });
          break;
        default:
          authProvider.updateName(_nameInputController.text.trim());
          authProvider.sendVerificationEmail();
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const EmailVerificationScreen(),
            ),
          );
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
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 32),
          Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _nameInputController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  maxLength: 15,
                  inputFormatters: [
                    InputFormatter.noSpaceAtStart(),
                    InputFormatter.noDoubleSpace(),
                  ],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required.';
                    } else if (!InputValidator.isValidName(value.trim())) {
                      return 'Enter a valid name.';
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(letterSpacing: 1),
                  decoration: const InputDecoration(
                    hintText: 'Name',
                    counterText: '',
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _emailInputController,
                  keyboardType: TextInputType.emailAddress,
                  maxLength: 50,
                  inputFormatters: [InputFormatter.noSpace()],
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is required.';
                    } else if (!InputValidator.isValidEmail(value)) {
                      return 'Enter a valid email.';
                    } else {
                      return null;
                    }
                  },
                  style: const TextStyle(letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: _emailErrorMessage,
                    counterText: '',
                  ),
                  onTap: () {
                    setState(() => _emailErrorMessage = null);
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _passwordInputController,
                  keyboardType: TextInputType.visiblePassword,
                  maxLength: 64,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Password is required.';
                    } else if (!InputValidator.isStrongPassword(value)) {
                      return 'Password is too weak.';
                    } else {
                      return null;
                    }
                  },
                  obscureText: _isPasswordHidden,
                  style: const TextStyle(letterSpacing: 1),
                  decoration: InputDecoration(
                    hintText: 'Password',
                    errorText: _passwordErrorMessage,
                    counterText: '',
                    suffixIcon: InkWell(
                      onTap: () {
                        setState(() => _isPasswordHidden = !_isPasswordHidden);
                      },
                      child: Icon(
                        _isPasswordHidden ? Iconsax.eye : Iconsax.eye_slash,
                        size: 20,
                      ),
                    ),
                    suffixIconConstraints: const BoxConstraints(
                      minHeight: 32,
                      minWidth: 48,
                    ),
                  ),
                  onTap: () {
                    setState(() => _passwordErrorMessage = null);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          ForegroundFilledBtn(
            onPressed: () {
              setState(() => _errorMessage = null);
              if (_formKey.currentState!.validate()) {
                _createProfile(context);
              }
            },
            child: const Text('Create a profile'),
          ),
          const SizedBox(height: 8),
          _errorMessage == null
              ? const SizedBox()
              : Text(
                  _errorMessage ?? '',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  'Already have a profile?',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: CustomColorScheme.grey4,
                      ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
