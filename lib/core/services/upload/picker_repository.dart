

import 'package:image_picker/image_picker.dart';

abstract class PickerRepository {
  Future<XFile?> pickImage();
  Future<XFile?> pickFile();
}
