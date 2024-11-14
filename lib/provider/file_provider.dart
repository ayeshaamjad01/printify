import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileProvider with ChangeNotifier {
  PlatformFile? _selectedFile;
  File? _selectedImage;

  PlatformFile? get selectedFile => _selectedFile;
  File? get selectedImage => _selectedImage;

  void setFile(PlatformFile file) {
    _selectedFile = file;
    notifyListeners();
  }

  void setImage(File image) {
    _selectedImage = image;
    _selectedFile = null; // Clear any selected file when setting an image
    notifyListeners();
  }

  void clearFile() {
    _selectedFile = null;
    _selectedImage = null;
    notifyListeners();
  }
}
