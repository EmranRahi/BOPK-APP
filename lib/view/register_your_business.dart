import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/customs_widgets/open_hours_container.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'HomePage_ofBopk.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'menu_login.dart';
import 'mobile_shops.dart';

class RegisterYourBusiness extends StatefulWidget {
  const RegisterYourBusiness({super.key});

  @override
  State<RegisterYourBusiness> createState() => _RegisterYourBusinessState();
}

class _RegisterYourBusinessState extends State<RegisterYourBusiness> {
  List<String> items = [
    'Select report category',
    'Nudity',
    'Spam',
    'False news'
  ];
  final List<String> timeList = [
    '10:00AM',
    '11:00AM',
    '12:00PM',
    '1:00PM',
    '2:00PM',
    '3:00PM',
  ].toSet().toList(); // Remove duplicates and convert to a list


  String selectedValue = 'Select report category';
  List<String> businessCategories = [
    'Category 1',
    'Category 2',
    'Category 3',
    'Category 4',
    'Category 5',
  ];

  bool specialityOne = false;
  bool specialityTwo = false;
  bool specialityThree = false;
  // Close Speciality
  bool ownerNameOne = false;
  bool ownerNameTwo = false;
  bool ownerNameThree = false;
  //Close OwnerName
  bool contactNumOne = false;
  bool contactNumTwo = false;
  bool contactNumThree = false;
  //Close ContactNumber
  bool checkNumber = false; // Initial state of the checkbox
  bool checkTime = false; // Initial state of the checkbox

  // social media link
  bool socialMediaLink = false; // Initial state of the checkbox
  bool val = false; // Initial state of the checkbox
  bool val1 = false;
  bool val2 = false;
  bool val3 = false;
  bool val4 = false;
  bool val5 = false;
  bool val6 = false;

  String selectedCategory = 'Select business category';
  // List<Widget> textFields = [];

  // void removeLastTextField() {
  //   if (textFields.isNotEmpty) {
  //     setState(() {
  //       textFields.removeLast();
  //     });
  //     CustomTextFormFieldWidget(
  //       hint: "Speciality",
  //       borderRadius: 10,
  //       borderSide: BorderSide(width: 2),
  //     );
  //   }
  // }

  TextEditingController categoryController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    categoryController.text = selectedCategory;
  }

  List<Widget> socialMediaLinks = []; // List to store text fields
  int fieldCounter = 0;

  @override
  Widget build(BuildContext context) {
    String defaultValue = '10:00AM'; // Set your default value
    return Scaffold(
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
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                        onPressed: () {},
                        child: CustomText(
                          title: "How to Register business?",
                          color: blueColor,
                          decoration: TextDecoration.underline,
                        ))),
                Align(
                    alignment: Alignment.center,
                    child: CustomText(
                      title: "BASIC INFORMATION",
                      color: greenColor2,
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                    ),),
                SizedBox(height: 20.h),
                CustomText(
                    title: "Business title *", fontWeight: FontWeight.bold),
                CustomTextFormFieldWidget(
                  hint: 'Enter Your Business Title',
                  borderRadius: 10,
                  color: grayColor,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10.h),
                ),
                CustomText(
                    title: "Business Category *", fontWeight: FontWeight.bold),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black38, width: 1)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: categoryController,
                        readOnly: true,
                        onTap: () {
                          _showCategoryList(context);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                CustomText(
                    title: "Business title *", fontWeight: FontWeight.bold),
                CustomTextFormFieldWidget(
                  hint: "Description...",
                  maxLines: 3,
                  borderRadius: 10,
                  borderSide: BorderSide(width: 2),
                ),
                // Speciality field
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 9,
                      child: CustomText(
                        title: "Speciality *",
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        color: greenColor2,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Custom_Button_Widget(
                        ontap: () {
                          setState(() {
                            specialityOne = true;
                            specialityTwo = true;
                            specialityThree = true;
                          });
                        },
                        rd: 100,
                        width: 30.w,
                        height: 30.h,
                        color: greenColor2,
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),// this is code for specity text and add button
                CustomTextFormFieldWidget(
                  hint: "Speciality1",
                  borderRadius: 10,
                  borderSide: BorderSide(width: 2),
                ),// this is textfield by default show one
                Visibility(
                  visible: specialityOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Speciality1",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              specialityOne = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ), // this is the first speciality with remove icon if you want to create copy this and paste it
                Visibility(
                  visible: specialityTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Speciality1",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              specialityTwo = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),// this is the second speciality with rmove icon
                Visibility(
                  visible: specialityThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Speciality1",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              specialityThree = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),// this is the third speciality remove icon
                // Owner Name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 9,
                      child: CustomText(
                        title: "Owner Name *",
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        color: greenColor2,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Custom_Button_Widget(
                        ontap: () {
                          setState(() {
                            ownerNameOne = true;
                            ownerNameTwo = true;
                            ownerNameThree = true;
                          });
                        },
                        rd: 100,
                        width: 30.w,
                        height: 30.h,
                        color: greenColor2,
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ), // this is the owner name with plus icon
                CustomTextFormFieldWidget(
                  hint: "Owner name ",
                  borderRadius: 10,
                  borderSide: BorderSide(width: 2),
                ),
                Visibility(
                  visible: ownerNameOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Owner Name",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              ownerNameOne = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: ownerNameTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Owner Name",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              ownerNameTwo = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: ownerNameThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Owner Name",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              ownerNameThree = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                //Contact Number
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 9,
                      child: CustomText(
                        title: "Contact Number *",
                        fontWeight: FontWeight.bold,
                        fontSize: 17.sp,
                        color: greenColor2,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Custom_Button_Widget(
                        ontap: () {
                          setState(() {
                            contactNumOne = true;
                            contactNumTwo = true;
                            contactNumThree = true;
                          });
                        },
                        rd: 100,
                        width: 30.w,
                        height: 30.h,
                        color: greenColor2,
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ), // this is the Contact Number with plus icon
                CustomTextFormFieldWidget(
                  hint: "eg 0331,9838,546",
                  borderRadius: 10,
                  borderSide: BorderSide(width: 2),
                ),
                Visibility(
                  visible: contactNumOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Contact Number",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              contactNumOne = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: contactNumTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Contact Number",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              contactNumTwo = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: contactNumThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "Contact Number",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      Flexible(
                        flex: 1,
                        child: Custom_Button_Widget(
                          ontap: () {
                            setState(() {
                              contactNumThree = false;
                            });
                          },
                          rd: 100,
                          width: 30.w,
                          height: 30.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 30,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      value: checkNumber,
                      activeColor: greenColor2, // Replace with your desired color
                      onChanged: (value) {
                        setState(() {
                          checkNumber = value ?? false; // Update the state when the checkbox is toggled
                        });
                      },
                    ),
                    Text("Some number for WhatsApp"),
                  ],
                ),
                Visibility(
                  visible: checkNumber,
                  child: Row(
                    children:  const [
                      Expanded(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          hint: "whatsApp Number",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      // Expanded(
                      //   flex: 1,
                      //   child: IconButton(
                      //     onPressed: () {
                      //       setState(() {
                      //         checkNumber = false; // Hide the text field
                      //       });
                      //     },
                      //     icon: Icon(
                      //       Icons.remove,
                      //       size: 30,
                      //       color: Colors.green, // Replace with your desired color
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 9,
                      child: CustomText(
                        title: "Social Media Links",
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                        color: greenColor2, // Replace with your desired color
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Custom_Button_Widget(
                        width: 30,
                        height: 30,
                        color: greenColor2, // Replace with your desired color
                        ontap: (){
                          setState(() {
                             socialMediaLink = true;
                             // emailAdd = false;
                             // emailAdd = false;
                             // emailAdd = false;
                             // emailAdd = false;
                             // emailAdd = false;
                             // emailAdd = false;
                          });
                        },
                        rd: 100,
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white, // Replace with your desired color
                        ),
                      ),
                    ),

                  ],
                ),
                Visibility(
                  visible: socialMediaLink,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(title: "Email Address",fontWeight: FontWeight.bold,fontSize: 15.sp),
                          Row(
                            children: [
                              Flexible(
                                flex: 10,
                                child: CustomTextFormFieldWidget(
                                  hint: "Opetional",
                                  borderRadius: 10,
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(title: "Website Address",fontWeight: FontWeight.bold,fontSize: 15.sp),
                          Row(
                            children: [
                              Flexible(
                                flex: 10,
                                child: CustomTextFormFieldWidget(
                                  hint:  "Opetional",
                                  borderRadius: 10,
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(title: "IOS App Link",fontWeight: FontWeight.bold,fontSize: 15.sp),
                          Row(
                            children: [
                              Flexible(
                                flex: 10,
                                child: CustomTextFormFieldWidget(
                                  hint:  "Opetional",
                                  borderRadius: 10,
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(title: "Android App Link",fontWeight: FontWeight.bold,fontSize: 15.sp),
                          Row(
                            children: [
                              Flexible(
                                flex: 10,
                                child: CustomTextFormFieldWidget(
                                  hint: "Opetional",
                                  borderRadius: 10,
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(title: "Fax Number",fontWeight: FontWeight.bold,fontSize: 15.sp),
                          Row(
                            children: [
                              Flexible(
                                flex: 10,
                                child: CustomTextFormFieldWidget(
                                  hint: "Opetional",
                                  borderRadius: 10,
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(title: "FaceBook Link",fontWeight: FontWeight.bold,fontSize: 15.sp),
                          Row(
                            children: [
                              Flexible(
                                flex: 10,
                                child: CustomTextFormFieldWidget(
                                  hint:  "Opetional",
                                  borderRadius: 10,
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(title: "Twitter Link",fontWeight: FontWeight.bold,fontSize: 15.sp),
                          Row(
                            children: [
                              Flexible(
                                flex: 10,
                                child: CustomTextFormFieldWidget(
                                  hint:  "Opetional",
                                  borderRadius: 10,
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(title: "Instagram Link",fontWeight: FontWeight.bold,fontSize: 15.sp),
                          Row(
                            children: const [
                              Flexible(
                                flex: 10,
                                child: CustomTextFormFieldWidget(
                                  hint:  "Opetional",
                                  borderRadius: 10,
                                  borderSide: BorderSide(width: 2),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Divider(thickness: 2,color: greenColor2),
              CustomText(title: "OPENING HOURS",fontWeight: FontWeight.bold,fontSize: 20.sp,color: greenColor2),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
             Row(
               mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
               CustomText(title: "Set to All",fontWeight: FontWeight.bold,fontSize: 20.sp,color: greenColor2),
               CustomText(title: "Set to All",fontWeight: FontWeight.bold,fontSize: 20.sp,color: greenColor2),
             ],),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                OpenHoursContainer(customCheckbox: Checkbox(
                  onChanged: (value){
                    setState(() {
                      val = value!;
                    });
                  },
                  value: val,
                  activeColor: greenColor2,
                ), child: CustomText(title: "Monday")),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                SingleChildScrollView(
                child: DropdownButton<String>(
                  value: defaultValue,
                  items: timeList.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    // Handle the selected value here
                    print('Selected value: $value');
                  },
                ),
    ),
                SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                ],),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                 OpenHoursContainer(
                   customCheckbox: Checkbox(
                     onChanged: (value){
                       setState(() {
                         val1 = value ?? false;
                       });
                     },
                     value: val1,
                     activeColor: greenColor2,
                   ),child: CustomText(title: "Tuesday"),),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                  ],),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                 OpenHoursContainer(
                   customCheckbox: Checkbox(
                     onChanged: (value){
                       setState(() {
                         val2 = value!;
                       });
                     },
                     value: val2,
                     activeColor: greenColor2,
                   ), child: CustomText(title: "Wednesday"),),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                  ],),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                 OpenHoursContainer(
                   customCheckbox: Checkbox(
                     onChanged: (value){
                       setState(() {
                         val3 = value!;
                       });
                     },
                     value: val3,
                     activeColor: greenColor2,
                   ), child: CustomText(title: "Thursday"),),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                  ],),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                 OpenHoursContainer(
                   customCheckbox: Checkbox(
                     onChanged: (value){
                       setState(() {
                         val4 = value!;
                       });
                     },
                     value: val4,
                     activeColor: greenColor2,
                   ), child: CustomText(title: "Friday"),),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                  ],),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                 OpenHoursContainer(
                   customCheckbox: Checkbox(
                     onChanged: (value){
                       setState(() {
                         val5 = value!;
                       });
                     },
                     value: val5,
                     activeColor: greenColor2,
                   ), child: CustomText(title: "Saturday"),),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                  ],),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                 OpenHoursContainer(
                   customCheckbox: Checkbox(
                     onChanged: (value){
                       setState(() {
                         val6 = value!;
                       });
                     },
                     value: val6,
                     activeColor: greenColor2,
                   ), child: CustomText(title: "Sunday"),),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                    SingleChildScrollView(
                      child: DropdownButton<String>(
                        value: defaultValue,
                        items: timeList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (String? value) {
                          // Handle the selected value here
                          print('Selected value: $value');
                        },
                      ),
                    ),
                  ],),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                Divider(thickness: 2,color: greenColor2),
                Text("Add More Code"),
                CustomText(title: "LOCATION",fontWeight: FontWeight.bold,fontSize: 20.sp,color: greenColor2),
                SizedBox(height: ScreenUtil().setHeight(20.h),),
                CustomText(title: "Area Name*",fontWeight: FontWeight.bold,fontSize: 14.sp,),
                CustomTextFormFieldWidget(hint: "Search Location",borderRadius: 10),
                Image.asset('assets/images/map.jpg'),
                SizedBox(height: ScreenUtil().setHeight(10.h),),
                CustomText(title: "Address...",fontWeight: FontWeight.bold,fontSize: 14.sp,),
                CustomTextFormFieldWidget(hint: "Search Location",borderRadius: 10),

                Divider(color: greenColor2,thickness: 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  CustomText(title: "GALLERY",fontWeight: FontWeight.bold,fontSize: 20.sp,color: greenColor2),
                  TextButton(onPressed: (){}, child: CustomText(title: "Select Gallery Picture",fontWeight: FontWeight.bold,decoration: TextDecoration.underline),),
                ],),
                SizedBox(height: ScreenUtil().setHeight(100.h),),
                Align(
                  alignment: Alignment.center,
                    child: Custom_Button_Widget(ontap: (){}, rd: 10,color: greenColor2,width: ScreenUtil().screenWidth/2, child: CustomText(title: "Register My Business",fontWeight: FontWeight.bold,color: whiteColor)),),
                SizedBox(height: ScreenUtil().setHeight(30.h),),
              ],
            ),
          )
        ],
      ),
    );
  }
 
  void _showCategoryList(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Select a Business Category"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      labelText: "Search Category",
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (text) {
                      setState(() {
                        // Filter the categories based on the search text
                        businessCategories = businessCategories
                            .where((category) => category
                                .toLowerCase()
                                .contains(text.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      children: businessCategories.map((category) {
                        return ListTile(
                          title: Text(category),
                          onTap: () {
                            setState(() {
                              selectedCategory = category;
                              categoryController.text = selectedCategory;
                            });
                            Navigator.of(context).pop();
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
