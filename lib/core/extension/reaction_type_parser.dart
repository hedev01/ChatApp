import 'package:chat_app/core/enums/reaction_type.dart';

extension ReactionTypeParser on ReactionType {
  static ReactionType fromString(String value) {
    return ReactionType.values.firstWhere(
      (e) => e.name.toLowerCase() == value.toLowerCase(),
    );
  }
}