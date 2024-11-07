
// lib/screens/preview_screen.dart
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:pdfx/pdfx.dart';
import 'package:printify/provider/file_provider.dart';
import 'package:printify/responsive/device_dimensions.dart';
import 'package:printify/widgets/custom_app_bar.dart';
import 'package:provider/provider.dart';

class PreviewScreen extends StatefulWidget {
  @override
  _PreviewScreenState createState() => _PreviewScreenState();
}

class _PreviewScreenState extends State<PreviewScreen> {
  late PdfControllerPinch _pdfController;
  int _currentPage = 1;
  int _totalPages = 1;

  @override
  void initState() {
    super.initState();
    _initializePdfController();
  }

void _initializePdfController() {
    final file = Provider.of<FileProvider>(context, listen: false).selectedFile;
    
    if (file != null && file.path != null && file.extension?.toLowerCase() == 'pdf') {
      _pdfController = PdfControllerPinch(
        document: PdfDocument.openFile(file.path!),
      );

      // Listen to page changes
      _pdfController.addListener(() {
        setState(() {
          _currentPage = _pdfController.page ?? 1;
          _totalPages = _pdfController.pagesCount ?? 1;
        });
      });
    }
  }
  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final file = Provider.of<FileProvider>(context).selectedFile;

    if (file == null) {
      return const Scaffold(
        appBar: CustomAppBar(title: "Print Preview",
         ),
         
        // appBar: AppBar(

        //   title: const Text("Print Preview"),
        //   backgroundColor: Color.fromARGB(255, 254, 110, 0),
        //   centerTitle: true,
        // ),
        body: Center(child: Text("No file selected")),
      );
    }

    final String fileExtension = file.extension?.toLowerCase() ?? '';

    return Scaffold(
      appBar: CustomAppBar(title: "Print Preview"),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: DeviceDimensions.screenHeight(context) * 0.04),
             
              Container(
                height: DeviceDimensions.screenHeight(context) * 0.7,
                width: DeviceDimensions.screenWidth(context) * 0.9,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 254, 110, 0).withOpacity(0.3),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
          BoxShadow(
        color: Colors.grey.withOpacity(0.5), // Shadow color with opacity
        spreadRadius: 5,  // How far the shadow spreads
        blurRadius: 7,    // Softness of the shadow
        offset: Offset(0, 3), // Position of the shadow (x, y)
      ),
        ],
                ),
                child: _buildPreview(context, fileExtension),
              ),
              SizedBox(height: DeviceDimensions.screenHeight(context) * 0.02),
             
              if (fileExtension == 'pdf') _buildPageIndicator(),
              SizedBox(height: DeviceDimensions.screenHeight(context) * 0.02),
              _printButton(),
              
              
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreview(BuildContext context, String fileExtension) {
    final file = Provider.of<FileProvider>(context, listen: false).selectedFile;

    if (file?.path == null) {
      return const Center(child: Text("Unable to load file. File path is missing"));
    }
    if (fileExtension == 'pdf') {
      try {
        return PdfViewPinch(
          controller: _pdfController,
        );
      } catch (e) {
        return Center(child: Text("Error loading PDF: ${e.toString()}"));
      }
    } else if (fileExtension == 'txt') {
      return FutureBuilder<String>(
        future: _readTextFile(file!.path!),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(snapshot.data ?? 'Error loading file'),
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      );
    } else if (fileExtension == 'doc' || fileExtension == 'docx') {
      return const Center(
        child: Text(
          'DOC/DOCX preview not supported directly.\nConvert to PDF for preview.',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      );
    } else {
      return const Text("Unsupported file format");
    }
  }
 Widget _buildPageIndicator() {
    return Container(
      margin: const EdgeInsets.only(top: 10.0),
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        color:const Color.fromARGB(255, 252, 176, 119),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        'Page $_currentPage of $_totalPages',
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: DeviceDimensions.responsiveSize(context) * 0.03),
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
        color:const  Color.fromARGB(255, 254, 110, 0),
        borderRadius: BorderRadius.circular(8.0),
        
      ),
      child:  GestureDetector(
        onTap:() {
          Navigator.pushNamed(context, '/connect-printer');
        },
        child: Center(
          child:  Text(
            'Print',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: DeviceDimensions.responsiveSize(context) * 0.05),
          ),
        ),
      ),
    );
  }

  Future<String> _readTextFile(String path) async {
    try {
      final file = File(path);
      return await file.readAsString();
    } catch (e) {
      return 'Error reading file: ${e.toString()}';
    }
  }
}
