import 'package:chat_app/core/services/upload/picker_repository.dart';
import 'package:chat_app/core/services/upload/picker_repository_imp.dart';
import 'package:get_it/get_it.dart';

void registerCore(GetIt locator){
    ///repositories
  locator.registerSingleton<PickerRepository>(PickerRepositoryImp());
}