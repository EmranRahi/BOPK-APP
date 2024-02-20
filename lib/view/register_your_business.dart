import 'dart:convert';
import 'dart:io';
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
import 'package:image_picker/image_picker.dart';
import '../Controllers/Api_Controller.dart';
import '../model/RegisterYourBusinessModel.dart';
import 'HomePage_ofBopk.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'menu_login.dart';
import 'mobile_shops.dart';
import 'package:image_picker/image_picker.dart';

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

  void updateAllCheckboxes(bool value) {
    setState(() {
      val = value;
      val1 = value;
      val2 = value;
      val3 = value;
      val4 = value;
      val5 = value;
      val6 = value;
    });
  }

  TextEditingController categoryController = TextEditingController();

  // TextEditingController titleController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  /// SpecialityController
  // TextEditingController specialityController1 = TextEditingController();
  // TextEditingController specialityController2 = TextEditingController();
  // TextEditingController specialityController3 = TextEditingController();
  // TextEditingController specialityController4 = TextEditingController();
  /// ownerNameController
  // TextEditingController ownerNameController1 = TextEditingController();
  // TextEditingController ownerNameController2 = TextEditingController();
  // TextEditingController ownerNameController3 = TextEditingController();
  // TextEditingController ownerNameController4 = TextEditingController();
  /// ContactNumber Controller
  // TextEditingController contactNumController1 = TextEditingController();
  // TextEditingController contactNumController2 = TextEditingController();
  // TextEditingController contactNumController3 = TextEditingController();
  // TextEditingController contactNumController4 = TextEditingController();
  /// Other Field Controller
  // TextEditingController whatsAppController = TextEditingController();
  TextEditingController searchController = TextEditingController();

  /// Social Media Controller
  // TextEditingController emailController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController emailController = TextEditingController();
  // TextEditingController emailController = TextEditingController();

  RegisterYourBusinessModel registerYourBusinessModel =
      RegisterYourBusinessModel();

  @override
  void initState() {
    super.initState();
    categoryController.text = selectedCategory;
  }

  List<Widget> socialMediaLinks = []; // List to store text fields
  int fieldCounter = 0;

  late File imageFile = File('path/to/default/image.png');
  ImagePicker imagePicker = ImagePicker();

  _openGallery(BuildContext context) async {
    var picture = await imagePicker.pickImage(source: ImageSource.gallery);
    if (picture != null) {
      setState(() {
        imageFile = File(picture.path); // Convert XFile to File
      });
    }
    Navigator.pop(context);
  }

  _openCamera(BuildContext context) async {
    var picture = await imagePicker.pickImage(source: ImageSource.camera);
    if (picture != null) {
      setState(() {
        imageFile = File(picture.path); // Convert XFile to File
      });
    }
    Navigator.pop(context);
  }

  Future<void> _showChoiceDialoge(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(title: "Make a Choice!"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  onTap: () {
                    _openGallery(context);
                  },
                  child: CustomText(title: "Gallery"),
                ),
                Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  onTap: () {
                    _openCamera(context);
                  },
                  child: CustomText(title: "Camera"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Widget to display the image
  Widget decidedImageView() {
    return Container(
      height: 250,
      child: FutureBuilder<bool>(
        future: imageFile.exists(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!) {
            // If the file exists, display the image
            return Image.file(
              imageFile,
              width: 400,
              fit: BoxFit.fill,
              scale: 13,
            );
          } else {
            // If the file does not exist, display a placeholder image or message
            return Center(child: CustomText(title: "No Image Selected"));
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    String defaultValue = '10:00AM'; // Set your default value
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar1(
        elevation: 0,
        centerTitle: false,
        title: CustomText(
          title: 'Mobile Shops',
          color: greenColor2,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: greenColor2,
            size: 30,
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
                      // Navigator.push(context, MaterialPageRoute(builder: (context)=> MobileShops()));
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
      body: ListView(
        padding: EdgeInsets.all(0.5),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
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
                          color: greenColor2,
                          decoration: TextDecoration.underline,
                        ))),
                Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    title: "BASIC INFORMATION",
                    color: greenColor2,
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
                ),
                SizedBox(height: 10.h),
                CustomText(
                    title: "Business title *", fontWeight: FontWeight.bold),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                CustomTextFormFieldWidget(
                  // controller: titleController,
                  onChanged: (val) {
                    // titleController.text=val;
                    registerYourBusinessModel.title = val;
                  },
                  hint: 'Enter Your Business Title',
                  borderRadius: 10,
                  color: grayColor,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                CustomText(
                    title: "Business Category *", fontWeight: FontWeight.bold),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                TextField(
                  controller: categoryController,
                  style: TextStyle(color: grayColor),
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide(),
                          borderRadius: BorderRadius.circular(10))),
                  readOnly: true,
                  onTap: () {
                    _showCategoryList(context);
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                CustomText(title: "Description *", fontWeight: FontWeight.bold),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                CustomTextFormFieldWidget(
                  onChanged: (val) {
                    registerYourBusinessModel.description = val;
                  },
                  hint: "Description...",
                  maxLines: 2,
                  borderRadius: 10,
                  borderSide: BorderSide(width: 2),
                ),
                // Speciality field
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
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
                            if (specialityOne == false) {
                              specialityOne = true;
                            } else if (specialityTwo == false) {
                              specialityTwo = true;
                            } else if (specialityThree == false) {
                              specialityThree = true;
                            }
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
                ),
                // this is code for specity text and add button
                SizedBox(height: ScreenUtil().setHeight(6.h)),
                CustomTextFormFieldWidget(
                  onChanged: (val) {
                    registerYourBusinessModel.speciality = val;
                  },
                  hint: "Speciality1",
                  borderRadius: 10,
                  borderSide: BorderSide(width: 2),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5.h),
                ),
                Visibility(
                  visible: specialityOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.speciality = val;
                          },
                          hint: "Speciality2",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(6.h)),
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
                ),
                // this is the first speciality with remove icon if you want to create copy this and paste it
                SizedBox(height: ScreenUtil().setHeight(6.h)),
                Visibility(
                  visible: specialityTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.speciality = val;
                          },
                          hint: "Speciality3",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(6.h)),
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
                ),
                // this is the second speciality with rmove icon
                SizedBox(height: ScreenUtil().setHeight(6.h)),
                Visibility(
                  visible: specialityThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          // controller: specialityController4,
                          onChanged: (val) {
                            // specialityController4.text=val;
                            registerYourBusinessModel.speciality = val;
                          },
                          hint: "Speciality4",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(6.h)),
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
                ),
                // this is the third speciality remove icon
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
                            if (ownerNameOne == false) {
                              ownerNameOne = true;
                            } else if (ownerNameTwo == false) {
                              ownerNameTwo = true;
                            } else if (ownerNameThree == false) {
                              ownerNameThree = true;
                            }
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
                ),
                // this is the owner name with plus icon
                SizedBox(height: ScreenUtil().setHeight(4.h)),
                CustomTextFormFieldWidget(
                  // controller: ownerNameController1,
                  onChanged: (val) {
                    // ownerNameController1.text=val;
                  },
                  hint: "Owner name1 ",
                  borderRadius: 10,
                  borderSide: BorderSide(width: 2),
                ),
                SizedBox(height: ScreenUtil().setHeight(4.h)),
                Visibility(
                  visible: ownerNameOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          // controller: ownerNameController2,
                          onChanged: (val) {
                            // ownerNameController2.text=val;
                          },
                          hint: "Owner Name2",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(4.h)),
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
                SizedBox(height: ScreenUtil().setHeight(4.h)),
                Visibility(
                  visible: ownerNameTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          // controller: ownerNameController3,
                          onChanged: (val) {
                            // ownerNameController3.text=val;
                          },
                          hint: "Owner Name",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(4.h)),
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
                SizedBox(height: ScreenUtil().setHeight(4.h)),
                Visibility(
                  visible: ownerNameThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          // controller: ownerNameController4,
                          onChanged: (val) {
                            // ownerNameController4.text=val;
                          },
                          hint: "Owner Name",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(width: ScreenUtil().setWidth(4.h)),
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
                            if (contactNumOne == false) {
                              contactNumOne = true;
                            } else if (contactNumTwo == false) {
                              contactNumTwo = true;
                            } else if (contactNumThree == false) {
                              contactNumThree = true;
                            }
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
                ),
                // this is the Contact Number with plus icon
                SizedBox(
                  height: ScreenUtil().setHeight(5.h),
                ),
                CustomTextFormFieldWidget(
                  // controller: contactNumController1,
                  onChanged: (val) {
                    // contactNumController1.text=val;
                    registerYourBusinessModel.contactPhone = val;
                  },
                  hint: "eg 0331,9838,546",
                  borderRadius: 10,
                  borderSide: BorderSide(width: 2),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(5.h),
                ),
                Visibility(
                  visible: contactNumOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          // controller: contactNumController2,
                          onChanged: (val) {
                            // contactNumController2.text=val;
                            registerYourBusinessModel.contactPhone = val;
                          },
                          hint: "Contact Number",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(5.w),
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
                SizedBox(
                  height: ScreenUtil().setHeight(5.h),
                ),
                Visibility(
                  visible: contactNumTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          // controller: contactNumController3,
                          onChanged: (val) {
                            // contactNumController3.text=val;
                            registerYourBusinessModel.contactPhone = val;
                          },
                          hint: "Contact Number",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(5.w),
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
                SizedBox(
                  height: ScreenUtil().setHeight(5.h),
                ),
                Visibility(
                  visible: contactNumThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          // controller: contactNumController4,
                          onChanged: (val) {
                            // contactNumController4.text=val;
                            registerYourBusinessModel.contactPhone = val;
                          },
                          hint: "Contact Number",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
                      SizedBox(
                        width: ScreenUtil().setWidth(4.w),
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
                      activeColor: greenColor2,
                      // Replace with your desired color
                      onChanged: (value) {
                        setState(() {
                          checkNumber = value ??
                              false; // Update the state when the checkbox is toggled
                        });
                      },
                    ),
                    Text("Some number for WhatsApp"),
                  ],
                ),
                Visibility(
                  visible: checkNumber,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 9,
                        child: CustomTextFormFieldWidget(
                          // controller: whatsAppController,
                          onChanged: (val) {
                            // whatsAppController.text=val;
                            registerYourBusinessModel.whatsAppNumber = val;
                          },
                          hint: "whatsApp Number",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ),
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
                        color: greenColor2,
                        // Replace with your desired color
                        ontap: () {
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
                          color:
                              Colors.white, // Replace with your desired color
                        ),
                      ),
                    ),
                  ],
                ),
                Visibility(
                  visible: socialMediaLink,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                            title: "Email Address",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.email = val;
                          },
                          hint: "Email",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Website Address",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.weblink = val;
                          },
                          hint: "website link",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "IOS App Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.iOsurl = val;
                          },
                          hint: "Opetionalbgfhgh",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Android App Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.androidUrl = val;
                          },
                          hint: "Opetional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Fax Number",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.faxNumber = val;
                          },
                          hint: "Opetional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "FaceBook Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.facebookUrl = val;
                          },
                          hint: "Opetional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Twitter Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.twitterUrl = val;
                          },
                          hint: "Opetional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Instagram Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          onChanged: (val) {
                            registerYourBusinessModel.instagramUrl = val;
                          },
                          hint: "Opetional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                Divider(thickness: 2, color: greenColor2),
                CustomText(
                    title: "OPENING HOURS",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: greenColor2),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CustomText(
                        title: "Set to All",
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: greenColor2),
                    GestureDetector(
                        onTap: () {
                          setState(() {
                            val = !val;
                          });
                          // Call the method to update all checkboxes
                          updateAllCheckboxes(val);
                        },
                        child: CustomText(
                            title: "Set to All",
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                            color: greenColor2)),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                OpenHoursContainer(
                    customCheckbox: Checkbox(
                      onChanged: (value) {
                        setState(() {
                          val = value!;
                        });
                      },
                      value: val,
                      activeColor: greenColor2,
                    ),
                    child: CustomText(title: "Monday")),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
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
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                OpenHoursContainer(
                  customCheckbox: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        val1 = value ?? false;
                      });
                    },
                    value: val1,
                    activeColor: greenColor2,
                  ),
                  child: CustomText(title: "Tuesday"),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
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
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                OpenHoursContainer(
                  customCheckbox: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        val2 = value!;
                      });
                    },
                    value: val2,
                    activeColor: greenColor2,
                  ),
                  child: CustomText(title: "Wednesday"),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
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
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                OpenHoursContainer(
                  customCheckbox: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        val3 = value!;
                      });
                    },
                    value: val3,
                    activeColor: greenColor2,
                  ),
                  child: CustomText(title: "Thursday"),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
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
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                OpenHoursContainer(
                  customCheckbox: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        val4 = value!;
                      });
                    },
                    value: val4,
                    activeColor: greenColor2,
                  ),
                  child: CustomText(title: "Friday"),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
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
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                OpenHoursContainer(
                  customCheckbox: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        val5 = value!;
                      });
                    },
                    value: val5,
                    activeColor: greenColor2,
                  ),
                  child: CustomText(title: "Saturday"),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
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
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                OpenHoursContainer(
                  customCheckbox: Checkbox(
                    onChanged: (value) {
                      setState(() {
                        val6 = value!;
                      });
                    },
                    value: val6,
                    activeColor: greenColor2,
                  ),
                  child: CustomText(title: "Sunday"),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
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
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                Divider(thickness: 2, color: greenColor2),
                CustomText(
                    title: "LOCATION",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: greenColor2),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                CustomText(
                  title: "Area Name*",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                CustomTextFormFieldWidget(
                    // onChanged: (val){
                    //   registerYourBusinessModel.a = val;
                    // },

                    hint: "Search Location",
                    borderRadius: 10),
                SizedBox(height: ScreenUtil().setHeight(4.h)),
                Image.asset('assets/images/map.jpg'),
                SizedBox(
                  height: ScreenUtil().setHeight(10.h),
                ),
                CustomText(
                  title: "Address...",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                CustomTextFormFieldWidget(
                    onChanged: (val) {
                      registerYourBusinessModel.address = val;
                    },
                    hint: "Search Location",
                    borderRadius: 10),
                Divider(
                  color: greenColor2,
                  thickness: 2,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                        title: "GALLERY",
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: greenColor2),
                    TextButton(
                      onPressed: () {
                        _showChoiceDialoge(context);
                      },
                      child: CustomText(
                          title: "Select Gallery Picture",
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ],
                ),
                decidedImageView(),
                SizedBox(
                  height: ScreenUtil().setHeight(10.h),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        )
                      ]),
                      child: Custom_Button_Widget(
                        ontap: () {
                          registerYourBusinessModel.karobarId = 0;
                          registerYourBusinessModel.lat = 0.0;
                          registerYourBusinessModel.lng = 0.0;
                          registerYourBusinessModel.location = Location();
                          registerYourBusinessModel.location?.locationId = 0;
                          registerYourBusinessModel.location?.locationName = "";
                          registerYourBusinessModel.location?.locLat = 0.0;
                          registerYourBusinessModel.location?.locLng = 0.0;
                          APIController.RegisterBusinessPostData(
                              registerYourBusinessModel);
                          setState(() {});
                        },
                        rd: 10,
                        color: greenColor2,
                        width: ScreenUtil().screenWidth / 3,
                        child: CustomText(
                            title: "Register My Business",
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: whiteColor),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Container(
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        )
                      ]),
                      child: Custom_Button_Widget(
                        ontap: () {},
                        rd: 10,
                        color: greenColor2,
                        width: ScreenUtil().screenWidth / 3,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              CustomText(
                                  title: "Edit Your Business",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 10,
                                  color: whiteColor),
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: whiteColor,
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30.h),
                ),
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
