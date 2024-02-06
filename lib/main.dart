import 'dart:convert';
import 'package:businessonlinepk/view/SplashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;


void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(const BopkApp());
  // SystemChrome.setSystemUIOverlayStyle(
  //     SystemUiOverlayStyle(
  //       statusBarColor: greenColor2, // Change this to the desired color
  //       statusBarIconBrightness: Brightness.light, // Change text color to light or dark
  //     ),
  // );
}

class BopkApp extends StatelessWidget {
  const BopkApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 690),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          // Hide status bar icons by setting the system overlay style
          SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
            statusBarColor: Colors.transparent, // Set the status bar color to transparent
            statusBarIconBrightness: Brightness.light, // Use dark icons on the status bar
            ),
          );
          return MaterialApp(
       debugShowCheckedModeBanner: false,
            home: SplashScreen(),
          );
        }
     );
  }
}





