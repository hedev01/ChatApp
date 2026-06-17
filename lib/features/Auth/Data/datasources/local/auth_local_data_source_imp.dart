import 'package:chat_app/features/Auth/Data/datasources/local/auth_local_data_source.dart';
import 'package:chat_app/features/Auth/Data/models/user_model.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSourceImp implements AuthLocalDataSource {
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
}
