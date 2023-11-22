import 'package:businessonlinepk/test_dialouge.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_popupofmenu.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/product_deatils_screen/product_details.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:group_button/group_button.dart';

import 'HomePage_ofBopk.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'main_page_bopk.dart';
import 'menu_login.dart';
import 'mobile_shops.dart';

class InsideMobileShops extends StatefulWidget {
  const InsideMobileShops({super.key});
  @override
  State<InsideMobileShops> createState() => _InsideMobileShopsState();
}

class _InsideMobileShopsState extends State<InsideMobileShops> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> checkboxValues =
      List.generate(30, (index) => false); // 30 checkboxess
  List<String> items = [
    'Select report category',
    'Nudity',
    'Spam',
    'False news'
  ];
  String selectedValue = 'Select report category';

  void _showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          title: CustomText(
              title: "Report Business",
              fontSize: 20,
              color: greenColor2,
              fontWeight: FontWeight.bold),
          content: SingleChildScrollView(
            child: Container(
              height: ScreenUtil().screenHeight / 2.6,
              child: ListView(
                children: [
                  CustomText(
                    title: "MOBILE SHOP (RS 5000)",
                    color: grayColor,
                    fontWeight: FontWeight.bold,
                  ),
                  SizedBox(height: 20),
                  DropdownButton<String>(
                    elevation: 0,
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Text(item),
                      );
                    }).toList(),
                    value: selectedValue,
                    onChanged: (value) {
                      selectedValue = value!;
                    },
                  ),
                  SizedBox(height: 20.h),
                  CustomText(
                    title: "Your review here:",
                    color: grayColor,
                    fontWeight: FontWeight.bold,
                  ),
                  CustomTextFormFieldWidget(
                      maxLines: 3,
                      borderRadius: 10,
                      color: greenColor2), // Adjust maxLines as needed
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Custom_Button_Widget(
                        ontap: () {
                          Navigator.pop(context);
                          print("Click Cancel");
                        },
                        rd: 4.r,
                        height: 30.h,
                        width: 70.h,
                        color: greenColor,
                        child: CustomText(
                          title: "Cancel",
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Custom_Button_Widget(
                        ontap: () {
                          print("Click report");
                        },
                        rd: 4.r,
                        height: 30.h,
                        width: 70.h,
                        color: greenColor,
                        child: CustomText(
                          title: "Report",
                          color: whiteColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    print('work');
    return Scaffold(
      key: _scaffoldKey,
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
              icon: Icon(Icons.menu, color: greenColor2, size: 30),
              color: whiteColor,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<int>>[
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MenuLogin()));
                    },
                    value: 0,
                    child: CustomText(
                        title: "Login ", fontStyle: FontStyle.italic),
                  ),
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
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePage()));
                    },
                    value: 2,
                    child: CustomText(
                        title: "BOPK Home", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyDownLoadScreen()));
                    },
                    value: 3,
                    child: CustomText(
                        title: "Verify Download", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PayNowScreen()));
                    },
                    value: 4,
                    child: CustomText(
                        title: "Pay Now", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetDisCountCard()));
                    },
                    value: 5,
                    child: CustomText(
                        title: "Get Discount Card",
                        fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => GetYourBusinessNow()));
                    },
                    value: 6,
                    child: CustomText(
                        title: "Get Your Business Verify Now",
                        fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DealAndDisCount()));
                    },
                    value: 7,
                    child: CustomText(
                        title: "Deal And Discount ",
                        fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MobileShops()));
                    },
                    value: 8,
                    child: CustomText(
                        title: "Mobile Shops", fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => BusinessForSale()));
                    },
                    value: 10,
                    child: CustomText(
                        title: "Business For Sale",
                        fontStyle: FontStyle.italic),
                  ),
                  PopupMenuDivider(),
                  PopupMenuItem<int>(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AddJobs()));
                    },
                    value: 8,
                    child: CustomText(
                        title: "Add Jobs", fontStyle: FontStyle.italic),
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
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: tealColor, // Status bar color
          statusBarIconBrightness: Brightness.light, // Status bar text color
          systemNavigationBarColor: blackColor, // Navigation bar color
          systemNavigationBarIconBrightness:
              Brightness.light, // Navigation bar text color
        ),
        child: ListView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            scrollDirection: Axis.vertical,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Custom_Button_Widget(
                        width: MediaQuery.of(context).size.width / 1.0,
                        ontap: () {},
                        rd: 7,
                        color: greenColor2,
                        child: CustomText(
                          title: "Login to Manage the business",
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Stack(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height / 3,
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Image.asset(
                                'assets/images/map.jpg',
                              ),
                            ),
                          ),
                          // Map Image
                          // Image.asset('assets/images/map.jpg',width: double.infinity,fit: BoxFit.fitWidth,),
                          Positioned(
                            bottom: 5,
                            left: 60.w,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {},
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child: Image.asset(
                                      'assets/images/navigation.png'),
                                ),
                                SizedBox(width: 5.w),
                                CustomContainer(
                                    height: 40,
                                    width: 40,
                                    ontap: () {},
                                    rd: 100,
                                    color: whiteColor,
                                    boxShadow: true,
                                    child:
                                        Image.asset('assets/images/call.png')),
                                SizedBox(width: 5.w),
                                CustomContainer(
                                    height: 40,
                                    width: 40,
                                    ontap: () {},
                                    rd: 100,
                                    color: whiteColor,
                                    boxShadow: true,
                                    child:
                                        Image.asset('assets/images/sms.png')),
                                SizedBox(width: 5.w),
                                CustomContainer(
                                    height: 40,
                                    width: 40,
                                    ontap: () {},
                                    rd: 100,
                                    color: whiteColor,
                                    boxShadow: true,
                                    child: Image.asset(
                                        'assets/images/whtsapp.png')),
                                SizedBox(width: 5.w),
                                CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {},
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child: Image.asset('assets/images/share.png'),
                                ),
                              ],
                            ),
                          ),
                          // Positioned widget at the bottom
                        ],
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          CustomContainer(
                            height: 50.h,
                            width: 50,
                            ontap: () {},
                            rd: 100,
                            color: Colors.transparent,
                            // boxShadow: true,
                            child: Image.asset('assets/media/gallery1.png',
                                scale: 3),
                          ),
                          CustomContainer(
                            height: 50,
                            width: 50,
                            ontap: () {},
                            rd: 100,
                            color: Colors.transparent,
                            // boxShadow: true,
                            child: Image.asset('assets/media/mesage.png',
                                scale: 2),
                          ),
                          CustomContainer(
                            height: 50,
                            width: 50,
                            ontap: () {},
                            rd: 100,
                            color: Colors.transparent,
                            // boxShadow: true,
                            child: Image.asset('assets/media/share1.png',
                                scale: 2),
                          ),
                          CustomContainer(
                            height: 50,
                            width: 50,
                            ontap: () {},
                            rd: 100,
                            color: Colors.transparent,
                            // boxShadow: true,
                            child: Image.asset(
                              'assets/media/facebook.png',
                            ),
                          ),
                          CustomContainer(
                            height: 50,
                            width: 50,
                            ontap: () {},
                            rd: 100,
                            color: Colors.transparent,
                            // boxShadow: true,
                            child: Image.asset('assets/media/youtub.png',
                                scale: 2.1),
                          ),
                          CustomContainer(
                            height: 50,
                            width: 50,
                            ontap: () {},
                            rd: 100,
                            color: Colors.transparent,
                            // boxShadow: true,
                            child: Image.asset('assets/media/twitte.png',
                                scale: 3),
                          ),
                          CustomContainer(
                            height: 50,
                            width: 50,
                            ontap: () {},
                            rd: 100,
                            color: Colors.transparent,
                            // boxShadow: true,
                            child: Image.asset('assets/media/insta.png',
                                scale: 2.1),
                          ),
                          CustomContainer(
                            height: 50,
                            width: 50,
                            ontap: () {},
                            rd: 100,
                            color: Colors.transparent,
                            // boxShadow: true,
                            child: Image.asset('assets/media/linke.png',
                                scale: 3.1),
                          ),
                        ]),
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                  title: "+92 333,786,830,8", color: grayColor),
                              SizedBox(height: 20),
                              CustomText(
                                  title: "MOBILE SHOP (RS 5000)",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp),
                              SizedBox(
                                height: 6,
                              ),
                              CustomText(
                                title: "Imran Khan",
                                fontWeight: FontWeight.bold,
                                fontSize: 14.sp,
                              ),
                              SizedBox(height: 20),
                              CustomText(
                                title:
                                    "Satellite Town, Rawalpindi,Punjab,Pakistan",
                                fontSize: 14.sp,
                                color: grayColor,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200.h,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            // color: Colors.blue,
                            border: Border.all(color: grayColor2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "OVERVIEW",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: greenColor2,
                              ),
                              Divider(
                                color: greenColor2,
                                thickness: 2,
                                indent: 1,
                                endIndent: 250,
                              ),
                              CustomText(
                                title: 'we deal in Samsung and Iphone Only',
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              CustomText(
                                title: "SPECIALITIES",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: greenColor2,
                              ),
                              Divider(
                                color: greenColor2,
                                thickness: 2,
                                indent: 1,
                                endIndent: 250,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Row(
                                      children: [
                                        Checkbox(
                                          value: checkboxValues[index],
                                          activeColor: greenColor,
                                          onChanged: (bool? newValue) {
                                            setState(() {
                                              checkboxValues[index] = newValue!;
                                            });
                                          },
                                        ),
                                        CustomText(
                                          title: "IPhone",
                                          color: grayColor,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: 200.h,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            // color: Colors.blue,
                            border: Border.all(color: grayColor2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, bottom: 10, right: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "PRODUCT",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: greenColor2,
                              ),
                              Divider(
                                color: greenColor2,
                                thickness: 2,
                                indent: 1,
                                endIndent: 250,
                              ),
                              Expanded(
                                child: GridView.builder(
                                    gridDelegate:
                                        SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 16,
                                      crossAxisCount: 2, // Number of columns
                                    ),
                                    itemCount: 9, // Number of items in the grid
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductScreen()));
                                          print('GridView');
                                        },
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: whiteColor,
                                              borderRadius:
                                                  BorderRadius.circular(10.r),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: grayColor2,
                                                  blurRadius: 1.r,
                                                  spreadRadius: 1.r,
                                                  offset: Offset(0, 4),
                                                )
                                              ]),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Center(
                                                  child: Image.asset(
                                                      'assets/images/iphone.jpg',
                                                      scale: 8)),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              CustomText(
                                                title: 'Iphone',
                                                color: grayColor,
                                              ),
                                              SizedBox(
                                                height: 2,
                                              ),
                                              CustomText(
                                                title: 'Rs.80000',
                                                color: tealColor1,
                                                fontWeight: FontWeight.bold,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceAround,
                                                children: [
                                                  Custom_Button_Widget(
                                                    ontap: () {
                                                      print("Click whatsApp");
                                                    },
                                                    rd: 4.r,
                                                    height: 20.h,
                                                    width: 50.h,
                                                    color: greenColor,
                                                    child: CustomText(
                                                      title: "whatsApp",
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  // SizedBox(
                                                  //   width: 30.w,
                                                  // ),
                                                  Custom_Button_Widget(
                                                    ontap: () {
                                                      print("Click Call");
                                                    },
                                                    rd: 4.r,
                                                    height: 20.h,
                                                    width: 50.h,
                                                    color: greenColor,
                                                    child: CustomText(
                                                      title: "Call",
                                                      color: whiteColor,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        // height: ScreenUtil().screenHeight / 2.4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            // color: Colors.blue,
                            border: Border.all(color: grayColor2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, bottom: 10, right: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "GALLERY",
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                color: greenColor2,
                              ),
                              Divider(
                                color: greenColor2,
                                thickness: 2,
                                indent: 1,
                                endIndent: 250,
                              ),
                              Image.asset('assets/images/gallery.jpg',
                                  fit: BoxFit.cover),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        // height: ScreenUtil().screenHeight / 2.4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            // color: Colors.blue,
                            border: Border.all(color: grayColor2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, bottom: 10, right: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: greenColor2,
                                    size: 30,
                                  ),
                                  SizedBox(width: 20),
                                  CustomText(
                                    title: "OPENING HOURS",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: tealColor1,
                                  ),
                                ],
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                child: DataTable(
                                  columnSpacing: 40,
                                  columns: const [
                                    DataColumn(label: Text('Day')),
                                    DataColumn(label: Text('12:00AM')),
                                    DataColumn(label: Text('12:00PM')),
                                  ],
                                  rows: const [
                                    DataRow(
                                      selected: true,
                                      cells: <DataCell>[
                                        DataCell(Text('Monday')),
                                        DataCell(Text('10:00AM')),
                                        DataCell(Text('10:00PM')),
                                      ],
                                    ),
                                    DataRow(
                                      selected: true,
                                      cells: <DataCell>[
                                        DataCell(Text('Tuesday')),
                                        DataCell(Text('10:00AM')),
                                        DataCell(Text('10:00PM')),
                                      ],
                                    ),
                                    DataRow(
                                      selected: true,
                                      cells: <DataCell>[
                                        DataCell(
                                          Text('Wednesday'),
                                        ),
                                        DataCell(
                                          Text('10:00AM'),
                                        ),
                                        DataCell(
                                          Text('10:00PM'),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      selected: true,
                                      cells: <DataCell>[
                                        DataCell(
                                          Text('Thursday'),
                                        ),
                                        DataCell(
                                          Text('10:00AM'),
                                        ),
                                        DataCell(
                                          Text('10:00PM'),
                                        ),
                                      ],
                                    ),
                                    DataRow(
                                      selected: true,
                                      cells: <DataCell>[
                                        DataCell(Text('Friday')),
                                        DataCell(Text('10:00AM')),
                                        DataCell(Text('10:00PM')),
                                      ],
                                    ),
                                    DataRow(
                                      selected: true,
                                      cells: <DataCell>[
                                        DataCell(Text('Saturday')),
                                        DataCell(Text('10:00AM')),
                                        DataCell(Text('10:00PM')),
                                      ],
                                    ),
                                    DataRow(
                                      selected: true,
                                      cells: <DataCell>[
                                        DataCell(Text('Sunday')),
                                        DataCell(Text('10:00AM')),
                                        DataCell(Text('10:00PM')),
                                      ],
                                    ),

                                    // Add more rows as needed
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        height: ScreenUtil().screenHeight / 2.4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                            // color: Colors.blue,
                            border: Border.all(color: grayColor2),
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, bottom: 10, right: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "USER REVIEWS",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: greenColor2,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: 10,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        Container(
                                          alignment: Alignment.center,
                                          height:
                                              ScreenUtil().screenHeight / 8.0,
                                          margin:
                                              EdgeInsets.symmetric(vertical: 8),
                                          decoration: BoxDecoration(
                                            // color: Colors.blue,
                                            border:
                                                Border.all(color: grayColor2),
                                            // borderRadius: BorderRadius.circular(12)
                                          ),
                                          child: ListTile(
                                            title: CustomText(title: "test"),
                                            subtitle: CustomText(
                                              title: "waw3wo3eo",
                                            ),
                                            trailing: CustomText(
                                                title:
                                                    "2023-10-10T15:56:40:55"),
                                          ),
                                        )
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        // height: ScreenUtil().screenHeight / 2.4,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          // color: Colors.blue,
                          border: Border.all(color: grayColor2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.only(
                              top: 10.h, left: 10.w, bottom: 10, right: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                title: "ADD REVIEWS",
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: greenColor2,
                              ),
                              Divider(
                                color: greenColor2,
                                thickness: 2,
                                indent: 1,
                                endIndent: 200,
                              ),
                              CustomText(
                                title: "Your Ratting For this Business",
                                color: grayColor,
                                fontWeight: FontWeight.bold,
                                fontStyle: FontStyle.italic,
                              ),
                              RatingBar.builder(
                                itemSize: 50,
                                initialRating: 0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 6.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: greenColor2,
                                ),
                                onRatingUpdate: (rating) {
                                  print(rating);
                                },
                              ),
                              CustomTextFormFieldWidget(
                                hint: "User Name",
                                borderRadius: 10,
                              ),
                              CustomTextFormFieldWidget(
                                hint: "Email",
                                borderRadius: 10,
                              ),
                              CustomTextFormFieldWidget(
                                hint: "Description...",
                                maxLines: 5,
                                borderRadius: 10,
                              ),
                              Custom_Button_Widget(
                                ontap: () {},
                                rd: 10,
                                color: greenColor2,
                                child: CustomText(
                                  title: "Submit Review",
                                  color: whiteColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Custom_Button_Widget(
                        ontap: () {
                          _showAlertDialog(
                              context); // Call the function to show the alert dialog
                          print('Report');
                        },
                        rd: 10,
                        width: ScreenUtil().screenWidth / 2.2,
                        color: whiteColor,
                        border: Border.all(color: greenColor2, width: 2),
                        child: CustomText(
                          title: "Report this business",
                          color: yaleBlueColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ]),
      ),
    );
  }
}
