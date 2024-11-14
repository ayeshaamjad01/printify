import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printify/responsive/device_dimensions.dart';
import 'package:printify/widgets/custom_app_bar.dart';

class ConnectPrinterScreen extends StatefulWidget {
  @override
  _ConnectPrinterScreenState createState() => _ConnectPrinterScreenState();
}

class _ConnectPrinterScreenState extends State<ConnectPrinterScreen> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  final List<BluetoothDiscoveryResult> _devices = [];
  BluetoothDevice? _selectedPrinter;
  bool _isDiscovering = false;

  @override
  void initState() {
    super.initState();
    _checkPermissions();
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });
    startBluetoothDiscovery();
  }

  Future<void> _checkPermissions() async {
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      print("Bluetooth permissions granted");
    } else {
      print("Bluetooth permissions not granted");
    }
  }

  Future<void> startBluetoothDiscovery() async {
    setState(() {
      _devices.clear();
      _isDiscovering = true;
    });
    // Request permissions
    if (await Permission.bluetoothScan.request().isGranted &&
        await Permission.bluetoothConnect.request().isGranted) {
      // Start discovery
      FlutterBluetoothSerial.instance.startDiscovery().listen((result) {
        setState(() {
          if (!_devices.any(
              (device) => device.device.address == result.device.address)) {
            _devices.add(result);
          }
        });
        print('Found device: ${result.device.name}');
      }).onDone(() {
        setState(() {
          _isDiscovering = false; // Stop discovering state when done
        });
      });
    } else {
      print('Bluetooth permissions not granted');
    }
  }

  Future<void> _connectToDevice(BluetoothDevice device) async {
    try {
      print('Attempting to connect to ${device.name}');

      // Attempt to connect with a timeout
      BluetoothConnection connection =
          await BluetoothConnection.toAddress(device.address)
              .timeout(Duration(seconds: 10), onTimeout: () {
        print("Connection timeout. Please try again.");
        return Future.error("Connection timeout");
      });

      print('Connected to the device ${device.name}');

      // You may send test data to check the connection
      connection.output.add(Uint8List.fromList([/* add data to send */]));
      await connection.output.allSent;

      // Listen for incoming data
      connection.input?.listen((Uint8List data) {
        print('Data received: $data');
      }).onDone(() {
        print('Disconnected from device');
      });
    } catch (e) {
      print('Cannot connect, exception occurred: $e');
    }
  }

  Future<void> toggleBluetooth() async {
    if (_bluetoothState == BluetoothState.STATE_OFF) {
      await FlutterBluetoothSerial.instance.requestEnable();
    } else if (_bluetoothState == BluetoothState.STATE_ON) {
      await FlutterBluetoothSerial.instance.requestDisable();
      await Future.delayed(Duration(seconds: 2));
      await FlutterBluetoothSerial.instance.requestEnable();
    }
    startBluetoothDiscovery();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Connect to Printer"),
      // appBar: AppBar(
      //   title: Text("Connect to Printer"),
      //   actions: [
      //     IconButton(
      //       icon: Icon(Icons.refresh),
      //       onPressed: _isDiscovering ? null : startBluetoothDiscovery,
      //     )
      //   ],
      // ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _devices.length,
              itemBuilder: (context, index) {
                final result = _devices[index];
                return ListTile(
                  leading: Icon(Icons.bluetooth),
                  title: Text(result.device.name ?? "Unknown Device"),
                  subtitle: Text(result.device.address),
                  onTap: () {
                    setState(() {
                      _selectedPrinter = result.device;
                    });
                    _connectToDevice(result.device);
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _selectedPrinter != null
                      ? () => _connectToDevice(_selectedPrinter!)
                      : null,
                  child: Container(
                    width: DeviceDimensions.screenWidth(context) * 0.5,
                    height: DeviceDimensions.screenHeight(context) * 0.05,
                    margin: const EdgeInsets.only(top: 10.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 20.0),
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 254, 110, 0),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Center(
                      child: Text(
                        'Connect to Printer',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: DeviceDimensions.responsiveSize(context) *
                                0.04),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: DeviceDimensions.screenHeight(context) * 0.05,
                  child: IconButton(
                    icon: Icon(Icons.refresh),
                    onPressed: _isDiscovering ? null : startBluetoothDiscovery,
                  ),
                ),
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(16.0),
          //   child: ElevatedButton(
          //     onPressed: _selectedPrinter != null
          //         ? () => _connectToDevice(_selectedPrinter!)
          //         : null,
          //     child: Text("Connect to Printer"),
          //   ),
          // ),
        ],
      ),
    );
  }
}
