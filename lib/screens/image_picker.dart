// lib/screens/image_picker_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:printify/screens/image_preview.dart';
import 'package:provider/provider.dart';
import '../provider/file_provider.dart';


class ImagePickerScreen extends StatelessWidget {
  Future<void> pickImageFromGallery(BuildContext context) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpeg', 'png'],
    );

    if (result != null) {
      String? filePath = result.files.single.path;
      if (filePath != null) {
        File imageFile = File(filePath);
        
        // Save the selected file in Provider
        Provider.of<FileProvider>(context, listen: false).setFile(imageFile);

        // Navigate to PreviewImageScreen
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => PreviewImageScreen()),
        );
      }
    } else {
      print("No image selected");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Select Image')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => pickImageFromGallery(context),
          child: Text("Pick Image from Gallery"),
        ),
      ),
    );
  }
}
