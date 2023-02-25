const List<String> _threeLettersMonthNames = <String>[
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

const List<String> _fullMonthNames = <String>[
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

List<String> _weekDayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

List<String> _weekDayFullNames = [
  'Monday',
  'Tuesday',
  'Wednessday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday',
];

String getMonthName(index) => _threeLettersMonthNames[index];
String getMonthFullName(index) => _fullMonthNames[index];

String getWeekDayName(index) => _weekDayNames[index];
String getWeekDayFullName(index) => _weekDayFullNames[index];
