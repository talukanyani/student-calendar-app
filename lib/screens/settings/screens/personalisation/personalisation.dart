import 'package:flutter/material.dart';
import 'package:sc_app/widgets/rect_container.dart';

class AppSettings extends StatelessWidget {
  const AppSettings({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personalise')),
      body: const Body(),
    );
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  ThemeMode themeMode = ThemeMode.system;
  String sortTablesBy = 'date_added';
  String calendarWeek = 'mon';

  RadioListTile themeOption({
    required String title,
    required ThemeMode value,
  }) {
    return RadioListTile(
      value: value,
      groupValue: themeMode,
      onChanged: (value) => setState(() => themeMode = value!),
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(title),
    );
  }

  RadioListTile sortTablesOption({
    required String title,
    required String value,
  }) {
    return RadioListTile(
      value: value,
      groupValue: sortTablesBy,
      onChanged: (value) => setState(() => sortTablesBy = value!),
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(title),
    );
  }

  RadioListTile calendarWeekOption({
    required String title,
    required String value,
  }) {
    return RadioListTile(
      value: value,
      groupValue: calendarWeek,
      onChanged: (value) => setState(() => calendarWeek = value!),
      visualDensity: const VisualDensity(vertical: -3),
      title: Text(title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      primary: false,
      children: [
        const HeadingText(text: 'Theme Mode'),
        RectContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              themeOption(title: 'Light', value: ThemeMode.light),
              themeOption(title: 'Dark', value: ThemeMode.dark),
              themeOption(title: 'System', value: ThemeMode.system),
            ],
          ),
        ),
        const HeadingText(text: 'Tables Sort By'),
        RectContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              sortTablesOption(title: 'Date Added', value: 'date_added'),
              sortTablesOption(title: 'Name', value: 'name'),
            ],
          ),
        ),
        const HeadingText(text: 'Calendar Week Start'),
        RectContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              calendarWeekOption(title: 'Monday', value: 'mon'),
              calendarWeekOption(title: 'Sunday', value: 'sun'),
              calendarWeekOption(title: 'Saturday', value: 'sat'),
            ],
          ),
        ),
      ],
    );
  }
}

class HeadingText extends StatelessWidget {
  const HeadingText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, top: 16),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Theme.of(context).primaryColor,
        ),
      ),
    );
  }
}
