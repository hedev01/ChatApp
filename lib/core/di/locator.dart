import 'package:chat_app/core/core_injection.dart';
import 'package:chat_app/features/Auth/auth_injection.dart';
import 'package:chat_app/features/chat/chat_injection.dart';
import 'package:chat_app/features/profile/profile_injection.dart';
import 'package:chat_app/features/upload/upload_injection.dart';
import 'package:chat_app/features/user/user_injection.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance;

void setup() {
  registerCore(locator);
  registerUser(locator);

  registerAuth(locator);
  registerChat(locator);
  registerProfile(locator);
  registerUpload(locator);
}
