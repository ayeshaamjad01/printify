import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:printify/provider/file_provider.dart';
import 'package:printify/screens/connect_printer_screen.dart';
import 'package:printify/screens/bluetooth_error_screen.dart';
import 'package:printify/screens/file_preview_screen.dart';
import 'package:printify/screens/help_screen.dart';
import 'package:printify/screens/home_screen.dart';
import 'package:printify/screens/printing_example.dart';
import 'package:printify/screens/settings_screen.dart';
import 'package:printify/screens/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => FileProvider()),],
      child: const MyApp(),
    ), );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Printify',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
       
        initialRoute: '/splash-screen',
        routes: {
          '/splash-screen': (context) => const SplashScreen(),
          '/home-screen': (BuildContext context) => const HomeScreen(),
          '/print-example': (BuildContext context) => PrintExample(),
          '/settings-screen': (context) => const SettingsScreen(),
          '/connect-printer': (context) => ConnectPrinterScreen(),
          '/help-screen': (BuildContext context) => const HelpScreen(),
        },
        onGenerateRoute: (settings) {
        if (settings.name == '/file-print-preview') {
          return MaterialPageRoute(
            builder: (context) => PreviewScreen(),
          );
        } else if (settings.name == '/bluetooth-error') {
          return MaterialPageRoute(
            builder: (context) => BluetoothErrorScreen(message: "Bluetooth is turned off.", ),
          );
        }
        return null;
      },//home: SplashScreen(),
        );
  }
}
