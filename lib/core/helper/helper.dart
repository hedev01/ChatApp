class Helper {
  static String getConversationId(String a, String b) {
    final list = [a.trim(), b.trim()];
    list.sort();
    return list.join('_');
  }
}
