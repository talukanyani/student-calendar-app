import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'firebase_options.dart';
import 'providers/settings.dart';
import 'views/screens/home/home.dart';
import 'views/themes/theme.dart';
import 'views/widgets/android_system_navbar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(child: App()),
  );
}

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AndroidSystemNavbarStyle(
      child: MaterialApp(
        title: 'Student Calendar',
        home: const HomeScreen(),
        theme: lightTheme(),
        darkTheme: darkTheme(),
        themeMode: ref.watch(themeModeProvider),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
