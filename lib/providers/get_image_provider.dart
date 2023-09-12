import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Imageprovider extends ChangeNotifier {
  String? tempimagepath;

  Future<void> getimagepath() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) {
      return;
    }

    final tempImage = File(image.path);
    tempimagepath = tempImage.path;
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
