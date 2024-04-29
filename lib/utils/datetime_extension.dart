import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDate({String format = 'dd/MMM'}) {
    final DateFormat dateFormat = DateFormat(format);
    return dateFormat.format(this);
  }
}
