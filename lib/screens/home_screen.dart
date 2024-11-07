import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:printify/responsive/device_dimensions.dart';
import 'package:printify/widgets/home_layout_widget.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: DeviceDimensions.screenHeight(context) * 0.030),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: (){
                    Navigator.pushNamed(context, '/help-screen');
                    },
                    child: SvgPicture.asset(
                      "assets/icons/question.svg",
                      height: 27,
                    ),
                  ),
                  Text(
                    "Printer",
                    style: TextStyle(
                      fontSize:
                          DeviceDimensions.responsiveSize(context) * 0.070,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, '/settings-screen');
                    },
                    child: SvgPicture.asset(
                      "assets/icons/setting.svg",
                      height: 28,
                    ),
                  )
                ],
              ),
            ),
            const Divider(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: DeviceDimensions.screenWidth(context) * 0.04),
                child: const layout_grid(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

 