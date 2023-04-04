import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
import 'screens/intro/splash.dart';
import 'screens/intro/welcome.dart';
import 'screens/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferences.getInstance();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthController>(
          create: (context) => AuthController(),
        ),
        ChangeNotifierProxyProvider<AuthController, SettingController>(
          create: (context) => SettingController(
            Provider.of<AuthController>(context, listen: false),
          ),
          update: (context, value, previous) {
            return previous ?? SettingController(value);
          },
        ),
        ChangeNotifierProxyProvider<SettingController, SubjectController>(
          create: (context) => SubjectController(
            Provider.of<SettingController>(context, listen: false),
          ),
          update: (context, value, previous) {
            return previous ?? SubjectController(value);
          },
        ),
        ChangeNotifierProxyProvider<SubjectController, ActivityController>(
          create: (context) => ActivityController(
            Provider.of<SubjectController>(context, listen: false),
          ),
          update: (context, value, previous) {
            return previous ?? ActivityController(value);
          },
        ),
      ],
      child: AndroidSystemNavbarStyle(
        color: CustomColorScheme.background5,
        child: MaterialApp(
          title: 'Student Calendar',
          home: FutureBuilder(
            future: SharedPreferences.getInstance().then((prefs) {
              return prefs.getBool('isFirstLaunch') ?? true;
            }),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                bool isFirst = snapshot.data ?? false;
                return isFirst ? const WelcomeScreen() : const HomeScreen();
              } else {
                return const SplashScreen();
              }
            },
          ),
          theme: lightTheme(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
