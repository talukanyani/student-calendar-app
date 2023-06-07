import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';
import 'package:sc_app/widgets/activities_list.dart';
import 'widgets/text_container.dart';
import 'widgets/box.dart';
import 'widgets/week_activities.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryTopBar(title: 'SC'),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ListView(
            primary: false,
            children: [
              Container(
                height: constraints.maxHeight,
                constraints: const BoxConstraints(minHeight: 400),
                child: const Body(),
              ),
            ],
          );
        },
      ),
      bottomNavigationBar: const BottomBar(screenIndex: 0),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  static final DateTime today = DateTime.now();
  static final DateTime tomorrow = today.add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image(
          image: context.isDarkMode
              ? const AssetImage(
                  'assets/images/student_home_desk_(dark_version).png')
              : const AssetImage('assets/images/student_home_desk.png'),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            TextContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Good day,',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: context.grey4,
                        ),
                  ),
                  Text(
                    '${getWeekDayFullName(today.weekday - 1)}, '
                    '${today.day} '
                    '${getMonthFullName(today.month - 1)}',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w300,
                        ),
                  ),
                ],
              ),
            ),
            const Spacer(flex: 3),
            TextContainer(
              child: Text(
                'Your next 7 days',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            SizedBox(
              height: 160 + (MediaQuery.of(context).size.height * 0.1),
              child: PageView(
                controller: PageController(viewportFraction: 0.9),
                padEnds: false,
                physics: const BouncingScrollPhysics(),
                children: [
                  Box(
                    title: 'Today',
                    child: ActivitiesList(date: today),
                  ),
                  Box(
                    title: 'Tomorrow',
                    child: ActivitiesList(date: tomorrow),
                  ),
                  const Box(
                    title: 'This Week',
                    child: WeekActivities(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
