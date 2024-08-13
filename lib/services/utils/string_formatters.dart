import 'package:intl/intl.dart';

class StringFormatters {
  static String streetFormatter(String street) {
    if (street.contains("Rua")) {
      String formattedString = street.replaceAll('Rua', 'R.');
      return formattedString;
    } else if (street.contains("Avenida")) {
      String formattedString = street.replaceAll('Avenida', 'Av.');
      return formattedString;
    } else {
      return street;
    }
  }

  static String dateFormat(String date) {
    DateTime datParsed = DateTime.parse(date);
    final format = DateFormat("MMMMd", "pt_br");
    return format.format(datParsed);
  }
}
