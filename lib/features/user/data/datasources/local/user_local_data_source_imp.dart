import 'package:chat_app/features/user/data/datasources/local/user_local_data_source.dart';
import 'package:hive/hive.dart';

import '../../models/user_model.dart';

class UserLocalDataSourceImp extends UserLocalDataSource {
  static const String boxName = "auth";

  @override
  Future<void> saveUser(UserDataModel user) async {
    final box = await Hive.openBox(boxName);

    await box.put('user', user.toJson());
  }

  @override
  Future<UserDataModel> getUser() async {
    final box = await Hive.openBox(boxName);
    var user = box.get('user');
    return UserDataModel.fromHive(user);
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
