import 'package:chat_app/core/services/picker_repository.dart';
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
}
