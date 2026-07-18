import 'package:chat_app/core/services/upload/picker_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';

class PickerRepositoryImp extends PickerRepository {
  @override
  Future<XFile?> pickImage() {
    ImagePicker imagePicker = ImagePicker();
    final image = imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    return image;
  }

  @override
  Future<XFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();

    if (result == null) return null;

    return result.files.first.xFile;
  }
}
