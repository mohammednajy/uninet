import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class VerificationController extends ChangeNotifier {
  final picker = ImagePicker();
  File? file;
  getImage({required ImageSource source}) async {
    try {
      final pickedImage = await picker.pickImage(source: source);
      print(pickedImage?.path ?? 'not get value untile ');
      if (pickedImage != null) {
        file = File(pickedImage.path);
        notifyListeners();
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
