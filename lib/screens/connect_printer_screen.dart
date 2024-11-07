// lib/screens/connect_printer_screen.dart
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printify/responsive/device_dimensions.dart';
import 'package:printify/screens/bluetooth_error_screen.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:printify/widgets/custom_app_bar.dart';
import 'package:printify/widgets/custom_loader.dart';
import 'package:provider/provider.dart';
import 'package:printify/provider/file_provider.dart';

// class ConnectPrinterScreen extends StatefulWidget {
//   @override
//   _ConnectPrintersScreenState createState() => _ConnectPrintersScreenState();
// }

// class _ConnectPrintersScreenState extends State<ConnectPrinterScreen> {
//   List<BluetoothDevice> _devices = [];
//   BluetoothDevice? _selectedPrinter;
//   bool _isScanning = false;

//   @override
//   void initState() {
//     super.initState();
//     _checkPermissionsAndStartScan();
//   }

//   Future<void> _checkPermissionsAndStartScan() async {
//     BluetoothAdapterState adapterState = await FlutterBluePlus.adapterState.first;

//     if (adapterState != BluetoothAdapterState.on) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => BluetoothErrorScreen(
//             message: 'Bluetooth is turned off. Please enable it to search for printers.',
//           ),
//         ),
//       );
//       return;
//     }

//     if (await _requestBluetoothPermissions()) {
//       _startScan();
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Bluetooth permissions are required to search for printers.')),
//       );
//     }
//   }

//   Future<bool> _requestBluetoothPermissions() async {
//     PermissionStatus locationStatus = await Permission.locationWhenInUse.request();
//     if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('Location permissions are required for Bluetooth scanning.')),
//       );
//       return false;
//     }

//     PermissionStatus bluetoothScanStatus = await Permission.bluetoothScan.request();
//     PermissionStatus bluetoothConnectStatus = await Permission.bluetoothConnect.request();

//     return bluetoothScanStatus.isGranted && bluetoothConnectStatus.isGranted;
//   }

//   void _startScan() {
//     setState(() {
//       _isScanning = true;
//       _devices = []; // Clear the previous devices list
//     });

//     FlutterBluePlus.startScan(timeout: Duration(seconds: 4)).then((_) {
//       setState(() {
//         _isScanning = false;
//       });
//     });

//     FlutterBluePlus.scanResults.listen((scanResults) {
//       setState(() {
//         _devices = scanResults.map((result) => result.device).toList();
//       });
//     });
//   }

//   void _onDeviceSelected(BluetoothDevice device) {
//     setState(() {
//       _selectedPrinter = device;
//     });
//   }

//   void _connectToDevice() {
//     if (_selectedPrinter != null) {
//       print('Connecting to ${_selectedPrinter!.name}');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final file = Provider.of<FileProvider>(context).selectedFile;

//     if (file == null) {
//       return Scaffold(
//         appBar: AppBar(
//           title: const Text("Available Printers"),
//           centerTitle: true,
//         ),
//         body: Center(
//           child: Text("No file selected"),
//         ),
//       );
//     }

//     return Scaffold(
//       appBar: CustomAppBar(title: "Available Printers"),
//       body: Column(
//         children: [
//           Expanded(
//             child: GridView.builder(
//               padding: const EdgeInsets.all(16.0),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2,
//                 mainAxisSpacing: 16,
//                 crossAxisSpacing: 16,
//                 childAspectRatio: 1.1,
//               ),
//               itemCount: _devices.isNotEmpty ? _devices.length : 4,
//               itemBuilder: (context, index) {
//                 if (_devices.isEmpty) {
//                   return _buildPrinterPlaceholder();
//                 } else {
//                   final device = _devices[index];
//                   return GestureDetector(
//                     onTap: () => _onDeviceSelected(device),
//                     child: _buildPrinterTile(device),
//                   );
//                 }
//               },
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: SizedBox(
//               width: DeviceDimensions.screenWidth(context) * 0.6,
//               child: ElevatedButton(
//                 onPressed: _isScanning
//                     ? null // Disable button if scanning
//                     : _selectedPrinter != null
//                         ? _connectToDevice // Connect if a device is selected
//                         : _startScan, // Refresh if no device is selected
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: const Color.fromARGB(255, 254, 110, 0),
//                   minimumSize: Size(double.infinity, 50),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                 ),
//                 child: Text(
//                   _isScanning
//                       ? "Scanning..." // Show Scanning while scanning
//                       : _selectedPrinter != null
//                           ? "Connect" // Show Connect if a device is selected
//                           : "Refresh", // Show Refresh if no device is selected
//                   style: const TextStyle(fontSize: 18, color: Colors.white),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPrinterTile(BluetoothDevice device) {
//     return Container(
//       decoration: BoxDecoration(
//         color: _selectedPrinter == device ? Colors.blue.withOpacity(0.1) : Colors.grey.shade200,
//         borderRadius: BorderRadius.circular(12),
//         border: _selectedPrinter == device
//             ? Border.all(color: Colors.blue, width: 2)
//             : null,
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.print, size: 50, color: Colors.black54),
//           const SizedBox(height: 8),
//           Text(
//             device.name.isNotEmpty ? device.name : 'Unknown Printer',
//             textAlign: TextAlign.center,
//             style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPrinterPlaceholder() {
//     return Container(
//       decoration: BoxDecoration(
//         color: const Color.fromARGB(255, 252, 176, 119).withOpacity(0.4),
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: const Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.print, size: 50, color: Color.fromARGB(255, 254, 110, 0)),
//           SizedBox(height: 8),
//           CustomLoader(),
//         ],
//       ),
//     );
//   }
// }


class ConnectPrinterScreen extends StatefulWidget {
  @override
  _ConnectPrintersScreenState createState() => _ConnectPrintersScreenState();
}

class _ConnectPrintersScreenState extends State<ConnectPrinterScreen> {
  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _selectedPrinter;
  bool _isScanning = false;

  @override
  void initState() {
    super.initState();
    _checkPermissionsAndStartScan();
  }

  Future<void> _checkPermissionsAndStartScan() async {
    BluetoothAdapterState adapterState = await FlutterBluePlus.adapterState.first;

    if (adapterState != BluetoothAdapterState.on) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BluetoothErrorScreen(
            message: 'Bluetooth is turned off. Please enable it to search for printers.',
          ),
        ),
      );
      return;
    }

    if (await _requestBluetoothPermissions()) {
      _startScan();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Bluetooth permissions are required to search for printers.')),
      );
    }
  }

  Future<bool> _requestBluetoothPermissions() async {
    PermissionStatus locationStatus = await Permission.locationWhenInUse.request();
    if (locationStatus.isDenied || locationStatus.isPermanentlyDenied) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Location permissions are required for Bluetooth scanning.')),
      );
      return false;
    }

    PermissionStatus bluetoothScanStatus = await Permission.bluetoothScan.request();
    PermissionStatus bluetoothConnectStatus = await Permission.bluetoothConnect.request();

    return bluetoothScanStatus.isGranted && bluetoothConnectStatus.isGranted;
  }

  void _startScan() {
    setState(() {
      _isScanning = true;
      _devices = []; // Clear the previous devices list
    });
    print("1. Starting Bluetooth scan...");

    FlutterBluePlus.startScan(timeout: Duration(seconds: 10)).then((_) {
      setState(() {
        _isScanning = false;
      });
      print("2. Bluetooth scan finished.");
    });

    FlutterBluePlus.scanResults.listen((scanResults) {
      setState(() {
        _devices = scanResults.map((result) => result.device).toList();
      });
      print("Devices found: ${_devices.length}");
    });
  }

  void _onDeviceSelected(BluetoothDevice device) {
    setState(() {
      _selectedPrinter = device;
    });
  }

  void _connectToDevice() {
    if (_selectedPrinter != null) {
      print('Connecting to ${_selectedPrinter!.name}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final file = Provider.of<FileProvider>(context).selectedFile;

    if (file == null) {
      return Scaffold(
        appBar: AppBar(
          title: const Text("Available Printers"),
          centerTitle: true,
        ),
        body: Center(
          child: Text("No file selected"),
        ),
      );
    }

    return Scaffold(
      appBar: CustomAppBar(title: "Available Printers"),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16.0),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: _devices.isNotEmpty ? _devices.length : 4,
              itemBuilder: (context, index) {
                if (_devices.isEmpty) {
                  return _buildPrinterPlaceholder();
                } else {
                  final device = _devices[index];
                  return GestureDetector(
                    onTap: () => _onDeviceSelected(device),
                    child: _buildPrinterTile(device),
                  );
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: DeviceDimensions.screenWidth(context) * 0.6,
              child: ElevatedButton(
  onPressed: _isScanning
      ? null // Disable button if scanning
      : _selectedPrinter != null
          ? _connectToDevice // Connect if a device is selected
          : _startScan, // Call _startScan when no device is selected (Refresh)
  style: ElevatedButton.styleFrom(
    backgroundColor: const Color.fromARGB(255, 254, 110, 0),
    minimumSize: Size(double.infinity, 50),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
    ),
  ),
  child: Text(
    _isScanning
        ? "Scanning..." // Show Scanning while scanning
        : _selectedPrinter != null
            ? "Connect" // Show Connect if a device is selected
            : "Refresh", // Show Refresh if no device is selected
    style: const TextStyle(fontSize: 18, color: Colors.white),
  ),
),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrinterTile(BluetoothDevice device) {
    return Container(
      decoration: BoxDecoration(
        color: _selectedPrinter == device ? Colors.blue.withOpacity(0.1) : Colors.grey.shade200,
        borderRadius: BorderRadius.circular(12),
        border: _selectedPrinter == device
            ? Border.all(color: Colors.blue, width: 2)
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.print, size: 50, color: Colors.black54),
          const SizedBox(height: 8),
          Text(
            device.name.isNotEmpty ? device.name : 'Unknown Printer',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildPrinterPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 252, 176, 119).withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.print, size: 50, color: Color.fromARGB(255, 254, 110, 0)),
          const SizedBox(height: 8),
          if (!_isScanning) CustomLoader(), // Show loader only when scanning
        ],
      ),
    );
  }
}
