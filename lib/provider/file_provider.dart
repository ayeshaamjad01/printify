
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';

class FileProvider with ChangeNotifier {
  PlatformFile? _selectedFile;

  PlatformFile? get selectedFile => _selectedFile;

  void setFile(PlatformFile file) {
    _selectedFile = file;
    notifyListeners();
  }

  void clearFile() {
    _selectedFile = null;
    notifyListeners();
  }
}
