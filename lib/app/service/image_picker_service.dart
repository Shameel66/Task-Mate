import 'dart:io';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerServices {
  final _picker = ImagePicker();
  File? image;
  Future<File?> getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    } else {
      Fluttertoast.showToast(
          msg: "Image not selected", gravity: ToastGravity.BOTTOM);
      return null;
    }
  }

  Future<File?> getImageFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      return image;
    } else {
      Fluttertoast.showToast(
          msg: "Image not selected", gravity: ToastGravity.BOTTOM);
      return null;
    }
  }
}
