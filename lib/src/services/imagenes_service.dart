import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ImageUploadService {
  final ImagePicker _imagePicker = ImagePicker();

  Future<String?> uploadImage(File? imageFile) async {
    try {
      if (imageFile != null) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance.ref().child(fileName);
        firebase_storage.UploadTask uploadTask = ref.putFile(File(imageFile.path));
        firebase_storage.TaskSnapshot snapshot = await uploadTask;
        return await snapshot.ref.getDownloadURL();
      }
    } catch (e) {
      return null;
    }
  }
}
