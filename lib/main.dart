import 'dart:convert';

import 'package:businessonlinepk/Controllers/Api_Controller.dart';
import 'package:businessonlinepk/model/StaticListModelPage.dart';
import 'package:businessonlinepk/test_dialouge.dart';
import 'package:businessonlinepk/view/HomePage_ofBopk.dart';
import 'package:businessonlinepk/view/StaticBusinessDetailsPage.dart';
import 'package:businessonlinepk/view/add_jobs.dart';
import 'package:businessonlinepk/view/business_for_sale.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/deal_and_discount_screen.dart';
import 'package:businessonlinepk/view/get_discount_card_screeen.dart';
import 'package:businessonlinepk/view/get_your_business_now.dart';
import 'package:businessonlinepk/view/main_page_bopk.dart';
import 'package:businessonlinepk/view/menu_login.dart';
import 'package:businessonlinepk/view/mobile_shops.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/product_deatils_screen/product_details.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
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
            home: HomePage(),
          );
        }
     );
  }
}





