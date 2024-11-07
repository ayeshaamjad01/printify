// lib/services/file_picker_service.dart
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printify/provider/file_provider.dart';
import 'package:provider/provider.dart'; // Import provider
import 'package:printify/screens/file_preview_screen.dart'; // Import the preview screen

class PickerService {
  Future<void> pickFile(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'doc', 'docx', 'txt'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      final String fileExtension = file.extension?.toLowerCase() ?? '';

      if (['pdf', 'doc', 'docx', 'txt'].contains(fileExtension)) {
        // Set the file in FileProvider
        Provider.of<FileProvider>(context, listen: false).setFile(file);

        // Navigate to PreviewScreen without passing file directly
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PreviewScreen(),
          ),
        );
      } else {
        _showUnsupportedFileDialog(context);
      }
    } else {
      print('User canceled the picker');
    }
  }

  void _showUnsupportedFileDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Unsupported File'),
        content: Text('Only PDF, DOC, DOCX, and TXT files are supported.'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

Future<void> pickImageFromGallery() async {
  print("Attempting to pick image from gallery...");
  FilePickerResult? result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['jpeg', 'png'],
  );

  if (result != null) {
    String? filePath = result.files.single.path;
    print("Selected image path: $filePath");
  } else {
    print("No image selected");
  }
}

Future<void> requestStoragePermission() async {
  print("Checking storage permissions...");
  var storagePermission = await Permission.storage.status;
  var manageExternalStoragePermission = await Permission.manageExternalStorage.status;

  if (!storagePermission.isGranted && !manageExternalStoragePermission.isGranted) {
    print("Requesting storage permissions...");
    var result = await [
      Permission.storage,
      Permission.manageExternalStorage,
    ].request();

    print("Permission result: $result");
  }

  if (await Permission.storage.isGranted || await Permission.manageExternalStorage.isGranted) {
    print("Permission granted, opening gallery...");
    pickImageFromGallery();
  } else {
    print("Storage permission denied");
  }
}

}
