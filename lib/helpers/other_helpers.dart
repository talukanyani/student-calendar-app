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
}
