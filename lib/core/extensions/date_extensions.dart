// create a date extension to convert string to date and vice versa
import 'package:intl/intl.dart';

extension DateExtension on DateTime {
  String toDateString() {
    return DateFormat('yyyy-MM-dd').format(this);
  }

  String toTimeString() {
    return DateFormat('HH:mm:ss').format(this);
  }

  String toDateTimeString() {
    return DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  }

  String toHumanReadableDateString() {
    return DateFormat('EEEE, dd MMMM yyyy').format(this);
  }

  String toHHMMString() {
    return DateFormat('HH:mm').format(this);
  }

  String extToFormattedString({String outputDateFormat = 'yyyy-MM-dd'}) {
    return DateFormat(outputDateFormat).format(this);
  }

  int getAge() {
    var now = DateTime.now();
    var age = now.year - year;
    if (now.month < month) {
      age--;
    } else if (now.month == month) {
      if (now.day < day) {
        age--;
      }
    }
    return age;
  }

  String getHumanDifferentTime() {
    var now = DateTime.now();
    var diff = now.difference(this);
    if (diff.inDays > 0) {
      return '${diff.inDays} hari yang lalu';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} jam yang lalu';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} menit yang lalu';
    } else if (diff.inSeconds > 0) {
      return '${diff.inSeconds} detik yang lalu';
    } else {
      return 'Baru saja';
    }
  }
}
