import 'package:businessonlinepk/view/HomePage_ofBopk.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_popupofmenu.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/deal_and_discount_screen.dart';
import 'package:businessonlinepk/view/get_discount_card_screeen.dart';
import 'package:businessonlinepk/view/get_your_business_now.dart';
import 'package:businessonlinepk/view/inside_mobile_shops.dart';
import 'package:businessonlinepk/view/main_page_bopk.dart';
import 'package:businessonlinepk/view/menu_login.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'add_jobs.dart';
import 'business_for_sale.dart';

class MobileShops extends StatefulWidget {
  const MobileShops({super.key});

  @override
  State<MobileShops> createState() => _MobileShopsState();
}

class _MobileShopsState extends State<MobileShops> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: Drawer(
      //     child: ListView(
      //         children: <Widget>[
      //           ListTile(
      //             leading: Icon(Icons.shopping_cart),
      //             title: Text('Checkout'),
      //             onTap: (){
      //               Navigator.pushNamed(context, '/home');
      //             },
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.report),
      //             title: Text('Transactions'),
      //             onTap: (){
      //               Navigator.pushNamed(context, '/transactionsList');
      //             },
      //           ),
      //         ]
      //     )
      // ),
      appBar: customAppBar1(
        centerTitle: false,
        title: CustomText(
          title: 'Mobile Shops',
          color: grayColor,
        ),
        leading: Icon(
          Icons.arrow_back,
          color: tealColor,
          size: 30,
        ),
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
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
      key: _drawerscaffoldkey, //set gobal key defined above
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: tealColor, // Status bar color
          statusBarIconBrightness: Brightness.light, // Status bar text color
          systemNavigationBarColor: blackColor, // Navigation bar color
          systemNavigationBarIconBrightness:
              Brightness.light, // Navigation bar text color
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              CustomTextFormFieldWidget(
                borderRadius: 10,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                prefixIcon: Icon(Icons.search),
                hint: "Search Your Business",
              ),
              Custom_Button_Widget(
                width: MediaQuery.of(context).size.width / 1.0,
                ontap: () {},
                rd: 10,
                color: greenColor2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                      title: "Do You Find Your Business? No?",
                      color: whiteColor,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                    CustomText(
                      title: "Register It Now",
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
              ),

              /// add My More Code in this Place
              Align(
                alignment: Alignment.topRight,
                child: PopupMenuButton<String>(
                  elevation: 0,
                  onSelected: (String choice) {
                    // Handle menu item selection here
                    print("Selected: $choice");
                  },
                  // icon: Icon(
                  //   Icons.menu, // Change the icon here
                  //   color: tealColor, // You can customize the icon's color
                  // ),

                  itemBuilder: (BuildContext context) {
                    return <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: '1',
                        child: CustomText(
                            title: 'Search by popularity', color: grayColor),
                      ),
                      PopupMenuItem<String>(
                        value: '2',
                        child: CustomText(
                            title: 'Show Open Shops', color: grayColor),
                      ),
                      PopupMenuItem<String>(
                        value: '3',
                        child: CustomText(
                            title: 'Show Close Shops', color: grayColor),
                      ),
                    ];
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, right: 10),
                    child: CustomText(
                      title: "Filter",
                      color: tealColor,
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: 200,
                            margin: EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                // color: Colors.blue,
                                border: Border.all(color: grayColor),
                                borderRadius: BorderRadius.circular(12)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    InkWell(
                                      onTap:(){
                                        Navigator.push(context, MaterialPageRoute(builder: (context) => InsideMobileShops()));
                                      },
                                      child: Image.asset('assets/images/bopk.png',
                                          scale: 1.4),
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 10),
                                      child: Row(
                                        children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                title: "Mobile Shop (Rs 5000)",
                                                color: tealColor,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      50),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on,
                                                    color: tealColor,
                                                  ),
                                                  SizedBox(
                                                      width: ScreenUtil()
                                                              .screenWidth /
                                                          40),
                                                  CustomText(
                                                    title: "0.01 KM away",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: grayColor,
                                                  )
                                                ],
                                              ),
                                              SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height /
                                                      70),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.access_time_rounded,
                                                    color: tealColor,
                                                  ),
                                                  SizedBox(
                                                      width: ScreenUtil()
                                                              .screenWidth /
                                                          40),
                                                  CustomText(
                                                    title: "Open Now",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 12,
                                                    color: grayColor,
                                                  )
                                                ],
                                              ),
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                  vertical: 10,
                                                ),
                                                child: Row(
                                                  children: [
                                                    CustomContainer(
                                                      height: 30,
                                                      width: 30,
                                                      ontap: () {},
                                                      rd: 100,
                                                      color: whiteColor,
                                                      boxShadow: true,
                                                      child: Image.asset(
                                                          'assets/images/navigation.png'),
                                                    ),
                                                    SizedBox(width: 5.w),
                                                    CustomContainer(
                                                        height: 30,
                                                        width: 30,
                                                        ontap: () {},
                                                        rd: 100,
                                                        color: whiteColor,
                                                        boxShadow: true,
                                                        child: Image.asset(
                                                            'assets/images/call.png')),
                                                    SizedBox(width: 5.w),
                                                    CustomContainer(
                                                        height: 30,
                                                        width: 30,
                                                        ontap: () {},
                                                        rd: 100,
                                                        color: whiteColor,
                                                        boxShadow: true,
                                                        child: Image.asset(
                                                            'assets/images/whtsapp.png')),
                                                    SizedBox(width: 5.w),
                                                    CustomContainer(
                                                        height: 30,
                                                        width: 30,
                                                        ontap: () {},
                                                        rd: 100,
                                                        color: whiteColor,
                                                        boxShadow: true,
                                                        child: Image.asset(
                                                            'assets/images/sms.png')),
                                                    SizedBox(width: 5.w),
                                                    CustomContainer(
                                                      height: 30,
                                                      width: 30,
                                                      ontap: () {},
                                                      rd: 100,
                                                      color: whiteColor,
                                                      boxShadow: true,
                                                      child: Image.asset(
                                                          'assets/images/share.png'),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 7.w, vertical: 5.h),
                                  child: Row(
                                    children: [
                                      Custom_Button_Widget(
                                        ontap: () {},
                                        rd: 7.r,
                                        height: 20.h,
                                        width: 70.w,
                                        color: whiteColor,
                                        boxShadow: true,
                                        child: CustomText(
                                          title: "Iphone",
                                          color: grayColor,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                20,
                                      ),
                                      Custom_Button_Widget(
                                        ontap: () {
                                          print("Click me Samsung");
                                        },
                                        rd: 7.r,
                                        height: 20.h,
                                        width: 70.h,
                                        color: whiteColor,
                                        boxShadow: true,
                                        child: CustomText(
                                          title: "Samsung",
                                          color: grayColor,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 10,
              )

              /// Add more Code
            ],
          ),
        ),
      ),
    );
  }
}
