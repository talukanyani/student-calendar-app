import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:sc_app/controllers/activity.dart';
import 'package:sc_app/controllers/subject.dart';
import 'package:sc_app/controllers/all_activities.dart';

import 'package:sc_app/themes/theme.dart';
import 'package:sc_app/themes/color_scheme.dart';

import '/widgets/android_system_navbar.dart';
import '/screens/home/home.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<SubjectController>(
          create: (_) => SubjectController(),
        ),
        ChangeNotifierProxyProvider<SubjectController, ActivityController>(
          create: (context) => ActivityController(SubjectController()),
          update: (context, subjectController, activityController) {
            return ActivityController(subjectController);
          },
        ),
        ChangeNotifierProxyProvider<SubjectController, AllActivitiesController>(
          create: (context) => AllActivitiesController(SubjectController()),
          update: (context, subjectController, allActivitiesController) {
            return AllActivitiesController(subjectController);
          },
        ),
      ],
      child: AndroidSystemNavbarStyle(
        color: CustomColorScheme.background5,
        child: MaterialApp(
          title: 'Student Calendar',
          home: const HomeScreen(),
          theme: lightTheme(),
          debugShowCheckedModeBanner: false,
        ),
      ),
    );
  }
}
