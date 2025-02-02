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
import 'package:image_picker/image_picker.dart' as picker;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../Controllers/Api_Controller.dart';
import '../../model/DetailStaticBusinessModel.dart';
import '../../model/RegisterYourBusinessModel.dart';
import '../../model/SubCategoryModel.dart';
import '../../model/UpdateProfileModel.dart';
import '../customs_widgets/CustomTextFormFieldWidget1.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import '../menu_login.dart';

class UpdateBasicInfo extends StatefulWidget {
  const UpdateBasicInfo(this.fkKarobarId, {super.key});
  final int fkKarobarId;

  @override
  State<UpdateBasicInfo> createState() => _UpdateBasicInfoState();
}

class _UpdateBasicInfoState extends State<UpdateBasicInfo> {
  bool _isLoading = false;
  List<String> contactNumbers = [];
  List<String> otherNumber = [];
  List<String> ownerNames = [];
  List<String> specialties = [];
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
  // ImagePicker imagePicker = ImagePicker();
// Update onChanged callback for both DropdownButtons
  // String selectedCategory = "";
  List<SubCategoryModel> _categories = [];
  // BopkController _bopkController = BopkController();
  String defaultCategory = "Select Category "; // Set your default category here
  final List<XFile>? selectedImagesList = [];
  List<String> selectedImagePaths = []; // New list to store paths
  bool specialityOne = false;
  bool specialityTwo = false;
  bool specialityThree = false;

  // Close Speciality
  bool ownerNameOne = false;
  bool ownerNameTwo = false;
  bool ownerNameThree = false;
  int? t = 0;
  List<File> images = [];
  //Close OwnerName
  bool contactNumOne = false;
  bool contactNumTwo = false;
  bool contactNumThree = false;

  double? picklat;
  double? picklng;

  String? specialty;
  String? specialty1;
  String? specialty2;
  String? specialty3;

  String? phoneNumb1;
  String? phoneNumb2;
  String? phoneNumb3;

  String? ownerName1;
  String? ownerName2;
  String? ownerName3;
  //Close ContactNumber
  bool checkNumber = false; // Initial state of the checkbox
  bool checkBox = true; // Initial state of the checkbox
  bool checkTime = false; // Initial state of the checkbox

  GoogleMapController? _mapController;
  // social media link
  bool socialMediaLink = false; // Initial state of the checkbox
  TextEditingController categoryController = TextEditingController();
  UpdateProfileModel updateProfileModel=UpdateProfileModel();
  final SubCategoryController _controller = SubCategoryController();
  late GoogleMapController mapController;
  Position? _currentPosition;
  final Set<Marker> _markers = {};
  String _currentAddress = '';
  SubCategoryModel? _selectedCategory;
  DetailStaticBusinessModel businessModel = DetailStaticBusinessModel();
  int specialtyCount = 0;
  @override
  void initState() {
    super.initState();
    // categoryController.text = selectedCategory;
    _fetchCategories();
    _getCurrentLocation();
    getDetails(widget.fkKarobarId);/// provide id they will be dynamic
    ///
    updateProfileModel.description=businessModel.description;   /// if without selection data from textfeild they are sending null but i want dont send null then add here i have added one if you other you can call here.
   updateProfileModel.email=businessModel.email;
   updateProfileModel.address=businessModel.address;
   updateProfileModel.iOsurl=businessModel.iOsurl;
   updateProfileModel.androidUrl=businessModel.androidUrl;
   updateProfileModel.faxNumber=businessModel.faxNumber;
   updateProfileModel.facebookUrl=businessModel.facebookUrl;
   updateProfileModel.twitterUrl=businessModel.twitterUrl;
   updateProfileModel.instagramUrl=businessModel.instagramUrl;
  }

  Future<void> getDetails(int? karobarId) async {
    APIController controller = APIController();
    businessModel = (await controller.fetchDataDetails(karobarId))!;




    List<String>? specialties = businessModel.speciality?.split(',');

    if (specialties != null) {
      if (specialties.length > 0) {
        specialty = specialties[0].trim();
        print("[[[[[[" + specialty.toString());
      }
      if (specialties.length > 1) {
        specialty1 = specialties[1].trim();
        print("aaaaaa" + specialty1.toString());
      }
      if (specialties.length > 2) {
        specialty2 = specialties[2].trim();
        print("nnnnnn" + specialty2.toString());
      }
      if (specialties.length > 3) {
        specialty3 = specialties[3].trim();
        print("mmmm" + specialty3.toString());
      }
    } else {
      // Handle the case where specialties is null
      print("Specialties is null or empty.");
    }


    List<String>? phoneNumbers = businessModel.contactPhone?.split(',');
      if (phoneNumbers != null) {
        if (phoneNumbers.length >= 1) phoneNumb1 = phoneNumbers[0];
        if (phoneNumbers.length >= 2) phoneNumb2 = phoneNumbers[1];
        if (phoneNumbers.length >= 3) phoneNumb3 = phoneNumbers[2];
      }

      List<String>? ownerNames = businessModel.contactName?.split(',');
      if (ownerNames != null) {
        if (ownerNames.length >= 1) ownerName1 = ownerNames[0];
        if (ownerNames.length >= 2) ownerName2 = ownerNames[1];
        if (ownerNames.length >= 3) ownerName3 = ownerNames[2];
      }


      updateProfileModel.fkCategoryId = businessModel.fkCategoryId;
      _currentAddress = businessModel.address!;
    setState(() {
      _initializeSelectedCategory();
    });

  }

  void _initializeSelectedCategory() {
    setState(() {
      _selectedCategory = _categories.firstWhere(
            (category) => category.categoryId == businessModel.fkCategoryId,
      );
    });
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
                      updateProfileModel.title = val;
                    },
                    hint: businessModel.title,
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
                    print("Typed text: $val");
                    updateProfileModel.description = val;
                  },

                  hint: businessModel.description,
                  maxLines: 10,
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
                specialty != null && specialty!.isNotEmpty ?CustomTextFormFieldWidget1(
                  onChanged: (val) {
                    // Update the first specialty
                    specialties.isNotEmpty
                        ? specialties[0] = val
                        : specialties.add(val);
                    updateSpecialties();
                  },
                  hint: specialty,
                  borderRadius: 10,
                ):CustomTextFormFieldWidget1(
                  onChanged: (val) {
                    // Update the first specialty
                    specialties.isNotEmpty
                        ? specialties[0] = val
                        : specialties.add(val);
                    updateSpecialties();
                  },
                  hint: "Speciality",
                  borderRadius: 10,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                specialty1 != null && specialty1!.isNotEmpty ?Row(
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
                        hint: specialty1,
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
                ):Visibility(
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
                          hint: "Speciality",
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
                specialty2 != null && specialty2!.isNotEmpty ? Row(
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
                        hint: specialty2,
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
                ):Visibility(
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
                          hint: specialty2,
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
            specialty3 != null && specialty3!.isNotEmpty ?
            Row(
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
                    hint: specialty3,
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
            ) :
            Visibility(
              visible: specialityThree,
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
                      hint: "Speciality",
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
                //     updateProfileModel.speciality = val;
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
                //             updateProfileModel.speciality = val;
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
                //             // updateProfileModel.speciality = val;
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
                //             updateProfileModel.speciality = val;
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
                    ownerNames.isNotEmpty
                        ? ownerNames[0] = val
                        : ownerNames.add(val);
                    updateOwnerName();
                  },
                  hint: ownerName1,
                  borderRadius: 10,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                ownerName2 != null && ownerName2!.isNotEmpty?Row(
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
                        hint: ownerName2,
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
                ):Visibility(
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
                ownerName3 != null && ownerName3!.isNotEmpty?Row(
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
                        hint: ownerName3,
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
                ):Visibility(
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
                //     updateProfileModel.ownerName=val;
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
                //             updateProfileModel.ownerName=val;
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
                //             updateProfileModel.ownerName=val;
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
                //             updateProfileModel.contactNumber=val;
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
                //     updateProfileModel.contactNumber = val;
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
                //             updateProfileModel.contactNumber = val;
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
                //             updateProfileModel.contactNumber = val;
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
                //             updateProfileModel.contactNumber = val;
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
                    updateProfileModel.contactPhone=val;
                    // Update the first contact number
                    // contactNumbers.length >= 1
                    //     ? contactNumbers[0] = val
                    //     : contactNumbers.add(val);
                    // updateContactNumber();
                    otherNumber[0] = val;
                  },
                  hint: phoneNumb1.toString().trim(),
                  borderRadius: 10,
                  keyboardType: TextInputType.phone, // Example keyboard type
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4.h),
                ),
                phoneNumb2 != null && phoneNumb2!.isNotEmpty? Row(
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
                        hint: phoneNumb2.toString().trim(),
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
                ): Visibility(
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
                phoneNumb3 != null && phoneNumb3!.isNotEmpty?Row(
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
                        hint: phoneNumb3,
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
                ):Visibility(
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
                            updateProfileModel.whatsAppNumber = contactNumbers.isNotEmpty ? contactNumbers[0] : '';
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
                            updateProfileModel.whatsAppNumber = val;
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
                // Row(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     Flexible(
                //       flex: 9,
                //       child: CustomText(
                //         title: "Social Media Links",
                //         fontWeight: FontWeight.bold,
                //         fontSize: 17,
                //         color: greenColor2, // Replace with your desired color
                //       ),
                //     ),
                //     Flexible(
                //       flex: 1,
                //       child: Custom_Button_Widget(
                //         width: 30,
                //         height: 30,
                //         color: greenColor2,
                //         // Replace with your desired color
                //         ontap: () {
                //           setState(() {
                //             socialMediaLink = true;
                //           });
                //         },
                //         rd: 100,
                //         child: Icon(
                //           Icons.add,
                //           size: 30,
                //           color:
                //           Colors.white, // Replace with your desired color
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // businessModel.email != null ?Padding(
                //   padding: const EdgeInsets.symmetric(vertical: 10),
                //   child: Column(
                //     mainAxisAlignment: MainAxisAlignment.start,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: [
                //       CustomText(
                //           title: "Email Address",
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.sp),
                //       CustomTextFormFieldWidget1(
                //         // controller: emailController,
                //         onChanged: (val) {
                //           updateProfileModel.email = val;
                //         },
                //         hint: businessModel.email,
                //         borderRadius: 10,
                //         // borderSide: BorderSide(width: 2),
                //       ),
                //       CustomText(
                //           title: "Website Address",
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.sp),
                //       CustomTextFormFieldWidget1(
                //         // controller: webController,
                //         onChanged: (val) {
                //            updateProfileModel.weblink = val;
                //         },
                //         hint: businessModel.weblink,
                //         borderRadius: 10,
                //         // borderSide: BorderSide(width: 2),
                //       ),
                //       CustomText(
                //           title: "IOS App Link",
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.sp),
                //       CustomTextFormFieldWidget1(
                //         // controller: iOsController,
                //         onChanged: (val) {
                //          updateProfileModel.iosUrl = val;
                //         },
                //         hint: businessModel.iOsurl,
                //         borderRadius: 10,
                //         // borderSide: BorderSide(width: 2),
                //       ),
                //       CustomText(
                //           title: "Android App Link",
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.sp),
                //       CustomTextFormFieldWidget1(
                //         // controller: androidController,
                //         onChanged: (val) {
                //          updateProfileModel.androidUrl = val;
                //         },
                //         hint: businessModel.androidUrl,
                //         borderRadius: 10,
                //         // borderSide: BorderSide(width: 2),
                //       ),
                //       CustomText(
                //           title: "Fax Number",
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.sp),
                //       CustomTextFormFieldWidget1(
                //         // controller: faxController,
                //         onChanged: (val) {
                //           updateProfileModel.faxNumber = val;
                //         },
                //         hint: businessModel.faxNumber,
                //         borderRadius: 10,
                //         // borderSide: BorderSide(width: 2),
                //       ),
                //       CustomText(
                //           title: "FaceBook Link",
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.sp),
                //       CustomTextFormFieldWidget1(
                //         // controller: faceBookController,
                //         onChanged: (val) {
                //           updateProfileModel.facebookUrl = val;
                //         },
                //         hint: businessModel.facebookUrl,
                //         borderRadius: 10,
                //         // borderSide: BorderSide(width: 2),
                //       ),
                //       CustomText(
                //           title: "Twitter Link",
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.sp),
                //       CustomTextFormFieldWidget1(
                //         // controller: twitterController,
                //         onChanged: (val) {
                //           updateProfileModel.twitterUrl = val;
                //         },
                //         hint: businessModel.twitterUrl,
                //         borderRadius: 10,
                //         // borderSide: BorderSide(width: 2),
                //       ),
                //       CustomText(
                //           title: "Instagram Link",
                //           fontWeight: FontWeight.bold,
                //           fontSize: 15.sp),
                //       CustomTextFormFieldWidget1(
                //         // controller:  instagramController,
                //         onChanged: (val) {
                //           updateProfileModel.instagramUrl = val;
                //         },
                //         hint: businessModel.instagramUrl,
                //         borderRadius: 10,
                //         // borderSide: BorderSide(width: 2),
                //       ),
                //     ],
                //   ),
                // ):Visibility(
                //   visible: socialMediaLink,
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 10),
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.start,
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         CustomText(
                //             title: "Email Address",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15.sp),
                //         CustomTextFormFieldWidget1(
                //           // controller: emailController,
                //           onChanged: (val) {
                //             updateProfileModel.email = val;
                //           },
                //           hint:"Email Address",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //         CustomText(
                //             title: "Website Address",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15.sp),
                //         CustomTextFormFieldWidget1(
                //           // controller: webController,
                //           onChanged: (val) {
                //             updateProfileModel.weblink = val;
                //           },
                //           hint: "Website Link",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //         CustomText(
                //             title: "IOS App Link",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15.sp),
                //         CustomTextFormFieldWidget1(
                //           // controller: iOsController,
                //           onChanged: (val) {
                //             updateProfileModel.iosUrl = val;
                //           },
                //           hint: "IOS App Link",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //         CustomText(
                //             title: "Android App Link",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15.sp),
                //         CustomTextFormFieldWidget1(
                //           // controller: androidController,
                //           onChanged: (val) {
                //             updateProfileModel.androidUrl = val;
                //           },
                //           hint: "Android App Link",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //         CustomText(
                //             title: "Fax Number",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15.sp),
                //         CustomTextFormFieldWidget1(
                //           // controller: faxController,
                //           onChanged: (val) {
                //             updateProfileModel.faxNumber = val;
                //           },
                //           hint: "Fax Number",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //         CustomText(
                //             title: "FaceBook Link",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15.sp),
                //         CustomTextFormFieldWidget1(
                //           // controller: faceBookController,
                //           onChanged: (val) {
                //             updateProfileModel.facebookUrl = val;
                //           },
                //           hint: "FaceBook Link",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //         CustomText(
                //             title: "Twitter Link",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15.sp),
                //         CustomTextFormFieldWidget1(
                //           // controller: twitterController,
                //           onChanged: (val) {
                //             updateProfileModel.twitterUrl = val;
                //           },
                //           hint: "Twitter Link",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //         CustomText(
                //             title: "Instagram Link",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 15.sp),
                //         CustomTextFormFieldWidget1(
                //           // controller:  instagramController,
                //           onChanged: (val) {
                //             updateProfileModel.instagramUrl = val;
                //           },
                //           hint: "Instagram Link",
                //           borderRadius: 10,
                //           // borderSide: BorderSide(width: 2),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
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
                        color: greenColor2,
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: Custom_Button_Widget(
                        width: 30,
                        height: 30,
                        color: greenColor2,
                        ontap: () {
                          setState(() {
                            socialMediaLink = true;
                          });
                        },
                        rd: 100,
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),

                businessModel.email != null ||
                    businessModel.weblink != null ||
                    businessModel.iOsurl != null ||
                    businessModel.androidUrl != null ||
                    businessModel.faxNumber != null ||
                    businessModel.facebookUrl != null ||
                    businessModel.twitterUrl != null ||
                    businessModel.instagramUrl != null?

                Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: "Email Address",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  CustomTextFormFieldWidget1(
                                                    onChanged: (val) {
                                                      updateProfileModel.email = val;
                                                    },
                                                    hint: businessModel.email ?? "Email Address",
                                                    borderRadius: 10,
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: "Website Address",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  CustomTextFormFieldWidget1(
                                                    onChanged: (val) {
                                                      updateProfileModel.weblink = val;
                                                    },
                                                    hint: businessModel.weblink ?? "Website Link",
                                                    borderRadius: 10,
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: "IOS App Link",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  CustomTextFormFieldWidget1(
                                                    onChanged: (val) {
                                                      updateProfileModel.iOsurl = val;
                                                    },
                                                    hint: businessModel.iOsurl ?? "IOS App Link",
                                                    borderRadius: 10,
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: "Android App Link",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  CustomTextFormFieldWidget1(
                                                    onChanged: (val) {
                                                      updateProfileModel.androidUrl = val;
                                                    },
                                                    hint: businessModel.androidUrl ?? "Android App Link",
                                                    borderRadius: 10,
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: "Fax Number",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  CustomTextFormFieldWidget1(
                                                    onChanged: (val) {
                                                      updateProfileModel.faxNumber = val;
                                                    },
                                                    hint: businessModel.faxNumber ?? "Fax Number",
                                                    borderRadius: 10,
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: "FaceBook Link",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  CustomTextFormFieldWidget1(
                                                    onChanged: (val) {
                                                      updateProfileModel.facebookUrl = val;
                                                    },
                                                    hint: businessModel.facebookUrl ?? "FaceBook Link",
                                                    borderRadius: 10,
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: "Twitter Link",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  CustomTextFormFieldWidget1(
                                                    onChanged: (val) {
                                                      updateProfileModel.twitterUrl = val;
                                                    },
                                                    hint: businessModel.twitterUrl ?? "Twitter Link",
                                                    borderRadius: 10,
                                                  ),
                                                ],
                                              ),

                                              Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                    title: "Instagram Link",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 15,
                                                  ),
                                                  CustomTextFormFieldWidget1(
                                                    onChanged: (val) {
                                                      updateProfileModel.instagramUrl = val;
                                                    },
                                                    hint: businessModel.instagramUrl ?? "Instagram Link",
                                                    borderRadius: 10,
                                                  ),
                                                ],
                                              ),
                                          ],
                                        ),
                                      ):

                Visibility(
                  visible: socialMediaLink ,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Email Address",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            CustomTextFormFieldWidget1(
                              onChanged: (val) {
                                updateProfileModel.email = val;
                              },
                              hint: "Email Address",
                              borderRadius: 10,
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Website Address",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            CustomTextFormFieldWidget1(
                              onChanged: (val) {
                                updateProfileModel.weblink = val;
                              },
                              hint: "Website Link",
                              borderRadius: 10,
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "IOS App Link",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            CustomTextFormFieldWidget1(
                              onChanged: (val) {
                                updateProfileModel.iOsurl = val;
                              },
                              hint:"IOS App Link",
                              borderRadius: 10,
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Android App Link",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            CustomTextFormFieldWidget1(
                              onChanged: (val) {
                                updateProfileModel.androidUrl = val;
                              },
                              hint: "Android App Link",
                              borderRadius: 10,
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Fax Number",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            CustomTextFormFieldWidget1(
                              onChanged: (val) {
                                updateProfileModel.faxNumber = val;
                              },
                              hint: "Fax Number",
                              borderRadius: 10,
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "FaceBook Link",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            CustomTextFormFieldWidget1(
                              onChanged: (val) {
                                updateProfileModel.facebookUrl = val;
                              },
                              hint: "FaceBook Link",
                              borderRadius: 10,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Twitter Link",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            CustomTextFormFieldWidget1(
                              onChanged: (val) {
                                updateProfileModel.twitterUrl = val;
                              },
                              hint:"Twitter Link",
                              borderRadius: 10,
                            ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              title: "Instagram Link",
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            CustomTextFormFieldWidget1(
                              onChanged: (val) {
                                updateProfileModel.instagramUrl = val;
                              },
                              hint: "Instagram Link",
                              borderRadius: 10,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ),

                // SizedBox(
                //   height: ScreenUtil().setHeight(20.h),
                // ),
                // Divider(thickness: 2, color: greenColor2),
                //
                // /// Opening And Closing Hours
                // CustomText(
                //     title: "OPENING HOURS",
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20.sp,
                //     color: greenColor2),
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
                // Column(
                //   children: [
                //     // Row(
                //     //   mainAxisAlignment: MainAxisAlignment.end,
                //     //   children: [
                //     //     GestureDetector(
                //     //       onTap: () {
                //     //         setState(() {
                //     //           // Iterate through each day and toggle its checkbox value
                //     //           for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']) {
                //     //             checkBoxValues[day] = checkBoxValues[day] == null ? false : !checkBoxValues[day]!;
                //     //           }
                //     //         });
                //     //       },
                //     //       child: CustomText(
                //     //         title: "Set to All",
                //     //         fontWeight: FontWeight.bold,
                //     //         fontSize: 20.sp,
                //     //         color: greenColor2,
                //     //       ),
                //     //     ),
                //     //   ],
                //     // ),
                //     Column(
                //       children: [
                //         Row(
                //           mainAxisAlignment: MainAxisAlignment.end,
                //           children: [
                //             CustomText(
                //                 title: "",
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20.sp,
                //                 color: greenColor2
                //             ),
                //             // GestureDetector(
                //             //   onTap: () {
                //             //     setState(() {
                //             //       // Iterate through each day and toggle its checkbox value
                //             //       for (var day in checkBoxValues.keys) {
                //             //         checkBoxValues[day] = checkBoxValues[day] == null ? false : !checkBoxValues[day]!;
                //             //       }
                //             //     });
                //             //   },
                //             //   child: CustomText(
                //             //       title: "Set to All",
                //             //       fontWeight: FontWeight.bold,
                //             //       fontSize: 20.sp,
                //             //       color: greenColor2
                //             //   ),
                //             // ),
                //             GestureDetector(
                //               onTap: setAllDaysToMondayTimes, // Call the function when "Set to All" is tapped
                //               child: CustomText(
                //                 title: "Set to All",
                //                 fontWeight: FontWeight.bold,
                //                 fontSize: 20.sp,
                //                 color: greenColor2,
                //               ),
                //             ),
                //           ],
                //         ),
                //         for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])
                //           Padding(
                //             padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                //             child: Column(
                //               children: [
                //                 OpenHoursContainer(
                //                   isChecked: checkBoxValues[day] ?? false,
                //                   customCheckbox: Checkbox(
                //                     onChanged: (value) {
                //                       setState(() {
                //                         checkBoxValues[day] = value!;
                //                       });
                //                     },
                //                     value: checkBoxValues[day] ?? false,
                //                     activeColor: greenColor2,
                //                   ),
                //                   child: CustomText(title: day),
                //                 ),
                //                 SizedBox(height: 20),
                //                 Visibility(
                //                   visible: checkBoxValues[day] ?? false,
                //                   child: Row(
                //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                     children: [
                //                       Expanded(
                //                         child: Container(
                //                           height: 50, // Set a fixed height
                //                           decoration: BoxDecoration(
                //                             color: whiteColor,
                //                             borderRadius: BorderRadius.circular(10),
                //                             boxShadow: const [
                //                               BoxShadow(
                //                                 color: grayColor,
                //                                 blurRadius: 3,
                //                                 spreadRadius: 0.5,
                //                                 offset: Offset(0, 0),
                //                               ),
                //                             ],
                //                           ),
                //                           child: Center(
                //                             child: DropdownButton<String>(
                //                               isExpanded: true, // Ensures dropdown takes full width
                //                               borderRadius: BorderRadius.circular(10),
                //                               underline: const SizedBox(), // Empty SizedBox to replace the underline
                //                               value: selectedOpeningTimes[day],
                //                               items: timeList.map((String value) {
                //                                 return DropdownMenuItem<String>(
                //                                   value: value,
                //                                   child: Padding(
                //                                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //                                     child: Text(value),
                //                                   ),
                //                                 );
                //                               }).toList(),
                //                               onChanged: (String? value) {
                //                                 setState(() {
                //                                   selectedOpeningTimes[day] = value!;
                //                                 });
                //                               },
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                       const SizedBox(width: 10), // Add some spacing between the two Expanded widgets if needed
                //                       Expanded(
                //                         child: Container(
                //                           height: 50, // Set a fixed height
                //                           decoration: BoxDecoration(
                //                             color: whiteColor,
                //                             borderRadius: BorderRadius.circular(10),
                //                             boxShadow: const [
                //                               BoxShadow(
                //                                 color: grayColor,
                //                                 blurRadius: 3,
                //                                 spreadRadius: 0.5,
                //                                 offset: Offset(0, 0),
                //                               ),
                //                             ],
                //                           ),
                //                           child: Center(
                //                             child: DropdownButton<String>(
                //                               isExpanded: true, // Ensures dropdown takes full width
                //                               borderRadius: BorderRadius.circular(10),
                //                               underline: const SizedBox(), // Empty SizedBox to replace the underline
                //                               value: selectedClosingTimes[day],
                //                               items: timeList.map((String value) {
                //                                 return DropdownMenuItem<String>(
                //                                   value: value,
                //                                   child: Padding(
                //                                     padding: const EdgeInsets.symmetric(horizontal: 10.0),
                //                                     child: Text(value),
                //                                   ),
                //                                 );
                //                               }).toList(),
                //                               onChanged: (String? value) {
                //                                 setState(() {
                //                                   selectedClosingTimes[day] = value!;
                //                                 });
                //                               },
                //                             ),
                //                           ),
                //                         ),
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //       ],
                //     ),
                //   ],
                // ),
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
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          child: businessModel.lat == null || businessModel.lng == null
              ? Center(child: CircularProgressIndicator())
              : GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(businessModel.lat!, businessModel.lng!),
              zoom: 15,
            ),
            onMapCreated: (GoogleMapController controller) {
              _mapController = controller;
              setState(() {
                _markers.add(Marker(
                  markerId: MarkerId("business_location"),
                  position: LatLng(businessModel.lat!, businessModel.lng!),
                  infoWindow: InfoWindow(title: "Business Location"),
                ));
              });
            },
            markers: _markers,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
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
                  onChanged: (val) {
                    setState(() {
                      _currentAddress = val;
                    });
                  },
                  hint: _currentAddress,
                  borderRadius: 10,
                ),
                TextButton(onPressed: (){
                  _showPlacePicker();
                }, child: Text("Change Location")),
                // Divider(
                //   color: greenColor2,
                //   thickness: 2,
                // ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     CustomText(
                //         title: "GALLERY",
                //         fontWeight: FontWeight.bold,
                //         fontSize: 20.sp,
                //         color: greenColor2),
                //     TextButton(
                //       onPressed: () {
                //         _showSelectionDialog();
                //       },
                //       child: CustomText(
                //           title: "Select Image",
                //           fontWeight: FontWeight.bold,
                //           decoration: TextDecoration.underline),
                //     ),
                //   ],
                // ),
                // Column(
                //   children: [
                //     Padding(
                //       padding: const EdgeInsets.all(8.0),
                //       child: SizedBox(
                //         height: 180,
                //         // Set the height of your images
                //         width: MediaQuery.of(context).size.width,
                //         child: selectedImagesList!.isEmpty
                //             ? Center(
                //           child:   GestureDetector(
                //             onTap: (){
                //               _showSelectionDialog();
                //             },
                //             child: Card(
                //               elevation: 5,
                //               shape: RoundedRectangleBorder(
                //                 borderRadius: BorderRadius.circular(10), // Adjust the border radius as needed
                //               ),
                //               child: Container(
                //                 height: 180,
                //                 width: MediaQuery.of(context).size.width,
                //                 decoration: BoxDecoration(
                //                   gradient: LinearGradient(
                //                     colors: [Colors.grey,greenColor2],
                //                     begin: Alignment.topLeft,
                //                     end: Alignment.bottomRight,
                //                   ),
                //                   borderRadius: BorderRadius.circular(10), // Same border radius as the Card
                //                 ),
                //                 child: const Padding(
                //                   padding: EdgeInsets.all(16),
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.center,
                //                     crossAxisAlignment: CrossAxisAlignment.center,
                //                     children: [
                //                       Icon(
                //                         Icons.image,
                //                         size: 40,
                //                         color: Colors.white,
                //                       ),
                //                       SizedBox(height: 8),
                //                       Text(
                //                         'There are no images selected. Please select one.',
                //                         style: TextStyle(fontSize: 16, color: Colors.white),
                //                         textAlign: TextAlign.center,
                //                       ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //             ),
                //           ),
                //         )
                //
                //             : ListView.builder(
                //           scrollDirection: Axis.horizontal,
                //           itemCount:
                //           selectedImagesList!.length,
                //           // Add 1 for the "Add Image" option
                //           itemBuilder: (BuildContext context,
                //               int index) {
                //             return Padding(
                //               padding:
                //               const EdgeInsets.all(8.0),
                //               child: ClipRRect(
                //                 borderRadius:
                //                 BorderRadius.circular(
                //                     16.0),
                //                 child: Image.file(
                //                   File(selectedImagesList![
                //                   index]
                //                       .path),
                //                   fit: BoxFit.cover,
                //                   width: 150,
                //                   height: 200,
                //                 ),
                //               ),
                //             );
                //             // }
                //           },
                //         ),
                //       ),
                //     ),
                //   ],
                // ),
                // // decidedImageView(),
                // SizedBox(
                //   height: ScreenUtil().setHeight(10.h),
                // ),
                //
                // /// Register Button Comment
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                //   children: [
                //     Container(
                //       decoration: BoxDecoration(boxShadow: const [
                //         BoxShadow(
                //           color: Colors.grey,
                //           spreadRadius: 1,
                //           blurRadius: 7,
                //           offset: Offset(0, 0),
                //         )
                //       ]),
                //       child: Custom_Button_Widget(
                //         ontap: ()  async{
                //           setState(() {
                //             _isLoading = true;
                //           });
                //
                //           List<String> daysOfWeek = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday"];
                //           List<OpenningHour> modelsForAllDays = [];
                //
                //           for (String day in daysOfWeek) {
                //             OpenningHour model = OpenningHour(
                //               dayOfWeek: day,
                //               openingTime: selectedOpeningTimes[day] ?? "10:00 AM",
                //               closingTime: selectedClosingTimes[day] ?? "10:00 PM",
                //               isOpen: checkBoxValues[day] ?? false, // Check if the day is checked and set isOpen accordingly
                //             );
                //             modelsForAllDays.add(model);
                //           }
                //           updateProfileModel.id = 0;
                //           updateProfileModel.lat = picklat;
                //           updateProfileModel.lng = picklng;
                //           updateProfileModel.address = _currentAddress;
                //           updateProfileModel.openningHours = modelsForAllDays;
                //           try {
                //             ApiResponseReg response = await apiController.registerBusinessPostData(updateProfileModel, context);
                //             if (kDebugMode) {
                //               print("Response status code: ${response.statusCode}");
                //             }
                //             if (kDebugMode) {
                //               print("Response body: ${response.responseBody}");
                //             }
                //
                //             if (response.statusCode == 200) {
                //               // Parse the JSON string into a Dart Map
                //               Map<String, dynamic> jsonResponse = jsonDecode(response.responseBody);
                //
                //               // Extract the value of the 'karobarId' field
                //               int karobarId = jsonResponse['karobarId'];
                //
                //               // Now you can use the karobarId as needed
                //               print('karobarId: $karobarId');
                //
                //               await APIController().uploadImages(karobarId,selectedImagePaths,"https://bopkapi.businessonline.pk/RegisterBusinesses/UploadImage?id=");
                //               // Clear fields and image
                //               setState(() {
                //                 imageFile = File('path/to/default/image.png');
                //                 // Clear other fields here if needed
                //               });
                //               setState(() {});
                //               // clearFields();
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 SnackBar(
                //                   backgroundColor: Colors.transparent,
                //                   elevation: 0,
                //                   duration: Duration(seconds: 3),
                //                   content: Container(
                //                     width: MediaQuery.of(context).size.width * 0.90,
                //                     height: 50,
                //                     decoration: BoxDecoration(
                //                       color: Colors.green,
                //                       borderRadius: BorderRadius.circular(15),
                //                     ),
                //                     child: Align(
                //                       alignment: Alignment.center,
                //                       child: Text(
                //                         "Registration successful",
                //                         style: TextStyle(fontSize: 17),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               );
                //               // Navigator.pop(context);
                //               // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
                //             }
                //             else{
                //               ScaffoldMessenger.of(context).showSnackBar(
                //                 SnackBar(
                //                   duration: Duration(seconds: 3),
                //                   content: Container(
                //                     width: MediaQuery.of(context).size.width * 0.90,
                //                     height: 50,
                //                     decoration: BoxDecoration(
                //                       color: Colors.red,
                //                       borderRadius: BorderRadius.circular(15),
                //                     ),
                //                     child: Align(
                //                       alignment: Alignment.center,
                //                       child: Text(
                //                         "Failed to submit response",
                //                         style: TextStyle(fontSize: 17),
                //                       ),
                //                     ),
                //                   ),
                //                 ),
                //               );
                //             }
                //           }
                //           catch (e) {
                //             print("Error during registration: $e");
                //           } finally {
                //             setState(() {
                //               _isLoading = false;
                //             });
                //           }
                //
                //
                //
                //         },
                //         rd: 10,
                //         color: greenColor2,
                //         width: ScreenUtil().screenWidth / 1.2,
                //         child: CustomText(
                //             title: "Update Profile",
                //             fontWeight: FontWeight.bold,
                //             fontSize: 14,
                //             color: whiteColor),
                //       ),
                //     ),
                //   ],
                // ),
                SizedBox(
                  height: ScreenUtil().setHeight(30.h),
                ),
                Visibility(
                  visible: _isLoading,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Custom_Button_Widget(
                    width: MediaQuery.of(context).size.width / 1.0,
                    ontap: () async {
                           updateProfileModel.karobarId=widget.fkKarobarId;
                           updateProfileModel.lat=picklat;
                           updateProfileModel.lng=picklng;
                           updateProfileModel.address=_currentAddress;
                          try {
                            ApiResponseReg response = await apiController.updateBasicProfile(updateProfileModel, context);
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

                              await APIController().uploadImages(karobarId,selectedImagePaths,"https://bopkapi.businessonline.pk/RegisterBusinesses/UploadImage?id=");
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
                              // Navigator.pop(context);
                              // Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
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

                    rd: 7,
                    color: greenColor2,
                    child: CustomText(
                      title: "Update Your Business",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
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
              businessModel.fkCategoryId = _selectedCategory!.categoryId;
              updateProfileModel.fkCategoryId=_selectedCategory!.categoryId;
            }
          });
        },
        items: [
          DropdownMenuItem<SubCategoryModel>(
            value: null,
            child: Text(
              'Please select a category',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ..._categories.map((SubCategoryModel category) {
            return DropdownMenuItem<SubCategoryModel>(
              value: category,
              child: Text(category.categoryName.toString()),
            );
          }).toList(),
        ],
      ),
    );
  }

  // Widget _buildCategoryDropdown() {
  //   return Container(
  //     width: double.infinity,
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(10.0),
  //       border: Border.all(color: Colors.grey),
  //     ),
  //     child: DropdownButton<SubCategoryModel>(
  //       value: _selectedCategory,
  //       onChanged: (SubCategoryModel? newValue) {
  //         setState(() {
  //           _selectedCategory = newValue;
  //           if (_selectedCategory != null) {
  //             print('Selected category ID: ${_selectedCategory!.categoryId}');
  //             print('Selected category name: ${_selectedCategory!.categoryName}');
  //             updateProfileModel.fkCategoryId = _selectedCategory!.categoryId!.toInt();
  //           }
  //         });
  //       },
  //       items: [
  //         DropdownMenuItem(
  //           value: null,
  //           child: Text(
  //             '  Please select a category',
  //             style: TextStyle(color: Colors.grey),
  //           ),
  //         ),
  //         ..._categories.map<DropdownMenuItem<SubCategoryModel>>((SubCategoryModel category) {
  //           return DropdownMenuItem<SubCategoryModel>(
  //             value: category,
  //             child: Text('  ${category.categoryName ?? ''} '),
  //           );
  //         }).toList(),
  //       ],
  //     ),
  //   );
  // }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      picklat=position.latitude;
      picklng=position.longitude;
      _updateMarkers();

      _getAddressFromLatLng();
      _updateMapLocation();

    });
  }

  void _updateMarkers() {
    _markers.clear();
    if (_currentPosition != null) {
      _markers.add(
        Marker(
          markerId: MarkerId("current_location"),
          position: LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
          infoWindow: InfoWindow(title: "Current Location"),
        ),
      );
    }
  }

  void _updateMapLocation() {
    if (_mapController != null && _currentPosition != null) {
      _mapController!.animateCamera(
        CameraUpdate.newLatLng(
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        ),
      );
    }
  }

  Future<void> _getAddressFromLatLng() async {
    try {
      if (_currentPosition != null) {
        List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition!.latitude,
          _currentPosition!.longitude,
        );

        Placemark place = placemarks[0];
        setState(() {
          _currentAddress = "${place.street}, ${place.locality}, ${place.postalCode}, ${place.country}";
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> _showPlacePicker() async {
    var place = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyCLFYsLuixpirWLa--cSHA3RPwc9-dGprk',
      mode: Mode.overlay,
      types: [],
      strictbounds: false,
      components: [Component(Component.country, 'PK')],
      onError: (err) {
        print(err);
      },
    );

    if (place != null) {
      setState(() {
        _currentAddress = place.description ?? '';
      });

      final plist = GoogleMapsPlaces(
        apiKey: 'AIzaSyCLFYsLuixpirWLa--cSHA3RPwc9-dGprk',
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );

      String placeid = place.placeId ?? "0";
      final detail = await plist.getDetailsByPlaceId(placeid);
      final geometry = detail.result.geometry!;

      setState(() {
        picklat = geometry.location.lat;
        picklng = geometry.location.lng;
      });

      LatLng selectedLatLng = LatLng(picklat!, picklng!);
      _updateMapCamera(selectedLatLng);
      _updateMarkersWithNewPlace(selectedLatLng, place.description!);
    }
  }

  void _updateMapCamera(LatLng position) {
    _mapController!.animateCamera(
      CameraUpdate.newLatLng(position),
    );
  }

  void _updateMarkersWithNewPlace(LatLng position, String description) {
    _markers.clear();
    _markers.add(
      Marker(
        markerId: MarkerId("selected_location"),
        position: position,
        infoWindow: InfoWindow(title: description),
      ),
    );
    setState(() {});
  }


  Future<void> _fetchCategories() async {
    await _controller.fetchHomePageCategories();
    setState(() {
      _categories = _controller.categories
          .where((category) => category.categoryName != null) // Filter out null names
          .toList();
      _initializeSelectedCategory();
    });
  }
  // Future<void> _showChoiceDialoge(BuildContext context) {
  //   return showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: CustomText(title: "Make a Choice!"),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: [
  //               GestureDetector(
  //                 onTap: () {
  //                   _openGallery(context);
  //                 },
  //                 child: CustomText(title: "Gallery"),
  //               ),
  //               Padding(padding: EdgeInsets.all(8.0)),
  //               GestureDetector(
  //                 onTap: () {
  //                   _openCamera(context);
  //                 },
  //                 child: CustomText(title: "Camera"),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // Widget to display the image
  // Widget decidedImageView() {
  //   return Container(
  //     height: 250,
  //     child: FutureBuilder<bool>(
  //       future: imageFile.exists(),
  //       builder: (context, snapshot) {
  //         if (snapshot.hasData && snapshot.data!) {
  //           // If the file exists, display the image
  //           return Image.file(
  //             imageFile,
  //             width: 400,
  //             fit: BoxFit.fill,
  //             scale: 13,
  //           );
  //         } else {
  //           // If the file does not exist, display a placeholder image or message
  //           return Center(child: CustomText(title: "No Image Selected"));
  //         }
  //       },
  //     ),
  //   );
  // }

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
  void updateContactNumber() {
    setState(() {
      // Join the contact numbers with commas
      updateProfileModel.otherNumbers = otherNumber.join(',');

    });
  }
  void updateOwnerName() {
    setState(() {
      // Join the owner names with commas
      updateProfileModel.contactName = ownerNames.join(',');
    });
  }
  void updateSpecialties() {
    setState(() {
      // Join the specialties with commas
      updateProfileModel.speciality = specialties.join(',');
    });
  }
  Future<void> _showSelectionDialog() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Picture'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                GestureDetector(
                  child: const Text('Gallery',style: TextStyle(fontSize: 18),),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final List<XFile> selectedImages =
                    await ImagePicker().pickMultiImage();

                    if (selectedImages != null && selectedImages.isNotEmpty) {
                      setState(() {
                        selectedImagesList!.addAll(selectedImages);

                        // Extract paths from selectedImages and add them to selectedImagePaths
                        selectedImagePaths
                            .addAll(selectedImages.map((image) => image.path));
                      });
                    }
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text('Camera',style: TextStyle(fontSize: 18),),
                  onTap: () async {
                    Navigator.of(context).pop();
                    final XFile? picture = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (picture != null) {
                      setState(() {
                        selectedImagesList!.add(picture);
                        selectedImagePaths.add(picture.path);
                      });
                    }
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
//  uploadImages(int id) async {
//   var request = http.MultipartRequest(
//       'POST',
//       Uri.parse(
//           'https://bopkapi.businessonline.pk/RegisterBusinesses/UploadImage?id=$id'));
//
//   for (var i = 0; i < selectedImagePaths.length; i++) {
//     print("hamad ${selectedImagePaths[i]}");
//     // Add each image to the request
//     File imageFile = File(selectedImagePaths[i]);
//     request.files.add(await http.MultipartFile.fromPath(
//         'files', imageFile.path,
//         filename: 'image_$i.jpg'));
//   }
//
//   try {
//     http.StreamedResponse response = await request.send();
//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       print(await response.stream.bytesToString());
//     } else {
//       print(response.reasonPhrase);
//     }
//   } catch (e) {
//     print('Error uploading images: $e');
//   }
// }
}