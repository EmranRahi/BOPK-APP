import 'dart:convert';
import 'package:businessonlinepk/Controllers/Api_Controller.dart';
import 'package:businessonlinepk/test_dialouge.dart';
import 'package:businessonlinepk/view/HomePage_ofBopk.dart';
import 'package:businessonlinepk/view/SplashScreen.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'Controllers/BopkController.dart';
import 'model/HomePageMainCategory.dart';
import 'model/OpeningAndClosingTimeModel.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'model/RegisterReviewRattingModel.dart';
import 'model/StaticListModelPage.dart';

void main() {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive, overlays: []);
  runApp(DevicePreview(
      enabled: false,
      builder: (context)=> BopkApp()));
  // runApp(const BopkApp());
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
      ensureScreenSize: true,
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
            home: HomePage(),
          );
        }
     );
  }
}


