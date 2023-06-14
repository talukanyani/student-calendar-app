import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/auth.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/helpers/helpers.dart';
import 'package:sc_app/screens/home/home.dart';
import 'package:sc_app/screens/profile/screens/create_profile.dart';
import 'package:sc_app/screens/profile/screens/login.dart';
import 'package:sc_app/widgets/buttons.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  void setIsFirstLaunch() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isFirstLaunch', false);
    });
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (ref.watch(isLoggedInProvider)) {
      setIsFirstLaunch();
      return const HomeScreen();
    }

    var bodySmallText = Theme.of(context).textTheme.bodySmall;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        toolbarHeight: 0,
      ),
      body: Stack(
        children: [
          Container(
            width: double.maxFinite,
            height: double.maxFinite,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Theme.of(context).colorScheme.onPrimary,
                  Theme.of(context).colorScheme.surfaceVariant,
                ],
                stops: const [0.213, 0.213],
              ),
              image: DecorationImage(
                image: context.isDarkMode
                    ? const AssetImage(
                        'assets/images/student_home_desk_(dark_version).png')
                    : const AssetImage('assets/images/student_home_desk.png'),
                fit: BoxFit.contain,
                alignment: Alignment.topRight,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(flex: 2),
                Text(
                  'Get Started!',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                ),
                const Wrap(
                  spacing: -8,
                  children: [
                    Icon(Icons.horizontal_rule),
                    Icon(Icons.horizontal_rule),
                    Icon(Icons.arrow_forward),
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryFilledBtn(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                        child: const Text('Log In'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: PrimaryBorderBtn(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CreateProfileScreen(),
                            ),
                          );
                        },
                        child: const Text('Create Profile'),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setIsFirstLaunch();
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: const Text('Continue Without Profile'),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Text(
                        'By using this app, you agree to our',
                        style: bodySmallText,
                      ),
                      InlineBtn(
                        onPressed: () => Helpers.launchLink(
                          'https://tmlab.tech/terms',
                        ),
                        label: 'Terms of Use',
                        textStyle: bodySmallText?.copyWith(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Text('and', style: bodySmallText),
                      InlineBtn(
                        onPressed: () => Helpers.launchLink(
                          'https://tmlab.tech/privacy',
                        ),
                        label: 'Privacy Policy',
                        textStyle: bodySmallText?.copyWith(
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
