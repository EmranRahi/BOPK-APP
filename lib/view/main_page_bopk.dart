import 'package:businessonlinepk/view/add_jobs.dart';
import 'package:businessonlinepk/view/business_for_sale.dart';
import 'package:businessonlinepk/view/mobile_shops.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'customs_widgets/constant_color.dart';
import 'customs_widgets/custom_appbar.dart';
import 'customs_widgets/custom_button.dart';
import 'customs_widgets/custom_text.dart';
import 'customs_widgets/custom_textfield.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'menu_login.dart';

class MainPageBopk extends StatefulWidget {
  const MainPageBopk({super.key});
  @override
  State<MainPageBopk> createState() => _MainPageBopkState();
}

class _MainPageBopkState extends State<MainPageBopk> {
  final CarouselController _carouselController = CarouselController();
  int _currentImageIndex = 0;
  List<String> imgList = [
    'assets/images/deal.jpg',
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/cmptr.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(
        centerTitle: false,
        title: CustomText(
          title: 'Mobile Shops',
          color: grayColor,
        ),
        // leading: Icon(
        //   Icons.arrow_back,
        //   color: tealColor,
        //   size: 30,
        // ),
        action: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PopupMenuButton<int>(
              icon: Icon(Icons.menu, color: greenColor2,size: 30),
              color: whiteColor,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<int>>[
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MenuLogin()));
                    },
                    value: 0,
                    child: CustomText(title: "Login ", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterYourBusiness()));
                    },
                    value: 1,
                    child: CustomText(title: "Register Your Business", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MainPageBopk()));
                    },
                    value: 2,
                    child: CustomText(title: "BOPK Home", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyDownLoadScreen()));
                    },
                    value: 3,
                    child: CustomText(title: "Verify Download", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> PayNowScreen()));
                    },
                    value: 4,
                    child: CustomText(title: "Pay Now", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetDisCountCard()));
                    },
                    value: 5,
                    child: CustomText(title: "Get Discount Card", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> GetYourBusinessNow()));
                    },
                    value: 6,
                    child: CustomText(title: "Get Your Business Verify Now", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DealAndDisCount()));
                    },
                    value: 7,
                    child: CustomText(title: "Deal And Discount ", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MobileShops()));
                    },
                    value: 8,
                    child: CustomText(title: "Mobile Shops", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> BusinessForSale()));
                    },
                    value: 10,
                    child: CustomText(title: "Business For Sale", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> AddJobs()));
                    },
                    value: 8,
                    child: CustomText(title: "Add Jobs", fontStyle: FontStyle.italic),
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
                }else if (value == 6) {
                  print("Contact us menu is selected.");
                }else if (value == 7) {
                  print("Contact us menu is selected.");
                }
              },
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: Column(
          children: [
            CustomTextFormFieldWidget(
              borderRadius: 10,
              contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 20),
              hint: "Find Business near you",
              suffixIcon: Icon(Icons.share),
              prefixIcon: Icon(Icons.search),
            ),
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
              ),
              items: imgList.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      height: 147,
                      width: 336,
                      scale: 2,
                      item,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            Expanded(
              child: ListView(
                  scrollDirection: Axis.vertical,
                children:
                [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: ScreenUtil().screenHeight/9,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return  GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return MobileShops();
                            }));
                            print("Tapped on item");
                          },
                          child: Column(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth/4,
                                height: ScreenUtil().screenHeight/11.7,
                                margin: EdgeInsets.only(right: 8,left: 7),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white60,),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey,
                                  //     blurRadius: 2.0, // Soften the shaodw
                                  //     spreadRadius: 0.1,
                                  //     offset: Offset(0.0, 0.0),
                                  //   ),
                                  // ],
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.asset('assets/images/mbl.png',scale: 6,)),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: greenColor2,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(9),
                                            bottomLeft: Radius.circular(9),
                                          ),
                                          border: Border.all(color: Colors.white60),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0, // Set the widget at the bottom of the Stack
                                        left: 20, // Set left to 0 for alignment
                                        right: 0, // Set right to 0 for alignment
                                        child: CustomText(title: "اردو ٹیکسٹ",color: whiteColor,)),
                                  ],
                                ),
                              ),
                              CustomText(title: "add text",color: grayColor,),
                            ],
                          ),
                        );
                      },
                      // This next line does the trick.
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: ScreenUtil().screenHeight/9,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return  GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return MobileShops();
                            }));
                            print("Tapped on item");
                          },
                          child: Column(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth/4,
                                height: ScreenUtil().screenHeight/11.7,
                                margin: EdgeInsets.only(right: 8,left: 7),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white60,),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey,
                                  //     blurRadius: 2.0, // Soften the shaodw
                                  //     spreadRadius: 0.1,
                                  //     offset: Offset(0.0, 0.0),
                                  //   ),
                                  // ],
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.center,
                                        child: Image.asset('assets/images/cmptr.jpg',scale: 10,)),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: greenColor2,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(9),
                                            bottomLeft: Radius.circular(9),
                                          ),
                                          border: Border.all(color: Colors.white60),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0, // Set the widget at the bottom of the Stack
                                        left: 20, // Set left to 0 for alignment
                                        right: 0, // Set right to 0 for alignment
                                        child: CustomText(title: "اردو ٹیکسٹ",color: whiteColor,)),
                                  ],
                                ),
                              ),
                              CustomText(title: "add text",color: grayColor,),
                            ],
                          ),
                        );
                      },
                      // This next line does the trick.
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: ScreenUtil().screenHeight/9,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return  GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return MobileShops();
                            }));
                            print("Tapped on item");
                          },
                          child: Column(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth/4,
                                height: ScreenUtil().screenHeight/11.7,
                                margin: EdgeInsets.only(right: 8,left: 7),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white60,),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey,
                                  //     blurRadius: 2.0, // Soften the shaodw
                                  //     spreadRadius: 0.1,
                                  //     offset: Offset(0.0, 0.0),
                                  //   ),
                                  // ],
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.asset('assets/images/bike.jpg',scale: 9,)),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: greenColor2,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(9),
                                            bottomLeft: Radius.circular(9),
                                          ),
                                          border: Border.all(color: Colors.white60),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0, // Set the widget at the bottom of the Stack
                                        left: 20, // Set left to 0 for alignment
                                        right: 0, // Set right to 0 for alignment
                                        child: CustomText(title: "اردو ٹیکسٹ",color: whiteColor,)),
                                  ],
                                ),
                              ),
                              CustomText(title: "add text",color: grayColor,),
                            ],
                          ),
                        );
                      },
                      // This next line does the trick.
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: ScreenUtil().screenHeight/9,
                    child: ListView.builder(
                      itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return  GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return MobileShops();
                            }));
                            print("Tapped on item");
                          },
                          child: Column(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth/4,
                                height: ScreenUtil().screenHeight/11.7,
                                margin: EdgeInsets.only(right: 8,left: 7),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white60,),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey,
                                  //     blurRadius: 2.0, // Soften the shaodw
                                  //     spreadRadius: 0.1,
                                  //     offset: Offset(0.0, 0.0),
                                  //   ),
                                  // ],
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.asset('assets/images/printer.png',scale: 4,)),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: greenColor2,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(9),
                                            bottomLeft: Radius.circular(9),
                                          ),
                                          border: Border.all(color: Colors.white60),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0, // Set the widget at the bottom of the Stack
                                        left: 20, // Set left to 0 for alignment
                                        right: 0, // Set right to 0 for alignment
                                        child: CustomText(title: "اردو ٹیکسٹ",color: whiteColor,)),
                                  ],
                                ),
                              ),
                              CustomText(title: "add text",color: grayColor,),
                            ],
                          ),
                        );
                      },
                      // This next line does the trick.
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    height: ScreenUtil().screenHeight/9,
                    child: ListView.builder(
                      itemCount: 3,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context,index){
                        return  GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context){
                              return MobileShops();
                            }));
                            print("Tapped on item");
                          },
                          child: Column(
                            children: [
                              Container(
                                width: ScreenUtil().screenWidth/4,
                                height: ScreenUtil().screenHeight/11.7,
                                margin: EdgeInsets.only(right: 8,left: 7),
                                decoration: BoxDecoration(
                                  color: whiteColor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: Colors.white60,),
                                  // boxShadow: [
                                  //   BoxShadow(
                                  //     color: Colors.grey,
                                  //     blurRadius: 2.0, // Soften the shaodw
                                  //     spreadRadius: 0.1,
                                  //     offset: Offset(0.0, 0.0),
                                  //   ),
                                  // ],
                                ),
                                child: Stack(
                                  children: [
                                    Align(
                                        alignment: Alignment.topCenter,
                                        child: Image.asset('assets/images/pr.png',scale: 6,)),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Container(
                                        width: double.infinity,
                                        height: 20.h,
                                        decoration: BoxDecoration(
                                          color: greenColor2,
                                          borderRadius: BorderRadius.only(
                                            bottomRight: Radius.circular(9),
                                            bottomLeft: Radius.circular(9),
                                          ),
                                          border: Border.all(color: Colors.white60),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 0, // Set the widget at the bottom of the Stack
                                        left: 20, // Set left to 0 for alignment
                                        right: 0, // Set right to 0 for alignment
                                        child: CustomText(title: "اردو ٹیکسٹ",color: whiteColor,)),
                                  ],
                                ),
                              ),
                              CustomText(title: "add text",color: grayColor,),
                            ],
                          ),
                        );
                      },
                      // This next line does the trick.
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
