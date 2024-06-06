import 'package:businessonlinepk/BusinessDashboard.dart';
import 'package:businessonlinepk/model/LoginModel.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Controllers/Api_Controller.dart';
import 'HomePage_ofBopk.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'customs_widgets/LoadingDialog.dart';
import 'customs_widgets/constant_color.dart';
import 'customs_widgets/custom_text.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';

class MenuLogin extends StatefulWidget {
  const MenuLogin({super.key});

  @override
  State<MenuLogin> createState() => _MenuLoginState();
}

class _MenuLoginState extends State<MenuLogin> {
  final TextEditingController _emailController = TextEditingController();

  bool _loading = false;
  bool isColor = false;
  bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();
  final APIController apiController = APIController();
  String _username = '';
  String _password = '';

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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
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
                  // PopupMenuItem<int>(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => MenuLogin()));
                  //   },
                  //   value: 0,
                  //   child: CustomText(
                  //       title: "Login ", fontStyle: FontStyle.italic),
                  // ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterYourBusiness()));
                    },
                    value: 1,
                    child: CustomText(
                        title: "Register Your Business",
                        fontStyle: FontStyle.italic),
                  ),

                  /// felhal Comment Menu Bar
                  // PopupMenuDivider(),

                  // PopupMenuItem<int>(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => VerifyDownLoadScreen()));
                  //   },
                  //   value: 3,
                  //   child: CustomText(
                  //       title: "Verify Download", fontStyle: FontStyle.italic),
                  // ),
                  // PopupMenuDivider(),
                  // PopupMenuItem<int>(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => PayNowScreen()));
                  //   },
                  //   value: 4,
                  //   child: CustomText(
                  //       title: "Pay Now", fontStyle: FontStyle.italic),
                  // ),
                  // PopupMenuDivider(),
                  // PopupMenuItem<int>(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => GetDisCountCard()));
                  //   },
                  //   value: 5,
                  //   child: CustomText(
                  //       title: "Get Discount Card",
                  //       fontStyle: FontStyle.italic),
                  // ),
                  // PopupMenuDivider(),
                  // PopupMenuItem<int>(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => GetYourBusinessNow()));
                  //   },
                  //   value: 6,
                  //   child: CustomText(
                  //       title: "Get Your Business Verify Now",
                  //       fontStyle: FontStyle.italic),
                  // ),
                  // PopupMenuDivider(),
                  // PopupMenuItem<int>(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => DealAndDisCount()));
                  //   },
                  //   value: 7,
                  //   child: CustomText(
                  //       title: "Deal And Discount ",
                  //       fontStyle: FontStyle.italic),
                  // ),
                  // PopupMenuDivider(),
                  // PopupMenuItem<int>(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => BusinessForSale()));
                  //   },
                  //   value: 10,
                  //   child: CustomText(
                  //       title: "Business For Sale",
                  //       fontStyle: FontStyle.italic),
                  // ),
                  // PopupMenuDivider(),
                  // PopupMenuItem<int>(
                  //   onTap: () {
                  //     Navigator.push(context,
                  //         MaterialPageRoute(builder: (context) => AddJobs()));
                  //   },
                  //   value: 8,
                  //   child: CustomText(
                  //       title: "Add Jobs", fontStyle: FontStyle.italic),
                  // ),
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
                } else if (value == 6) {
                  print("Contact us menu is selected.");
                } else if (value == 7) {
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
                    controller: _emailController,
                    hint: 'Enter User Name',
                    borderRadius: 6,
                    borderSide: BorderSide.none,
                    onChanged: (value) {
                      _username = value;
                    },
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
                  child: Padding(
                    padding: EdgeInsets.all(6), // Adding padding of 6
                    child: TextFormField(
                      controller: _passwordController,
                      obscureText: _obscureText,
                      decoration: InputDecoration(
                        hintText: 'Enter Your Password',
                        border: InputBorder.none,
                        suffixIcon: IconButton(
                          icon: Icon(_obscureText ? Icons.visibility_off : Icons.visibility),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                      ),
                      onChanged: (value) {
                        _password = value;
                      },
                    ),
                  ),
                ),

                SizedBox(height: ScreenUtil().setHeight(20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 35),
                    //   child: Custom_Button_Widget(
                    //     ontap: () {
                    //
                    //     },
                    //     rd: 6,
                    //     color: Colors.transparent,
                    //     child: CustomText(
                    //       title: "Forgot Password?",
                    //       googleFont: "Jost",
                    //       decoration: TextDecoration.underline,
                    //       color: blueColor1,
                    //       fontSize: 18.sp,
                    //     ),
                    //   ),
                    // ),

                    AnimatedSwitcher(
                      duration: Duration(milliseconds: 500),
                      child: _loading
                          ? CircularProgressIndicator() // Show CircularProgressIndicator when loading
                          : Custom_Button_Widget(
                              key: UniqueKey(),
                              // Key to ensure proper animation
                              ontap: () {
                                _login();
                              },
                              rd: 6,
                              color: greenColor2,
                              child: CustomText(
                                title: "Log In",
                                googleFont: "Jost",
                                color: whiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 15.sp,
                              ),
                            ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _login() async {
    setState(() {
      _loading = true; // Set loading to true when login process starts
    });

    // Call the loginUser method from ApiController
    LoginModel? response = await apiController.loginUser(_username, _password);

    if (response != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BusinessDashboard(response.fkKarobarId)),
      );
    } else {
      // Handle login failure, for example, display an error message
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Login Failed'),
          content:
              const Text('Invalid username or password. Please try again.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }

    setState(() {
      _loading = false; // Set loading to false when login process completes
    });
  }
}
