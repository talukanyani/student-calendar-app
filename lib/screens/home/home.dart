import 'package:flutter/material.dart';
import 'package:sc_app/themes/color_scheme.dart';
import 'package:sc_app/utils/calendar_names.dart';
import 'package:sc_app/widgets/primary_top_bar.dart';
import 'package:sc_app/widgets/bottom_bar.dart';
import 'package:sc_app/widgets/activities_list.dart';
import 'widgets/box.dart';
import 'widgets/week_activities.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryTopBar(
        title: 'SC',
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: const Body(),
      bottomNavigationBar: const BottomBar(screenIndex: 0),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return ListView(
          primary: false,
          children: [
            Container(
              height: constraints.maxHeight,
              constraints: const BoxConstraints(minHeight: 400),
              child: Stack(
                children: [
                  Container(
                    width: constraints.maxWidth,
                    height: constraints.maxHeight,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Theme.of(context).colorScheme.onPrimary,
                          Theme.of(context).colorScheme.surfaceVariant,
                        ],
                        stops: const [0.924, 0.924],
                      ),
                      image: DecorationImage(
                        image: context.isDarkMode
                            ? const AssetImage(
                                'assets/images/student_home_desk_(dark_version).png')
                            : const AssetImage(
                                'assets/images/student_home_desk.png'),
                        fit: BoxFit.contain,
                        alignment: Alignment.bottomRight,
                      ),
                    ),
                  ),
                  const HomeContent(),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  static final DateTime today = DateTime.now();
  static final DateTime tomorrow = today.add(const Duration(days: 1));

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              Text(
                today.day.toString(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    getMonthFullName(today.month - 1),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: context.grey4,
                        ),
                  ),
                  Text(
                    getWeekDayFullName(today.weekday - 1),
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w300,
                          color: context.grey4,
                        ),
                  ),
                ],
              )
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 224,
          child: PageView(
            controller: PageController(viewportFraction: 0.75),
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
    );
  }
}
