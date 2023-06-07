import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sc_app/providers/settings.dart';
import 'package:sc_app/themes/theme.dart';
import 'widgets/android_system_navbar.dart';
import 'screens/intro/splash.dart';
import 'screens/intro/welcome.dart';
import 'screens/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await SharedPreferences.getInstance();
  runApp(const ProviderScope(child: App()));
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AndroidSystemNavbarStyle(
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
        darkTheme: darkTheme(),
        themeMode: ref.watch(themeModeProvider),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
