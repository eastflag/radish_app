import 'dart:typed_data';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class SelectImageNotifier extends ChangeNotifier {
  List<Uint8List> _images = [];

  Future setNewImage(List<XFile>? newImages) async {
    if (newImages != null && newImages.isNotEmpty) {
      _images.clear();
      newImages.forEach((xfile) async {
        _images.add(await xfile.readAsBytes());
      });
      notifyListeners();
    }
  }

  void removeImage(int index) {
    if (_images.length >= index) {
      _images.removeAt(index);
    }
    notifyListeners();
  }

  List<Uint8List> get images => _images;
}
