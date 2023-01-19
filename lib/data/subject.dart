import 'package:sc_app/models/activity.dart';
import 'package:sc_app/models/subject.dart';

List<SubjectModel> initialData = [
  SubjectModel(
    1,
    'Subject 1',
    'yellow',
    [
      ActivityModel(1, 'Test 1', DateTime(2023, 03, 13, 08, 00)),
      ActivityModel(2, 'Test 2', DateTime(2023, 04, 24, 08, 00)),
      ActivityModel(3, 'Quiz 1', DateTime(2023, 02, 27, 23, 59)),
      ActivityModel(4, 'Quiz 2', DateTime(2023, 04, 10, 23, 59)),
      ActivityModel(5, 'Quiz 3', DateTime(2023, 05, 08, 23, 59)),
      ActivityModel(6, 'Assignment', DateTime(2023, 05, 05, 23, 59)),
    ],
  ),
  SubjectModel(
    2,
    'Subject 2',
    'blue',
    [
      ActivityModel(1, 'Test 1', DateTime(2023, 03, 06, 13, 00)),
      ActivityModel(2, 'Test 2', DateTime(2023, 05, 09, 08, 00)),
      ActivityModel(3, 'Practical Report', DateTime(2023, 05, 22, 23, 59)),
    ],
  ),
  SubjectModel(
    3,
    'Subject 3',
    'pink',
    [
      ActivityModel(1, 'Test 1', DateTime(2023, 03, 06, 08, 00)),
      ActivityModel(2, 'Test 2', DateTime(2023, 04, 20, 11, 15)),
      ActivityModel(3, 'Presantation', DateTime(2023, 04, 26, 08, 30)),
      ActivityModel(4, 'Assignment', DateTime(2023, 05, 08, 23, 59)),
    ],
  ),
];
