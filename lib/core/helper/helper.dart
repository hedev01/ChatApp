import 'package:chat_app/core/enums/messages_type.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;

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

  static int convertEnumToInt(MessagesType type) {
    switch (type) {
      case MessagesType.text:
        return 0;
      case MessagesType.file:
        return 1;
      case MessagesType.image:
        return 2;
    }
  }

 static MessagesType getMessageType(String filePath) {
  final extension = p.extension(filePath).toLowerCase();

  const imageExtensions = [
    '.jpg',
    '.jpeg',
    '.png',
    '.gif',
    '.webp',
    '.bmp',
    '.heic',
  ];

  const audioExtensions = [
    '.mp3',
    '.wav',
    '.aac',
    '.m4a',
    '.ogg',
    '.flac',
  ];

  if (imageExtensions.contains(extension)) {
    return MessagesType.image;
  }

  if (audioExtensions.contains(extension)) {
   // return MessagesType.audio;
  }

  return MessagesType.file;
}

}
