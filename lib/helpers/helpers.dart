import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:sc_app/utils/enums.dart';
import 'package:sc_app/widgets/snackbar.dart';

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

  static showSnackBar(
    BuildContext context, {
    required String text,
    SnackBarIcon? snackBarIcon,
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      mySnackBar(
        context,
        text: text,
        snackBarIcon: snackBarIcon ?? SnackBarIcon.none,
        action: action,
      ),
    );
  }
}
