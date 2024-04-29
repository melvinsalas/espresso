import 'package:intl/intl.dart';

extension DoubleExtension on double {
  String formatCurrency({String locale = 'en_US'}) {
    final NumberFormat numberFormat = NumberFormat("#,##0.00", locale);
    return numberFormat.format(this);
  }
}
