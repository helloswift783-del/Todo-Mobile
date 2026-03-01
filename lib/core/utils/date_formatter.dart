import 'package:intl/intl.dart';

class DateFormatter {
  static final _formatter = DateFormat('MMM d, yyyy • h:mm a');

  static String format(DateTime value) => _formatter.format(value);
}
