// lib/screens/bluetooth_error_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:printify/provider/file_provider.dart';
import 'package:printify/responsive/device_dimensions.dart';

class BluetoothErrorScreen extends StatelessWidget {
  final String message;

  BluetoothErrorScreen({required this.message});

  @override
  Widget build(BuildContext context) {
    // Access the selected file from Provider
    final file = Provider.of<FileProvider>(context).selectedFile;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/enable_bluetooth.jpg',
                  height: DeviceDimensions.screenHeight(context) * 0.25,
                ),
                SizedBox(height: 20),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: DeviceDimensions.responsiveSize(context) * 0.04,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: DeviceDimensions.screenWidth(context) * 0.5,
                  height: DeviceDimensions.screenHeight(context) * 0.05,
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 20.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 254, 110, 0),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // Navigate back to file preview screen
                      Navigator.pushNamed(context, '/file-print-preview');
                    },
                    child: Center(
                      child: Text(
                        'Go Back',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: DeviceDimensions.responsiveSize(context) * 0.05,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
