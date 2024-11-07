// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:printify/responsive/device_dimensions.dart';
// import 'package:widget_and_text_animator/widget_and_text_animator.dart';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({super.key});

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen>
//     with TickerProviderStateMixin {
//   late AnimationController _imageAnimationController;
//   late AnimationController _containerAnimationController;
//   late Animation<double> _scaleAnimation;
//   late Animation<Offset> _containerAnimation;
//   int _currentDot = 0;
//   final PageController _pageController = PageController(initialPage: 0);

//   final List<String> splashTitles = [
//     "Make your printing more\nsmart with Smart App ",
//     "Scan and Print\nconveniently",
//     "Compatible with Wifi\nPrinters",
//   ];

//   final List<String> splashDescriptions = [
//     "Scan, print or convert your document into\nprintable form and get smart at your best!",
//     "Capture pics, hardcopies, documents\nand print from your phone",
//     "Print your documents and photos\nwirelessly and smartly",
//   ];

//   final List<String> splashImages = [
//     "assets/images/splash1.jpg",
//     "assets/images/splash2.jpg",
//     "assets/images/splash3.jpg",
//   ];

//   @override
//   void initState() {
//     super.initState();
//     SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

//     _imageAnimationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _containerAnimationController = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     );

//     _scaleAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
//       CurvedAnimation(
//         parent: _imageAnimationController,
//         curve: Curves.easeOut,
//       ),
//     );

//     _containerAnimation = Tween<Offset>(
//       begin: const Offset(0, 1),
//       end: Offset.zero,
//     ).animate(
//       CurvedAnimation(
//         parent: _containerAnimationController,
//         curve: Curves.easeOut,
//       ),
//     );

//     _containerAnimationController.forward().then((_) {
//       Timer.periodic(const Duration(seconds: 3), (timer) {
//         int nextPage = (_currentDot + 1) % splashImages.length;

//         _pageController.animateToPage(
//           nextPage,
//           duration: const Duration(milliseconds: 800),
//           curve: Curves.easeOut,
//         );

//         setState(() {
//           _currentDot = nextPage;
//         });

//         _imageAnimationController.reset();
//         _imageAnimationController.forward();
//       });
//     });

//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       _imageAnimationController.forward();
//     });
//   }

//   @override
//   void dispose() {
//     _imageAnimationController.dispose();
//     _containerAnimationController.dispose();
//     _pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           PageView.builder(
//             controller: _pageController,
//             itemCount: splashImages.length,
//             onPageChanged: (index) {
//               setState(() {
//                 _currentDot = index;
//               });

//               _imageAnimationController.reset();
//               _imageAnimationController.forward();
//             },
//             itemBuilder: (context, index) {
//               return AnimatedBuilder(
//                 animation: _imageAnimationController,
//                 builder: (context, child) {
//                   return Transform.scale(
//                     scale: _scaleAnimation.value,
//                     child: Align(
//                       alignment: Alignment.topCenter,
//                       child: SizedBox(
//                         height: DeviceDimensions.screenHeight(context) * 0.60,
//                         width: DeviceDimensions.screenWidth(context),
//                         child: Image.asset(
//                           splashImages[index],
//                           fit: BoxFit.cover,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             },
//           ),
//           Positioned(
//             bottom:
//                 280, // Adjust this value to control the position of the blur image
//             left: 0,
//             right: 0,
//             child: SlideTransition(
//               position: _containerAnimation,
//               child: Image.asset(
//                 "assets/images/blur.png",
//                 fit: BoxFit.cover, // Ensure the blur image covers the area
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: SlideTransition(
//               position: _containerAnimation,
//               child: Container(
//                 height: DeviceDimensions.screenHeight(context) * 0.38,
//                 width: DeviceDimensions.screenWidth(context),
//                 decoration: const BoxDecoration(
//                   color: Color(0xFFFFFFFF),
//                 ),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     WidgetAnimator(
//                       incomingEffect:
//                           WidgetTransitionEffects.incomingSlideInFromRight(
//                         duration: const Duration(milliseconds: 400),
//                       ),
//                       outgoingEffect:
//                           WidgetTransitionEffects.outgoingSlideOutToLeft(
//                         duration: const Duration(milliseconds: 400),
//                       ),
//                       child: Text(
//                         key: ValueKey<int>(_currentDot),
//                         splashTitles[_currentDot],
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize:
//                               DeviceDimensions.responsiveSize(context) * 0.070,
//                           fontFamily: "Barlow-Bold",
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                         height: DeviceDimensions.screenHeight(context) * 0.015),
//                     WidgetAnimator(
//                       incomingEffect:
//                           WidgetTransitionEffects.incomingSlideInFromRight(
//                         duration: const Duration(milliseconds: 400),
//                       ),
//                       outgoingEffect:
//                           WidgetTransitionEffects.outgoingSlideOutToLeft(
//                         duration: const Duration(milliseconds: 400),
//                       ),
//                       child: Text(
//                         key: ValueKey<int>(_currentDot),
//                         splashDescriptions[_currentDot],
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           fontSize:
//                               DeviceDimensions.responsiveSize(context) * 0.035,
//                           fontFamily: "Barlow-Regular",
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                         height: DeviceDimensions.screenHeight(context) * 0.04),
//                     SizedBox(
//                       width: DeviceDimensions.screenWidth(context) * 0.70,
//                       height: DeviceDimensions.screenHeight(context) * 0.065,
//                       child: ElevatedButton(
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/home-screen');
//                         },
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF4C6AFF),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(10.0),
//                           ),
//                         ),
//                         child: Text(
//                           'Get started',
//                           style: TextStyle(
//                             fontSize: DeviceDimensions.responsiveSize(context) *
//                                 0.053,
//                             color: Colors.white,
//                             fontFamily: 'Barlow-Regular',
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ),
//                       ),
//                     ),
//                     SizedBox(
//                         height: DeviceDimensions.screenHeight(context) * 0.048),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: List.generate(
//                         splashTitles.length,
//                         (index) {
//                           return AnimatedContainer(
//                             margin: const EdgeInsets.symmetric(horizontal: 6.0),
//                             duration: const Duration(milliseconds: 500),
//                             width:
//                                 DeviceDimensions.screenHeight(context) * 0.011,
//                             height:
//                                 DeviceDimensions.screenHeight(context) * 0.011,
//                             decoration: BoxDecoration(
//                               color: _currentDot == index
//                                   ? const Color(0xFF4C6AFF)
//                                   : Colors.grey,
//                               borderRadius: BorderRadius.circular(5.0),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                     const Spacer(),
//                     Container(
//                       height: DeviceDimensions.screenHeight(context) * 0.007,
//                       width: DeviceDimensions.screenWidth(context) * 0.40,
//                       decoration: BoxDecoration(
//                         color: Colors.black,
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                     ),
//                     SizedBox(
//                         height: DeviceDimensions.screenHeight(context) * 0.01),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:printify/responsive/device_dimensions.dart';
import 'package:widget_and_text_animator/widget_and_text_animator.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _imageAnimationController;
  late AnimationController _containerAnimationController;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _containerAnimation;
  int _currentDot = 0;
  final PageController _pageController = PageController(initialPage: 0);
  Timer? _pageTimer;

  final List<String> splashTitles = [
    "Make your printing more\nsmart with Smart App ",
    "Scan and Print\nconveniently",
    "Compatible with Wifi\nPrinters",
  ];

  final List<String> splashDescriptions = [
    "Scan, print or convert your document into\nprintable form and get smart at your best!",
    "Capture pics, hardcopies, documents\nand print from your phone",
    "Print your documents and photos\nwirelessly and smartly",
  ];

  final List<String> splashImages = [
    "assets/images/splash1.jpg",
    "assets/images/splash2.jpg",
    "assets/images/splash3.jpg",
  ];

  @override
  void initState() {
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

    _imageAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    _containerAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.1, end: 1.0).animate(
      CurvedAnimation(
        parent: _imageAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _containerAnimation = Tween<Offset>(
      begin: const Offset(0, 1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _containerAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _containerAnimationController.forward();
    _startPageTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Preload images to prevent flashing
    for (var image in splashImages) {
      precacheImage(AssetImage(image), context);
    }
  }

  void _startPageTimer() {
    _pageTimer = Timer.periodic(const Duration(seconds: 3), (timer) {
      int nextPage = (_currentDot + 1) % splashImages.length;

      _pageController.animateToPage(
        nextPage,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOut,
      );

      setState(() {
        _currentDot = nextPage;
      });

      _imageAnimationController.reset();
      _imageAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _pageTimer?.cancel();
    _imageAnimationController.dispose();
    _containerAnimationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: splashImages.length,
            onPageChanged: (index) {
              setState(() {
                _currentDot = index;
              });

              _imageAnimationController.reset();
              _imageAnimationController.forward();
            },
            itemBuilder: (context, index) {
              return AnimatedBuilder(
                animation: _imageAnimationController,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.60,
                        width: DeviceDimensions.screenWidth(context),
                        child: Image.asset(
                          splashImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
          Positioned(
            bottom: 280,
            left: 0,
            right: 0,
            child: SlideTransition(
              position: _containerAnimation,
              child: Image.asset(
                "assets/images/blur.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SlideTransition(
              position: _containerAnimation,
              child: Container(
                height: DeviceDimensions.screenHeight(context) * 0.38,
                width: DeviceDimensions.screenWidth(context),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFFFFF),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromRight(
                        duration: const Duration(milliseconds: 400),
                      ),
                      outgoingEffect:
                          WidgetTransitionEffects.outgoingSlideOutToLeft(
                        duration: const Duration(milliseconds: 400),
                      ),
                      child: Text(
                        key: ValueKey<int>(_currentDot),
                        splashTitles[_currentDot],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              DeviceDimensions.responsiveSize(context) * 0.070,
                          fontFamily: "Barlow-Bold",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.015),
                    WidgetAnimator(
                      incomingEffect:
                          WidgetTransitionEffects.incomingSlideInFromRight(
                        duration: const Duration(milliseconds: 400),
                      ),
                      outgoingEffect:
                          WidgetTransitionEffects.outgoingSlideOutToLeft(
                        duration: const Duration(milliseconds: 400),
                      ),
                      child: Text(
                        key: ValueKey<int>(_currentDot),
                        splashDescriptions[_currentDot],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:
                              DeviceDimensions.responsiveSize(context) * 0.035,
                          fontFamily: "Barlow-Regular",
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                    SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.04),
                    SizedBox(
                      width: DeviceDimensions.screenWidth(context) * 0.70,
                      height: DeviceDimensions.screenHeight(context) * 0.065,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/home-screen');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 254, 110, 0),
                         // backgroundColor: const Color(0xFF4C6AFF),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text(
                          'Get started',
                          style: TextStyle(
                            fontSize: DeviceDimensions.responsiveSize(context) *
                                0.053,
                            color: Colors.white,
                            fontFamily: 'Barlow-Regular',
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.048),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        splashTitles.length,
                        (index) {
                          return AnimatedContainer(
                            margin: const EdgeInsets.symmetric(horizontal: 6.0),
                            duration: const Duration(milliseconds: 500),
                            width:
                                DeviceDimensions.screenHeight(context) * 0.011,
                            height:
                                DeviceDimensions.screenHeight(context) * 0.011,
                            decoration: BoxDecoration(
                              color: _currentDot == index
                              ? Color.fromARGB(255, 254, 110, 0)
                                  // ? const Color(0xFF4C6AFF)
                                  : Colors.grey,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          );
                        },
                      ),
                    ),
                    const Spacer(),
                    Container(
                      height: DeviceDimensions.screenHeight(context) * 0.007,
                      width: DeviceDimensions.screenWidth(context) * 0.40,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    SizedBox(
                        height: DeviceDimensions.screenHeight(context) * 0.01),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
