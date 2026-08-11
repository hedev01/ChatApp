import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source.dart';
import 'package:chat_app/features/Auth/Data/models/auth_model.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSourceImp implements AuthLocalDataSource {
 static const String boxName = "auth";

  @override
  Future<void> saveUser(AuthDataModel user) async {
    final box = await Hive.openBox(boxName);

    await box.put('user', user.toJson());
  }

  @override
  Future<AuthDataModel> getUser() async {
    final box = await Hive.openBox(boxName);
    var user = box.get('user');
    return AuthDataModel.fromHive(user);
  }

  @override
  Future<void> delete() async {
    final box = await Hive.openBox(boxName);

    box.delete('user');
  }

  @override
  Future<void> updateAvatar(String avatarUrl) async {
    final box = await Hive.openBox(boxName);

    var user = box.get('user');

    user["avatarUrl"] = avatarUrl;
    await box.put('user', user);
  }
}