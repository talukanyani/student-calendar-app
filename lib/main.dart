import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/controllers/subject_activities.dart';
import 'package:sc_app/controllers/all_activities.dart';
import 'package:sc_app/controllers/authentication.dart';
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
        ChangeNotifierProvider<SubjectController>(
          create: (_) => SubjectController(),
        ),
        ChangeNotifierProxyProvider<SubjectController,
            SubjectActivitiesController>(
          create: (_) => SubjectActivitiesController(SubjectController()),
          update: (_, subjectController, __) {
            return SubjectActivitiesController(subjectController);
          },
        ),
        ChangeNotifierProxyProvider<SubjectController, AllActivitiesController>(
          create: (_) => AllActivitiesController(SubjectController()),
          update: (_, subjectController, __) {
            return AllActivitiesController(subjectController);
          },
        ),
        ChangeNotifierProvider<AuthenticationController>(
          create: (_) => AuthenticationController(),
        )
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
