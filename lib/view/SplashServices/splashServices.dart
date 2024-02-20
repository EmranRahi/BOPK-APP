import 'dart:async';
import 'package:businessonlinepk/view/HomePage_ofBopk.dart';
import 'package:flutter/material.dart';


class SplashServices{
// Add a parameter to receive the BuildContext.
  void isLogin(BuildContext context)  {
    // Use Timer for the delay.
    Timer(Duration(seconds: 3), ()  {
      // Navigate to the Other screen.
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> HomePage()));
    });
  }

}