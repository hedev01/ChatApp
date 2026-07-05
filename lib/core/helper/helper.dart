import 'package:intl/intl.dart';

class Helper {
  static String getConversationId(String a, String b) {
    final list = [a.trim(), b.trim()];
    list.sort();
    return list.join('_');
  }

  static String convertDateTimeToTime(String sentAt) {
    final date = DateTime.parse(sentAt).toLocal();

    final time = DateFormat('HH:mm').format(date);

    return time;
  }
}
