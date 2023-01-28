import 'package:flutter/material.dart';
import 'package:sc_app/widgets/android_system_navbar.dart';
import 'package:sc_app/widgets/buttons.dart';
import '../settings/screens/profile/screens/create_profile.dart';
import '../settings/screens/profile/screens/login.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AndroidSystemNavbarStyle(
      color: Theme.of(context).backgroundColor,
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
                    style: Theme.of(context).textTheme.headline3,
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
                          onPressed: () {},
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
                        const Text(
                          'By using this app, you agree to our',
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Terms Of Use',
                            style: TextStyle(
                              fontSize: 12,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                        const Text(
                          'and',
                          style: TextStyle(fontSize: 12),
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: const Text(
                            'Privacy Police',
                            style: TextStyle(
                              fontSize: 12,
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
