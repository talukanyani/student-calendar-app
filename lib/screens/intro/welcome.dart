import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/widgets/android_system_navbar.dart';
import 'package:sc_app/widgets/buttons.dart';
import '../settings/screens/profile/not_logged_in/create_profile.dart';
import '../settings/screens/profile/not_logged_in/login.dart';
import '../home/home.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  void setIsFirstLaunch() {
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isFirstLaunch', false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthenticationController>(context);
    var isLoggedIn = authProvider.currentUser != null;
    if (isLoggedIn) {
      setIsFirstLaunch();
      return const HomeScreen();
    }

    var bodySmallText = Theme.of(context).textTheme.bodySmall;

    return AndroidSystemNavbarStyle(
      color: Theme.of(context).colorScheme.background,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(backgroundColor: Colors.transparent),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 48),
              child: Image(
                image: const AssetImage(
                  'assets/images/home_bg_1080x1080.png',
                ),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                fit: BoxFit.contain,
                alignment: Alignment.topCenter,
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
                  Wrap(
                    spacing: -8,
                    children: const [
                      Icon(Icons.horizontal_rule),
                      Icon(Icons.horizontal_rule),
                      Icon(Icons.arrow_forward),
                    ],
                  ),
                  const Spacer(flex: 3),
                  Row(
                    children: [
                      Expanded(
                        child: PrimaryFilledBtn(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return const LoginScreen();
                              }),
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
                              MaterialPageRoute(builder: (context) {
                                return const CreateProfileScreen();
                              }),
                            );
                          },
                          child: const Text('Create a Profile'),
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
                          child: const Text('Continue without a profile'),
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.center,
                    child: Wrap(
                      spacing: 4,
                      alignment: WrapAlignment.center,
                      children: [
                        Text(
                          'By using this app, you agree to our',
                          style: bodySmallText,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Terms Of Use',
                            style: bodySmallText?.copyWith(
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        Text(
                          'and have read our',
                          style: bodySmallText,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Text(
                            'Privacy Police.',
                            style: bodySmallText?.copyWith(
                              decoration: TextDecoration.underline,
                            ),
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
      ),
    );
  }
}
