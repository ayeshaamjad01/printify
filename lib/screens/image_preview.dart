// lib/screens/preview_image_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/file_provider.dart';

class PreviewImageScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    final imageFile = fileProvider.selectedFile;

    return Scaffold(
      appBar: AppBar(title: Text('Image Preview')),
      body: Center(
        child: imageFile != null
            ? Image.file(imageFile)
            : Text("No image selected"),
      ),
    );
  }
}
