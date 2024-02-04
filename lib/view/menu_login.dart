import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customs_widgets/constant_color.dart';
import 'customs_widgets/custom_text.dart';

class MenuLogin extends StatefulWidget {
  const MenuLogin({super.key});

  @override
  State<MenuLogin> createState() => _MenuLoginState();
}

class _MenuLoginState extends State<MenuLogin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar1(
        elevation: 0,
        centerTitle: false,
        title: CustomText(
          title: 'Business',
          color: grayColor,
          fontSize: 20,
          googleFont: "Jost",
          fontWeight: FontWeight.w700,
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },icon:
        Icon(
          Icons.arrow_back,
          color: greenColor2,
          size: 25,
        ),
        ),
        action: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PopupMenuButton<int>(
              icon: Icon(Icons.menu, color: greenColor2, size: 30),
              color: whiteColor,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<int>>[
                  PopupMenuItem<int>(
                    value: 0,
                    child: CustomText(
                        title: "Login ", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 1,
                    child: CustomText(
                        title: "Register Your Business",
                        fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 2,
                    child: CustomText(
                        title: "BOPK Home", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 3,
                    child: CustomText(
                        title: "Business For Sale",
                        fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 4,
                    child: CustomText(
                        title: "About us", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    value: 5,
                    child: CustomText(
                        title: "Contact us", fontStyle: FontStyle.italic),
                  ),
                ];
              },
              onSelected: (int value) {
                if (value == 0) {
                  print("Login menu is selected.");
                } else if (value == 1) {
                  print("Register Your Business menu is selected.");
                } else if (value == 2) {
                  print("BOPK Home menu is selected.");
                } else if (value == 3) {
                  print("Business For Sale menu is selected.");
                } else if (value == 4) {
                  print("About us menu is selected.");
                } else if (value == 5) {
                  print("Contact us menu is selected.");
                }
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 15.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      title: "LOGIN TO MANAGE BUSINESS",
                      color: greenColor2,
                      googleFont: "Jost",
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: CustomText(
                    title: "User Name:",
                    fontWeight: FontWeight.bold,
                    googleFont: "Jost",
                    fontSize: 16,

                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(2),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: CustomTextFormFieldWidget(
                    hint: 'Enter User Name',
                    borderRadius: 6,
                    borderSide: BorderSide.none,

                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 2.w),
                  child: CustomText(
                    title: "Password:",
                    fontWeight: FontWeight.bold,
                    googleFont: "Jost",
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(2),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 1,
                        blurRadius: 7,
                        offset: Offset(0, 0),
                      ),
                    ],
                  ),
                  child: CustomTextFormFieldWidget(
                    hint: 'Enter Your Password',
                    borderRadius: 6,
                    borderSide: BorderSide.none,

                  ),
                ),
                // SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Custom_Button_Widget(
                      ontap: () {},
                      rd: 6,
                      color: Colors.transparent,
                      child: CustomText(
                        title: "Forgot Password?",
                        googleFont: "Jost",
                        decoration: TextDecoration.underline,
                        color: blueColor1,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(6),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        )
                      ]
                    ),
                    child: Custom_Button_Widget(
                      ontap: () {},
                      rd: 6,
                      color: greenColor2,
                      child: CustomText(
                        title: "Sign In",
                        googleFont: "Jost",
                        color: whiteColor,
                        fontWeight: FontWeight.w700,
                        fontSize: 20.sp,
                      ),
                    ),
                  ),
                ],)

              ],
            ),
          ),
        ],
      ),
    );
  }
}
