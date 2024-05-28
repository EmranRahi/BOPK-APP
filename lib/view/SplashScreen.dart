import 'package:businessonlinepk/Controllers/Api_Controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../globle_variable/CategoryService.dart';
import '../model/HomePageMainCategory.dart';
import 'HomePage_ofBopk.dart';
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
    fetchDataAndNavigate();
  }

  Future<void> fetchDataAndNavigate() async {
    await CategoryService.instance.fetchCategories();

    // Add a delay of 2 seconds before navigating
    await Future.delayed(Duration(seconds: 2));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Hide status bar icons by setting the system overlay style
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent, // Set the status bar color to transparent
      statusBarIconBrightness: Brightness.light, // Use dark icons on the status bar
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Image.asset(
          "assets/images/bopksplash.png",
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}

