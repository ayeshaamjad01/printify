import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';



class CustomLoader extends StatelessWidget {
  const CustomLoader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SpinKitThreeBounce(
      color:  Color.fromARGB(255, 254, 110, 0), // Customize the color
      size: 15.0,         // Customize the size
      duration: Duration(seconds: 1), // Customize the speed
    );
  }
}