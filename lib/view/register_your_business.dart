import 'dart:convert';
import 'dart:io';
import 'package:businessonlinepk/Controllers/SubCategoryController.dart';
import 'package:businessonlinepk/model/OpenningHour.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/customs_widgets/open_hours_container.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../Controllers/Api_Controller.dart';
import '../model/OpeningAndClosingTimeModel.dart';
import '../model/RegisterYourBusinessModel.dart';
import '../model/SubCategoryModel.dart';
import 'HomePage_ofBopk.dart';
import 'customs_widgets/CustomTextFormFieldWidget1.dart';
import 'menu_login.dart';
import 'package:http/http.dart' as http;

class RegisterYourBusiness extends StatefulWidget {
  const RegisterYourBusiness({super.key});

  @override
  State<RegisterYourBusiness> createState() => _RegisterYourBusinessState();
}

class _RegisterYourBusinessState extends State<RegisterYourBusiness> {
  OpeningAndClosingTimeModel openingAndClosingTimeModel = OpeningAndClosingTimeModel();
  bool _isLoading = false;
  List<String> contactNumbers = [];
  List<String> otherNumber = [];
  List<String> ownerNames = [];
  List<String> specialties = [];
  final Map<String, bool> checkBoxValues = {
    'Monday': true,
    'Tuesday': true,
    'Wednesday': true,
    'Thursday': true,
    'Friday': true,
    'Saturday': true,
    'Sunday': true,
  };
  final Map<String, String> selectedOpeningTimes = {
    'Monday': '09:00 PM',
    'Tuesday': '09:00 PM',
    'Wednesday': '09:00 PM',
    'Thursday': '09:00 PM',
    'Friday': '09:00 PM',
    'Saturday': '09:00 PM',
    'Sunday': '09:00 PM',
  };
  final Map<String, String> selectedClosingTimes = {
    'Monday': '09:00 PM',
    'Tuesday': '09:00 PM',
    'Wednesday': '09:00 PM',
    'Thursday': '09:00 PM',
    'Friday': '09:00 PM',
    'Saturday': '09:00 PM',
    'Sunday': '09:00 PM',
  };
  final List<String> timeList = [
    '09:00 AM',
    '10:00 AM',
    '11:00 AM',
    '12:00 PM',
    '01:00 PM',
    '02:00 PM',
    '03:00 PM',
    '04:00 PM',
    '05:00 PM',
    '06:00 PM',
    '07:00 PM',
    '08:00 PM',
    '09:00 PM',
    '10:00 PM',
    '11:00 PM',
    '12:00 PM',
  ];
  late GoogleMapController myController;
// Define variables to hold selected values
  String? selectedOpeningTime;
  String? selectedClosingTime;
  // Map<String, String?> selectedOpeningTimes = {}; // Map to store selected opening times for each day
  // Map<String, String?> selectedClosingTimes = {}; // Map to store selected closing times for each day
  // Map<String, bool> checkBoxValues = {}; // Map to store checkbox values for each day
  List<OpenningHour> modelsForAllDays = [];
  DateFormat formatter = DateFormat('HH:mm'); // Format for hours and minute
  APIController apiController = APIController();
  List<Widget> socialMediaLinks = []; // List to store text fields
  int fieldCounter = 0;

  late File imageFile = File('path/to/default/image.png');
  ImagePicker imagePicker = ImagePicker();
// Update onChanged callback for both DropdownButtons
  // String selectedCategory = "";
  List<String> businessCategories = [
  ];
  // BopkController _bopkController = BopkController();
  String defaultCategory = "Select Category "; // Set your default category here

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
  bool checkBox = true; // Initial state of the checkbox
  bool checkTime = false; // Initial state of the checkbox

  // social media link
  bool socialMediaLink = false; // Initial state of the checkbox

  TextEditingController categoryController = TextEditingController();

  // TextEditingController titleController = TextEditingController();
  // TextEditingController descriptionController = TextEditingController();
  // /// SpecialityController
  // TextEditingController specialityController1 = TextEditingController();
  // TextEditingController specialityController2 = TextEditingController();
  // TextEditingController specialityController3 = TextEditingController();
  // TextEditingController specialityController4 = TextEditingController();
  // /// ownerNameController
  // TextEditingController ownerNameController1 = TextEditingController();
  // TextEditingController ownerNameController2 = TextEditingController();
  // TextEditingController ownerNameController3 = TextEditingController();
  // TextEditingController ownerNameController4 = TextEditingController();
  // /// ContactNumber Controller
  // TextEditingController contactNumController1 = TextEditingController();
  // TextEditingController contactNumController2 = TextEditingController();
  // TextEditingController contactNumController3 = TextEditingController();
  // TextEditingController contactNumController4 = TextEditingController();
  // /// Other Field Controller
  // TextEditingController whatsAppController = TextEditingController();
  // TextEditingController searchController = TextEditingController();
  // /// Social Media Controller
  // TextEditingController emailController = TextEditingController();
  // TextEditingController iOsController = TextEditingController();
  // TextEditingController androidController = TextEditingController();
  // TextEditingController faxController = TextEditingController();
  // TextEditingController faceBookController = TextEditingController();
  // TextEditingController webController = TextEditingController();
  // TextEditingController twitterController = TextEditingController();
  // TextEditingController instagramController = TextEditingController();


  // TextEditingController addressController = TextEditingController();
  RegisterYourBusinessModel registerYourBusinessModel = RegisterYourBusinessModel(openningHours: [OpenningHour()]);
  final SubCategoryController _controller = SubCategoryController();
  // HomePageMainCategory? selectedCategory; // Variable to hold the selected category


  late GoogleMapController mapController;
   Position? _currentPosition;
  final Set<Marker> _markers = {};
  String _currentAddress = '';
  SubCategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    // categoryController.text = selectedCategory;
    _fetchCategories();
    _getCurrentLocation();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: customAppBar1(
        elevation: 0,
        centerTitle: false,
        title: CustomText(
          title: 'Business Name ',
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
           menuWidget(),
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
                /// How to Register business? Button
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
                    title: "Business Title *", fontWeight: FontWeight.bold),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
            SizedBox(
              height: ScreenUtil().setHeight(33.h),
              child: CustomTextFormFieldWidget1(
                // controller: TextEditingController(), // Provide a controller
                onChanged: (val) {
                  registerYourBusinessModel.title = val;
                },
                hint: 'Enter Your Business Title',
                borderRadius: 10,
                color: Colors.white, // Use Colors.grey instead of grayColor
                textAlign: TextAlign.left,
              ),
            ),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                CustomText(
                    title: "Business Category *", fontWeight: FontWeight.bold),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                _buildCategoryDropdown(),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                CustomText(title: "Description *", fontWeight: FontWeight.bold),
                SizedBox(
                  height: ScreenUtil().setHeight(6.h),
                ),
                CustomTextFormFieldWidget(
                  // controller: descriptionController,
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
                        width: 27.w,
                        height: 25.h,
                        color: greenColor2,
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // this is code for specity text and add button
                SizedBox(height: ScreenUtil().setHeight(6.h)),
                CustomTextFormFieldWidget1(
                  onChanged: (val) {
                    // Update the first specialty
                    specialties.length >= 1
                        ? specialties[0] = val
                        : specialties.add(val);
                    updateSpecialties();
                  },
                  hint: "Specialty",
                  borderRadius: 10,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: specialityOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the second specialty
                            specialties.length >= 2
                                ? specialties[1] = val
                                : specialties.add(val);
                            updateSpecialties();
                          },
                          hint: "Specialty",
                          borderRadius: 10,
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: specialityTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the third specialty
                            specialties.length >= 3
                                ? specialties[2] = val
                                : specialties.add(val);
                            updateSpecialties();
                          },
                          hint: "Specialty",
                          borderRadius: 10,
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: specialityThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the fourth specialty
                            specialties.length >= 4
                                ? specialties[3] = val
                                : specialties.add(val);
                            updateSpecialties();
                          },
                          hint: "Specialty",
                          borderRadius: 10,
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // CustomTextFormFieldWidget1(
                //   // controller: specialityController1,
                //   onChanged: (val) {
                //     registerYourBusinessModel.speciality = val;
                //   },
                //   hint: "Speciality",
                //   borderRadius: 10,
                //   // borderSide: BorderSide(width: 2),
                // ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(5.h),
                // ),
                // Visibility(
                //   visible: specialityOne,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: specialityController2,
                //           onChanged: (val) {
                //             registerYourBusinessModel.speciality = val;
                //           },
                //           hint: "Speciality",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ),
                //       SizedBox(width: ScreenUtil().setWidth(6.h)),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               specialityOne = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // // this is the first speciality with remove icon if you want to create copy this and paste it
                // SizedBox(height: ScreenUtil().setHeight(6.h)),
                // Visibility(
                //   visible: specialityTwo,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: specialityController3,
                //           onChanged: (val) {
                //             // registerYourBusinessModel.speciality = val;
                //           },
                //
                //           hint: "Speciality",
                //           borderRadius: 10,
                //         ),
                //       ),
                //       SizedBox(width: ScreenUtil().setWidth(6.h)),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               specialityTwo = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // // this is the second speciality with rmove icon
                // SizedBox(height: ScreenUtil().setHeight(6.h)),
                // Visibility(
                //   visible: specialityThree,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: specialityController4,
                //           onChanged: (val) {
                //             // specialityController4.text=val;
                //             registerYourBusinessModel.speciality = val;
                //           },
                //           hint: "Speciality",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ),
                //       SizedBox(width: ScreenUtil().setWidth(6.h)),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               specialityThree = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // this is the third speciality remove icon
                // Owner Name
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 12,
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
                        width: 27.w,
                        height: 25.h,
                        color: greenColor2,
                        child: Icon(
                          Icons.add,
                          size: 20,
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ],
                ),
                // this is the owner name with plus icon
                SizedBox(height: ScreenUtil().setHeight(4.h)),
                CustomTextFormFieldWidget1(
                  onChanged: (val) {
                    // Update the first owner name
                    ownerNames.length >= 1
                        ? ownerNames[0] = val
                        : ownerNames.add(val);
                    updateOwnerName();
                  },
                  hint: "Owner Name",
                  borderRadius: 10,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: ownerNameOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the second owner name
                            ownerNames.length >= 2
                                ? ownerNames[1] = val
                                : ownerNames.add(val);
                            updateOwnerName();
                          },
                          hint: "Owner Name",
                          borderRadius: 10,
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: ownerNameTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the third owner name
                            ownerNames.length >= 3
                                ? ownerNames[2] = val
                                : ownerNames.add(val);
                            updateOwnerName();
                          },
                          hint: "Owner Name",
                          borderRadius: 10,
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: ownerNameThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the fourth owner name
                            ownerNames.length >= 4
                                ? ownerNames[3] = val
                                : ownerNames.add(val);
                            updateOwnerName();
                          },
                          hint: "Owner Name",
                          borderRadius: 10,
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // CustomTextFormFieldWidget1(
                //   // controller: ownerNameController1,
                //   onChanged: (val) {
                //     // ownerNameController1.text=val;
                //     registerYourBusinessModel.ownerName=val;
                //   },
                //   hint: "Owner Name",
                //   borderRadius: 10,
                //   // borderSide: BorderSide(width: 2),
                // ),
                // SizedBox(height: ScreenUtil().setHeight(4.h)),
                // Visibility(
                //   visible: ownerNameOne,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: ownerNameController2,
                //           onChanged: (val) {
                //             // ownerNameController2.text=val;
                //             registerYourBusinessModel.ownerName=val;
                //           },
                //           hint: "Owner Name",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ),
                //       SizedBox(width: ScreenUtil().setWidth(4.h)),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               ownerNameOne = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: ScreenUtil().setHeight(4.h)),
                // Visibility(
                //   visible: ownerNameTwo,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: ownerNameController3,
                //           onChanged: (val) {
                //             // ownerNameController3.text=val;
                //             registerYourBusinessModel.ownerName=val;
                //           },
                //           hint: "Owner Name",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ),
                //       SizedBox(width: ScreenUtil().setWidth(4.h)),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               ownerNameTwo = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(height: ScreenUtil().setHeight(4.h)),
                // Visibility(
                //   visible: ownerNameThree,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: ownerNameController4,
                //           onChanged: (val) {
                //             // ownerNameController4.text=val;
                //             registerYourBusinessModel.contactNumber=val;
                //           },
                //           hint: "Owner Name",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ),
                //       SizedBox(width: ScreenUtil().setWidth(4.h)),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               ownerNameThree = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 12,
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
                        width: 27.w,
                        height: 25.h,
                        color: greenColor2,
                        child: Icon(
                          Icons.add,
                          size: 20,
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

                // CustomTextFormFieldWidget1(
                //   // controller: contactNumController1,
                //   onChanged: (val) {
                //     // contactNumController1.text=val;
                //     registerYourBusinessModel.contactNumber = val;
                //   },
                //   hint: "eg 03319234730",
                //   borderRadius: 10,
                //   // borderSide: BorderSide(width: 2),
                // ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(5.h),
                // ),
                // Visibility(
                //   visible: contactNumOne,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: contactNumController2,
                //           onChanged: (val) {
                //             registerYourBusinessModel.contactNumber = val;
                //           },
                //           hint: "Contact Number",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ),
                //       SizedBox(
                //         width: ScreenUtil().setWidth(5.w),
                //       ),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               contactNumOne = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(5.h),
                // ),
                // Visibility(
                //   visible: contactNumTwo,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: contactNumController3,
                //           onChanged: (val) {
                //             // contactNumController3.text=val;
                //             registerYourBusinessModel.contactNumber = val;
                //           },
                //           hint: "Contact Number",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ),
                //       SizedBox(
                //         width: ScreenUtil().setWidth(5.w),
                //       ),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               contactNumTwo = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                // SizedBox(
                //   height: ScreenUtil().setHeight(5.h),
                // ),
                // Visibility(
                //   visible: contactNumThree,
                //   child: Row(
                //     children: [
                //       Flexible(
                //         flex: 12,
                //         child: CustomTextFormFieldWidget1(
                //           // controller: contactNumController4,
                //           onChanged: (val) {
                //             // contactNumController4.text=val;
                //             registerYourBusinessModel.contactNumber = val;
                //           },
                //           hint: "Contact Number",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ),
                //       SizedBox(
                //         width: ScreenUtil().setWidth(4.w),
                //       ),
                //       Flexible(
                //         flex: 1,
                //         child: Custom_Button_Widget(
                //           ontap: () {
                //             setState(() {
                //               contactNumThree = false;
                //             });
                //           },
                //           rd: 100,
                //           width: 27.w,
                //           height: 25.h,
                //           color: greenColor2,
                //           child: Icon(
                //             Icons.remove,
                //             size: 20,
                //             color: whiteColor,
                //           ),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                CustomTextFormFieldWidget1(
                  onChanged: (val) {
                     registerYourBusinessModel.contactNumber=val;
                    // Update the first contact number
                    // contactNumbers.length >= 1
                    //     ? contactNumbers[0] = val
                    //     : contactNumbers.add(val);
                    // updateContactNumber();
                     otherNumber[0] = val;
                  },
                  hint: "eg 03319234730",
                  borderRadius: 10,
                  keyboardType: TextInputType.phone, // Example keyboard type
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: contactNumOne,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the second contact number
                            otherNumber.length >= 1
                                ? otherNumber[0] = val
                                : otherNumber.add(val);
                            updateContactNumber();
                          },
                          hint: "Contact Number",
                          borderRadius: 10,
                          keyboardType: TextInputType.phone, // Example keyboard type
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: contactNumTwo,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the third contact number
                            otherNumber.length >= 2
                                ? otherNumber[1] = val
                                : otherNumber.add(val);
                            updateContactNumber();
                          },
                          hint: "Contact Number",
                          borderRadius: 10,
                          keyboardType: TextInputType.phone, // Example keyboard type
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
                            color: whiteColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                Visibility(
                  visible: contactNumThree,
                  child: Row(
                    children: [
                      Flexible(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            // Update the fourth contact number
                            otherNumber.length >= 3
                                ? otherNumber[2] = val
                                : otherNumber.add(val);
                            updateContactNumber();
                          },
                          hint: "Contact Number",
                          borderRadius: 10,
                          keyboardType: TextInputType.phone, // Example keyboard type
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
                          width: 27.w,
                          height: 25.h,
                          color: greenColor2,
                          child: Icon(
                            Icons.remove,
                            size: 20,
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
                      value: checkBox,
                      activeColor: greenColor2,
                      onChanged: (value) {
                        setState(() {
                          checkBox = value ?? false; // Update the state of the checkbox
                          if (checkBox) {
                            // If checkbox is checked
                            checkNumber = true; // Hide the WhatsApp text field
                            print("Checkbox checked");
                          } else {
                            // If checkbox is unchecked
                            checkNumber = false; // Show the WhatsApp text field
                            // Set WhatsApp number to the first number in the contactNumbers list
                            registerYourBusinessModel.whatsappNumber = contactNumbers.isNotEmpty ? contactNumbers[0] : '';
                            print("Checkbox unchecked");
                          }
                        });
                      },
                    ),
                    Text("Same number for WhatsApp"),
                  ],
                ),
                Visibility(
                  visible: checkNumber,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 12,
                        child: CustomTextFormFieldWidget1(
                          onChanged: (val) {
                            registerYourBusinessModel.whatsappNumber = val;
                          },
                          hint: "WhatsApp Number",
                          borderRadius: 10,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
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
                        CustomTextFormFieldWidget1(
                          // controller: emailController,
                          onChanged: (val) {
                            registerYourBusinessModel.email = val;
                          },
                          hint: "Email",
                          borderRadius: 10,
                          // borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Website Address",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget1(
                          // controller: webController,
                          onChanged: (val) {
                            // registerYourBusinessModel.weblink = val;
                          },
                          hint: "website link",
                          borderRadius: 10,
                          // borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "IOS App Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget1(
                          // controller: iOsController,
                          onChanged: (val) {
                            // registerYourBusinessModel.ios = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          // borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Android App Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget1(
                          // controller: androidController,
                          onChanged: (val) {
                            // registerYourBusinessModel.androidUrl = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          // borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Fax Number",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget1(
                          // controller: faxController,
                          onChanged: (val) {
                            // registerYourBusinessModel.faxnumber = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          // borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "FaceBook Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget1(
                          // controller: faceBookController,
                          onChanged: (val) {
                            registerYourBusinessModel.facebookUrl = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          // borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Twitter Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget1(
                          // controller: twitterController,
                          onChanged: (val) {
                            registerYourBusinessModel.twitterUrl = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          // borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Instagram Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget1(
                          // controller:  instagramController,
                          onChanged: (val) {
                            registerYourBusinessModel.instagramUrl = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          // borderSide: BorderSide(width: 2),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                Divider(thickness: 2, color: greenColor2),

                /// Opening And Closing Hours
                CustomText(
                    title: "OPENING HOURS",
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                    color: greenColor2),
                // SizedBox(
                //   height: ScreenUtil().setHeight(20.h),
                // ),
                 /// add Opening Hour And Close Hour
                // Column(
                //   children: [
                //     Row(
                //       mainAxisAlignment: MainAxisAlignment.end,
                //       children: [
                //         CustomText(
                //             title: "",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 20.sp,
                //             color: greenColor2
                //         ),
                //         GestureDetector(
                //           onTap: () {
                //             setState(() {
                //               // Iterate through each day and set its checkbox value to true
                //               for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']) {
                //                 checkBoxValues[day] = checkBoxValues[day] == null ? false : !checkBoxValues[day]!;
                //               }
                //             });
                //           },
                //           child: CustomText(
                //               title: "Set to All",
                //               fontWeight: FontWeight.bold,
                //               fontSize: 20.sp,
                //               color: greenColor2
                //           ),
                //         ),
                //       ],
                //     ),
                //     for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])
                //       Padding(
                //         padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                //         child: Column(
                //           children: [
                //             OpenHoursContainer(
                //               isChecked: true,
                //               customCheckbox: Checkbox(
                //                 onChanged: (value) {
                //                   setState(() {
                //                     checkBoxValues[day] = value!;
                //                     print('Checkbox value changed: $value');
                //                   });
                //                 },
                //                 value: checkBoxValues[day] ?? false,
                //                 activeColor: greenColor2,
                //               ),
                //               child:  CustomText(title: day),
                //             ),
                //             // Text(day),
                //             SizedBox(height: 20,),
                //             Visibility(
                //               visible: checkBoxValues[day] ?? false,
                //               child: Row(
                //                 mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                 children: [
                //                   Expanded(
                //                     child: Container(
                //                       decoration: BoxDecoration(
                //                         color: whiteColor,
                //                         borderRadius: BorderRadius.circular(10),
                //                         boxShadow: const [
                //                           BoxShadow(
                //                             color: grayColor,
                //                             blurRadius: 3,
                //                             spreadRadius: 0.5,
                //                             offset: Offset(0, 0),
                //                           ),
                //                         ],
                //                       ),
                //                       child: Center(
                //                         child: DropdownButton<String>(
                //                           borderRadius: BorderRadius.circular(10),
                //                           underline: const SizedBox(),  // Empty SizedBox to replace the underline
                //                           value: selectedOpeningTimes[day] ?? timeList.first,
                //                           items: timeList.map((String value) {
                //                             return DropdownMenuItem<String>(
                //                               value: value,
                //                               child: Text(value),
                //                             );
                //                           }).toList(),
                //                           onChanged: (String? value) {
                //                             setState(() {
                //                               selectedOpeningTimes[day] = value;
                //                             });
                //                           },
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                   const SizedBox(width: 10),  // Add some spacing between the two Expanded widgets if needed
                //                   Expanded(
                //                     child: Container(
                //                       decoration: BoxDecoration(
                //                         color: whiteColor,
                //                         borderRadius: BorderRadius.circular(10),
                //                         boxShadow: const [
                //                           BoxShadow(
                //                             color: grayColor,
                //                             blurRadius: 3,
                //                             spreadRadius: 0.5,
                //                             offset: Offset(0, 0),
                //                           ),
                //                         ],
                //                       ),
                //                       child: Center(
                //                         child: DropdownButton<String>(
                //                           borderRadius: BorderRadius.circular(10),
                //                           underline: const SizedBox(),  // Empty SizedBox to replace the underline
                //                           value: selectedClosingTimes[day] ?? timeList.first,
                //                           items: timeList.map((String value) {
                //                             return DropdownMenuItem<String>(
                //                               value: value,
                //                               child: Text(value),
                //                             );
                //                           }).toList(),
                //                           onChanged: (String? value) {
                //                             setState(() {
                //                               selectedClosingTimes[day] = value;
                //                             });
                //                           },
                //                         ),
                //                       ),
                //                     ),
                //                   ),
                //                 ],
                //               ),
                //             ),
                //
                //
                //
                //
                //
                //           ],
                //         ),
                //       ),
                //   ],
                // ),
        Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           // Iterate through each day and toggle its checkbox value
            //           for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']) {
            //             checkBoxValues[day] = checkBoxValues[day] == null ? false : !checkBoxValues[day]!;
            //           }
            //         });
            //       },
            //       child: CustomText(
            //         title: "Set to All",
            //         fontWeight: FontWeight.bold,
            //         fontSize: 20.sp,
            //         color: greenColor2,
            //       ),
            //     ),
            //   ],
            // ),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomText(
                        title: "",
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: greenColor2
                    ),
                    // GestureDetector(
                    //   onTap: () {
                    //     setState(() {
                    //       // Iterate through each day and toggle its checkbox value
                    //       for (var day in checkBoxValues.keys) {
                    //         checkBoxValues[day] = checkBoxValues[day] == null ? false : !checkBoxValues[day]!;
                    //       }
                    //     });
                    //   },
                    //   child: CustomText(
                    //       title: "Set to All",
                    //       fontWeight: FontWeight.bold,
                    //       fontSize: 20.sp,
                    //       color: greenColor2
                    //   ),
                    // ),
                    GestureDetector(
                      onTap: setAllDaysToMondayTimes, // Call the function when "Set to All" is tapped
                      child: CustomText(
                        title: "Set to All",
                        fontWeight: FontWeight.bold,
                        fontSize: 20.sp,
                        color: greenColor2,
                      ),
                    ),
                  ],
                ),
                for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                    child: Column(
                      children: [
                        OpenHoursContainer(
                          isChecked: checkBoxValues[day] ?? false,
                          customCheckbox: Checkbox(
                            onChanged: (value) {
                              setState(() {
                                checkBoxValues[day] = value!;
                              });
                            },
                            value: checkBoxValues[day] ?? false,
                            activeColor: greenColor2,
                          ),
                          child: CustomText(title: day),
                        ),
                        SizedBox(height: 20),
                        Visibility(
                          visible: checkBoxValues[day] ?? false,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Expanded(
                                child: Container(
                                  height: 50, // Set a fixed height
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: grayColor,
                                        blurRadius: 3,
                                        spreadRadius: 0.5,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      isExpanded: true, // Ensures dropdown takes full width
                                      borderRadius: BorderRadius.circular(10),
                                      underline: const SizedBox(), // Empty SizedBox to replace the underline
                                      value: selectedOpeningTimes[day],
                                      items: timeList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Text(value),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedOpeningTimes[day] = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10), // Add some spacing between the two Expanded widgets if needed
                              Expanded(
                                child: Container(
                                  height: 50, // Set a fixed height
                                  decoration: BoxDecoration(
                                    color: whiteColor,
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: grayColor,
                                        blurRadius: 3,
                                        spreadRadius: 0.5,
                                        offset: Offset(0, 0),
                                      ),
                                    ],
                                  ),
                                  child: Center(
                                    child: DropdownButton<String>(
                                      isExpanded: true, // Ensures dropdown takes full width
                                      borderRadius: BorderRadius.circular(10),
                                      underline: const SizedBox(), // Empty SizedBox to replace the underline
                                      value: selectedClosingTimes[day],
                                      items: timeList.map((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                            child: Text(value),
                                          ),
                                        );
                                      }).toList(),
                                      onChanged: (String? value) {
                                        setState(() {
                                          selectedClosingTimes[day] = value!;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ],
        ),
                /// end OF Open And Close hour
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                Divider(thickness: 2, color: greenColor2),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                SizedBox(height: ScreenUtil().setHeight(4.h)),
                SizedBox(
                  height: MediaQuery.of(context).size.height/3,
                  width:  MediaQuery.of(context).size.width,
                  child:   SizedBox(
                    height: MediaQuery.of(context).size.height / 3,
                    width: MediaQuery.of(context).size.width,
                    child: _currentPosition == null
                        ? Center(child: CircularProgressIndicator())
                        : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
                        zoom: 15,
                      ),
                      onMapCreated: (GoogleMapController controller) {
                        mapController = controller;
                      },
                      markers: _markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10.h),
                ),
                CustomText(
                  title: "Address...",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                CustomTextFormFieldWidget1(
                  // controller: addressController,
                    onChanged: (val) {
                      registerYourBusinessModel.address = _currentAddress;
                    },
                    hint: _currentAddress,
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

                /// Register Button Comment
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        )
                      ]),
                      child: Custom_Button_Widget(
                        ontap: ()  async{
                          setState(() {
                            _isLoading = true;
                          });

                          List<String> daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
                          List<OpenningHour> modelsForAllDays = [];

                          for (String day in daysOfWeek) {
                            OpenningHour model = OpenningHour(
                              dayOfWeek: day,
                              openingTime: selectedOpeningTimes[day] ?? "10:00 AM",
                              closingTime: selectedClosingTimes[day] ?? "10:00 PM",
                              isOpen: false,
                            );
                            modelsForAllDays.add(model);
                          }
                          registerYourBusinessModel.id = 0;
                          registerYourBusinessModel.lat = _currentPosition?.latitude;
                          registerYourBusinessModel.lng = _currentPosition?.longitude;
                          registerYourBusinessModel.address = _currentAddress;
                          registerYourBusinessModel.openningHours = modelsForAllDays;
                          try {
                            ApiResponseReg response = await apiController.registerBusinessPostData(registerYourBusinessModel, context);
                            if (kDebugMode) {
                              print("Response status code: ${response.statusCode}");
                            }
                            if (kDebugMode) {
                              print("Response body: ${response.responseBody}");
                            }

                            if (response.statusCode == 200) {
                              // Parse the JSON string into a Dart Map
                              Map<String, dynamic> jsonResponse = jsonDecode(response.responseBody);

                              // Extract the value of the 'karobarId' field
                              int karobarId = jsonResponse['karobarId'];

                              // Now you can use the karobarId as needed
                              print('karobarId: $karobarId');

                            await uploadImage(karobarId);
                            // Clear fields and image
                            setState(() {
                              imageFile = File('path/to/default/image.png');
                              // Clear other fields here if needed
                            });
                            setState(() {});
                            // clearFields();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                duration: Duration(seconds: 3),
                                content: Container(
                                  width: MediaQuery.of(context).size.width * 0.90,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Registration successful",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            );
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(seconds: 3),
                                content: Container(
                                  width: MediaQuery.of(context).size.width * 0.90,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Failed to submit response",
                                      style: TextStyle(fontSize: 17),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }
                          }
                          catch (e) {
                            print("Error during registration: $e");
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                          }



                        },
                        rd: 10,
                        color: greenColor2,
                        width: ScreenUtil().screenWidth / 1.2,
                        child: CustomText(
                            title: "Register your Business",
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: whiteColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(30.h),
                ),
                Visibility(
                  visible: _isLoading,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // void clearFields() {
  //   titleController.clear();
  //   descriptionController.clear();
  //   specialityController1.clear();
  //   specialityController2.clear();
  //   specialityController3.clear();
  //   specialityController4.clear();
  //   ownerNameController1.clear();
  //   ownerNameController2.clear();
  //   ownerNameController3.clear();
  //   ownerNameController4.clear();
  //   contactNumController1.clear();
  //   contactNumController2.clear();
  //   contactNumController3.clear();
  //   contactNumController4.clear();
  //   whatsAppController.clear();
  //   iOsController.clear();
  //   androidController.clear();
  //   faxController.clear();
  //   webController.clear();
  //   faceBookController.clear();
  //   instagramController.clear();
  //   twitterController.clear();
  //   addressController.clear();
  // }

  Widget _buildCategoryDropdown() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Colors.grey),
      ),
      child: DropdownButton<SubCategoryModel>(
        value: _selectedCategory,
        onChanged: (SubCategoryModel? newValue) {
          setState(() {
            _selectedCategory = newValue;
            if (_selectedCategory != null) {
              print('Selected category ID: ${_selectedCategory!.categoryId}');
              print('Selected category name: ${_selectedCategory!.categoryName}');
              registerYourBusinessModel.fkCategoryId = _selectedCategory!.categoryId!.toInt();
            }
          });
        },
        items: [
          DropdownMenuItem(
            value: null,
            child: Text(
              '  Please select a category',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ..._categories.map<DropdownMenuItem<SubCategoryModel>>((SubCategoryModel category) {
            return DropdownMenuItem<SubCategoryModel>(
              value: category,
              child: Text('  ${category.categoryName ?? ''} '),
            );
          }).toList(),
        ],
      ),
    );
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _updateMarkers();
      _getAddressFromLatLng();
    });
  }

  void _updateMarkers() {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId("current_location"),
        position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        infoWindow: InfoWindow(title: "Current Location"),
      ),
    );
  }

  void _getAddressFromLatLng() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude, _currentPosition!.longitude);
      Placemark place = placemarks[0];
      setState(() {
        _currentAddress =
        "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }
  List<SubCategoryModel> _categories = [];

  Future<void> _fetchCategories() async {
    await _controller.fetchHomePageCategories();
    setState(() {
      _categories = _controller.categories
          .where((category) => category.categoryName != null) // Filter out null names
          .toList();
    });
  }

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
  Future<void> uploadImage(int id) async {
    var request = http.MultipartRequest('POST', Uri.parse('https://bopkapi.businessonline.pk/RegisterBusinesses/UploadImage?id=$id'));
    request.files.add(await http.MultipartFile.fromPath('files', imageFile.path));
    // request.files.add(await http.MultipartFile.fromPath('files', 'fcyf_h38s/Group 431.png'));
    // request.files.add(await http.MultipartFile.fromPath('files', 'fcyf_h38s/Group 432.png'));

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('Image uploaded successfully');
    }
    else {
      print(response.reasonPhrase);
      print('error Image uploaded successfully');
    }

    // // Check if an image is selected
    // if (imageFile == null) {
    //   if (kDebugMode) {
    //     print('No image selected.');
    //   }
    //   return;
    // }
    // try {
    //   // Create a multipart request
    //   var request = http.MultipartRequest(
    //       'POST',
    //       Uri.parse('https://bopkapi.businessonline.pk/api/RegisterImage/UploadImages')
    //   );
    //   // Add the query parameters directly to the URI
    //   request.fields['KId'] = id.toString();
    //   // Add the image file to the request
    //   request.files.add(
    //       await http.MultipartFile.fromPath('file', imageFile.path)
    //   );
    //   // Send the request
    //   var response = await request.send();
    //   // Check the response status code
    //   if (response.statusCode == 200) {
    //     // If successful, print the response
    //     print('Image uploaded successfully');
    //     print(await response.stream.bytesToString());
    //   } else {
    //     // If not successful, print the error status code and reason
    //     print('Failed to upload image. Error: ${response.statusCode}');
    //     print(await response.stream.bytesToString());
    //   }
    // } catch (e) {
    //   // Catch any exceptions that occur during the request
    //   print('Error uploading image: $e');
    // }
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

  onOpeningTimeChanged(String? value) {
    setState(() {
      selectedOpeningTime = value ?? "select";
    });
  }

  onClosingTimeChanged(String? value) {
    setState(() {
      selectedClosingTime = value;
    });
  }

  menuWidget() {
    return  PopupMenuButton<int>(
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
        ];
      },
      onSelected: (int value) {
        if (value == 0) {
          if (kDebugMode) {
            print("Login menu is selected.");
          }
        } else if (value == 1) {
          if (kDebugMode) {
            print("Register Your Business menu is selected.");
          }
        } else if (value == 2) {
          if (kDebugMode) {
            print("BOPK Home menu is selected.");
          }
        } else if (value == 3) {
          if (kDebugMode) {
            print("Business For Sale menu is selected.");
          }
        } else if (value == 4) {
          if (kDebugMode) {
            print("About us menu is selected.");
          }
        } else if (value == 5) {
          if (kDebugMode) {
            print("Contact us menu is selected.");
          }
        } else if (value == 6) {
          if (kDebugMode) {
            print("Contact us menu is selected.");
          }
        } else if (value == 7) {
          if (kDebugMode) {
            print("Contact us menu is selected.");
          }
        }
      },
    );
  }
  void setAllDaysToMondayTimes() {
    setState(() {
      for (var day in selectedOpeningTimes.keys) {
        selectedOpeningTimes[day] = selectedOpeningTimes['Monday']!;
        selectedClosingTimes[day] = selectedClosingTimes['Monday']!;
      }
    });
  }
  void updateContactNumber() {
    setState(() {
      // Join the contact numbers with commas
      registerYourBusinessModel.otherNumber = otherNumber.join(',');

    });
  }
  void updateOwnerName() {
    setState(() {
      // Join the owner names with commas
      registerYourBusinessModel.ownerName = ownerNames.join(',');
    });
  }
  void updateSpecialties() {
    setState(() {
      // Join the specialties with commas
      registerYourBusinessModel.speciality = specialties.join(',');
    });
  }
}