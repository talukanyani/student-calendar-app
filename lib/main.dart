import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/controllers/authentication.dart';
import 'package:sc_app/controllers/setting.dart';
import 'package:sc_app/themes/theme.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'widgets/android_system_navbar.dart';
import 'screens/welcome/welcome.dart';
import 'screens/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SettingController>(
          create: (_) => SettingController(),
        ),
        ChangeNotifierProxyProvider<SettingController, SubjectController>(
          create: (context) => SubjectController(
            Provider.of<SettingController>(context, listen: false),
          ),
          update: (_, settingController, __) {
            return SubjectController(settingController);
          },
        ),
        ChangeNotifierProxyProvider<SubjectController, ActivityController>(
          create: (context) => ActivityController(
            Provider.of<SubjectController>(context, listen: false),
          ),
          update: (_, subjectController, __) {
            return ActivityController(subjectController);
          },
        ),
        ChangeNotifierProvider<AuthenticationController>(
          create: (_) => AuthenticationController(),
        ),
      ],
      child: AndroidSystemNavbarStyle(
        color: CustomColorScheme.background5,
        child: MaterialApp(
          title: 'Student Calendar',
          home: const HomeScreen(),
          // home: const WelcomeScreen(),
          theme: lightTheme(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
