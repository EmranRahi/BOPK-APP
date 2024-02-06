import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'SplashServices/splashServices.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    // Create an instance of SplashServices and call isLogin with the context.
    SplashServices().isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    // Hide status bar icons by setting the system overlay style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set the status bar color to transparent
      statusBarIconBrightness: Brightness.dark, // Use dark icons on the status bar
     ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body:  Image.asset("assets/images/bopksplash.png",
            width: double.infinity,
            fit: BoxFit.fill),
      ),
    );
  }
}
