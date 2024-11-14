// lib/screens/preview_image_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:printify/responsive/device_dimensions.dart';
import 'package:printify/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';
import '../provider/file_provider.dart';

class PreviewImageScreen extends StatefulWidget {
  @override
  State<PreviewImageScreen> createState() => _PreviewImageScreenState();
}

class _PreviewImageScreenState extends State<PreviewImageScreen> {
  @override
  Widget build(BuildContext context) {
    final fileProvider = Provider.of<FileProvider>(context);
    final imageFile = fileProvider.selectedImage;

    return Scaffold(
      appBar: CustomAppBar(title: "Image Preview"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: imageFile != null
              ? Column(
                  children: [
                    SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.04),
                    Center(
                      child: Container(
                          width: DeviceDimensions.screenWidth(context) * 0.8,
                          height: DeviceDimensions.screenHeight(context) * 0.6,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 254, 110, 0)
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12)),
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.fitHeight,
                          )),
                    ),
                    SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.04),
                    _printButton()
                  ],
                )
              : Text("No image selected"),
        ),
      ),
    );
  }

  Widget _printButton() {
    return Container(
      width: DeviceDimensions.screenWidth(context) * 0.5,
      height: DeviceDimensions.screenHeight(context) * 0.05,
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 254, 110, 0),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(context, '/connect-printer');
        },
        child: Center(
          child: Text(
            'Print',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: DeviceDimensions.responsiveSize(context) * 0.05),
          ),
        ),
      ),
    );
  }
}
