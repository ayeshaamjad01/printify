// ignore_for_file: camel_case_types

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:printify/responsive/device_dimensions.dart';
import 'package:printify/services/pick_file_service.dart';


class layout_grid extends StatelessWidget {
  const layout_grid({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
     final filePickerService = PickerService(); // Create an instance of the service to pick files
   


    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 15,
        mainAxisSpacing: 13,
        childAspectRatio: 1.4,
        children: [
          GestureDetector(
            onTap: (){
              filePickerService.pickFile(context);
            },
            child: _buildFeature(
              context: context,
              iconPath: 'assets/icons/files.svg',
              title: 'Files',
              description:
                  'Print any document from your files, folders, and iCloud',
              color: Colors.blue.shade100,
            ),
          ),
          GestureDetector(
            onTap: () async {
await filePickerService.requestStoragePermission();
            },
            child: _buildFeature(
              context: context,
              iconPath: 'assets/icons/photos.svg',
              title: 'Photos',
              description: 'Print any images from your gallery',
              color: Colors.orange.shade100,
            ),
          ),
          _buildFeature(
            context: context,
            iconPath: 'assets/icons/email.svg',
            title: 'Email',
            description: 'Print files from any email client',
            color: Colors.green.shade100,
          ),
          // _buildPrinterOption(
          //   context: context,
          //   iconPath: 'assets/icons/aitextimport.svg',
          //   title: 'AI Text Import',
          //   description: 'Recognizes text from images',
          //   color: Colors.purple.shade100,
          // ),
          _buildFeature(
            context: context,
            iconPath: 'assets/icons/contacts.svg',
            title: 'Contacts',
            description: 'Print any contact pages',
            color: Colors.red.shade100,
          ),
          // _buildPrinterOption(
          //   context: context,
          //   iconPath: 'assets/icons/scanner.svg',
          //   title: 'Scanner',
          //   description: 'Scan any document inside the application',
          //   color: Colors.teal.shade100,
          // ),
          _buildFeature(
            context: context,
            iconPath: 'assets/icons/drive.svg',
            title: 'Google Drive',
            description: 'Print files from Google Drive account',
            color: Colors.lightBlue.shade100,
          ),
          _buildFeature(
            context: context,
            iconPath: 'assets/icons/notes.svg',
            title: 'Notes',
            description: 'Paste or type any text to print',
            color: Colors.yellow.shade100,
          ),
          _buildFeature(
            context: context,
            iconPath: 'assets/icons/web.svg',
            title: 'Web',
            description: 'Print any website in full size',
            color: Colors.blueGrey.shade100,
          ),
          _buildFeature(
            context: context,
            iconPath: 'assets/icons/printable.svg',
            title: 'Printables',
            description: 'Print gift cards, planners, calendars',
            color: Colors.greenAccent.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildFeature({
    required BuildContext context,
    required String iconPath,
    required String title,
    required String description,
    required Color color,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: DeviceDimensions.screenHeight(context) * 0.015),
            SvgPicture.asset(
              iconPath,
              height: 28, // Specify the size of the SVG
              width: 28,
            ),
            SizedBox(height: DeviceDimensions.screenHeight(context) * 0.020),
            Text(
              title,
              style: TextStyle(
                fontSize: DeviceDimensions.screenHeight(context) * 0.019,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              description,
              style: TextStyle(
                fontSize: DeviceDimensions.screenHeight(context) * 0.0115,
                color: Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


