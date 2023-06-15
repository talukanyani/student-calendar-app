import 'package:url_launcher/url_launcher.dart';
import 'calendar_names.dart';

class Helpers {
  // if number is single digit add one zero before it
  static String padTwoNums(int n) => (n < 10 ? '0' : '') + n.toString();

  // Check if the dates are in the same day
  static bool isSameDay(DateTime date1, DateTime date2) {
    if (date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> launchLink(String url) async {
    Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) await launchUrl(uri);
  }

  static String getShortMonthName(int index) => shortMonthNames[index];

  static String getFullMonthName(int index) => fullMonthNames[index];

  static String getShortWeekDayName(int index) => shortWeekDayNames[index];

  static String getFullWeekDayName(int index) => fullWeekDayNames[index];
}
