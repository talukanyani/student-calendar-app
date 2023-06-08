import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:sc_app/helpers/formatters_and_validators.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/buttons.dart';
import 'package:sc_app/widgets/loading.dart';
import 'email_verification.dart';
import 'login.dart';

class CreateProfileScreen extends ConsumerStatefulWidget {
  const CreateProfileScreen({super.key});

  @override
  ConsumerState<CreateProfileScreen> createState() =>
      _CreateProfileScreenState();
}

class _CreateProfileScreenState extends ConsumerState<CreateProfileScreen> {
  String? _errorMessage;
  String? _emailErrorMessage;
  String? _passwordErrorMessage;
  bool _isPasswordHidden = true;
  bool _isLoading = false;

  final _nameInputController = TextEditingController();
  final _emailInputController = TextEditingController();
  final _passwordInputController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  void _createProfile({required void Function() onDone}) {
    setState(() => _isLoading = true);

    ref
        .read(authProvider.notifier)
        .createProfile(
          name: _nameInputController.text.trim(),
          email: _emailInputController.text,
          password: _passwordInputController.text,
        )
        .then((value) {
      setState(() => _isLoading = false);

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
          onDone();
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
    if (_isLoading) {
      return const Loading(
        text: 'Please wait while we create your profile...',
      );
    }

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
                  textInputAction: TextInputAction.next,
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
                  textInputAction: TextInputAction.next,
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
                      return 'Password must be at least 8 characters,'
                          '\nand include at least one letter, number, and symbol';
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
                _createProfile(
                  onDone: () {
                    ref.read(authProvider.notifier).sendVerificationEmail();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => const EmailVerificationScreen(),
                      ),
                    );
                  },
                );
              }
            },
            child: const Text('Create Profile'),
          ),
          const SizedBox(height: 8),
          _errorMessage == null
              ? const SizedBox()
              : Text(
                  _errorMessage ?? '',
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 4,
            alignment: WrapAlignment.end,
            children: [
              const Text('Already have a profile?'),
              InlineBtn(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => const LoginScreen(),
                    ),
                  );
                },
                label: 'Log In',
              )
            ],
          ),
        ],
      ),
    );
  }
}
