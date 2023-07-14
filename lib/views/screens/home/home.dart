import 'package:flutter/material.dart';
import 'package:sc_app/utils/helpers.dart';
import 'package:sc_app/views/themes/color_scheme.dart';
import 'package:sc_app/views/widgets/activities_list.dart';
import 'package:sc_app/views/widgets/bottom_nav_bar.dart';
import 'package:sc_app/views/widgets/main_drawer.dart';
import 'package:sc_app/views/widgets/profile_icon_button.dart';
import 'package:sc_app/views/widgets/side_nav_bar.dart';
import 'widgets/box.dart';
import 'widgets/week_activities.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;
    final isDrawer = (availWidth >= 600);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: isDrawer,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        title: const Text('SC'),
        actions: const [ProfileIconButton()],
      ),
      body: SideNavBar(
        screenIndex: 0,
        isVisible: isDrawer,
        backgroundColor: Theme.of(context).colorScheme.onPrimary,
        child: const Body(),
      ),
      bottomNavigationBar: isDrawer ? null : const BottomNavBar(screenIndex: 0),
      drawer: isDrawer ? const MainDrawer(screenIndex: 0) : null,
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return SingleChildScrollView(
          primary: false,
          child: Container(
            height: constraints.maxHeight,
            constraints: const BoxConstraints(minHeight: 400),
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  height: double.infinity,
                  color: Theme.of(context).colorScheme.onPrimary,
                  alignment: Alignment.bottomLeft,
                  child: Container(
                    height: 92,
                    width: double.infinity,
                    color: Theme.of(context).colorScheme.surfaceVariant,
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Image(
                    image: context.isDarkMode
                        ? const AssetImage(
                            'assets/images/student_home_desk_(dark_version).png')
                        : const AssetImage(
                            'assets/images/student_home_desk.png'),
                    width: (constraints.maxWidth < 720)
                        ? constraints.maxWidth
                        : 720,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                const HomeContent(),
              ],
            ),
          ),
        );
      },
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  static final DateTime today = DateTime.now();
  static final DateTime tomorrow = today.add(const Duration(days: 1));

  double getViewFrac(availWidth) {
    double frac = 280 / availWidth;

    if (frac > 1) {
      frac = 1;
    } else if (frac < 0.25) {
      frac = 0.25;
    }

    return frac;
  }

  @override
  Widget build(BuildContext context) {
    final availWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Text(
                today.day.toString(),
                style: Theme.of(context).textTheme.displayMedium,
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Helpers.getFullMonthName(today.month - 1),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          color: context.grey4,
                        ),
                  ),
                  Text(
                    Helpers.getFullWeekDayName(today.weekday - 1),
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
          height: 240,
          child: PageView(
            controller: PageController(
              viewportFraction: getViewFrac(availWidth),
            ),
            padEnds: false,
            physics: const BouncingScrollPhysics(),
            children: [
              Box(
                title: 'Today',
                child: ActivitiesList(date: today, isReadOnly: true),
              ),
              Box(
                title: 'Tomorrow',
                child: ActivitiesList(date: tomorrow, isReadOnly: true),
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
