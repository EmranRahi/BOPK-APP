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
import 'package:intl/intl.dart';
import '../Controllers/Api_Controller.dart';
import '../Controllers/BopkController.dart';
import '../model/HomePageMainCategory.dart';
import '../model/OpeningAndClosingTimeModel.dart';
import '../model/RegisterYourBusinessModel.dart';
import 'HomePage_ofBopk.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'menu_login.dart';
import 'package:http/http.dart' as http;
import 'mobile_shops.dart';
import 'package:image_picker/image_picker.dart';

class RegisterYourBusiness extends StatefulWidget {
  const RegisterYourBusiness({super.key});

  @override
  State<RegisterYourBusiness> createState() => _RegisterYourBusinessState();
}

class _RegisterYourBusinessState extends State<RegisterYourBusiness> {



  OpeningAndClosingTimeModel openingAndClosingTimeModel = OpeningAndClosingTimeModel();
  final List<String> timeList = const [
    '09:00AM',
    '10:00AM',
    '11:00AM',
    '12:00PM',
    '01:00PM',
    '02:00PM',
    '03:00PM',
    '04:00PM',
    '05:00PM',
    '06:00PM',
    '07:00PM',
    '08:00PM',
    '09:00PM',
    '10:00PM',
    '11:00PM',
    '12:00PM',
  ].toSet().toList(); // Remove duplicates and convert to a list


  // void updateAllCheckboxes(bool value) {
  //   setState(() {
  //     val = value;
  //     val1 = value;
  //     val2 = value;
  //     val3 = value;
  //     val4 = value;
  //     val5 = value;
  //     val6 = value;
  //   });
  // }


// Define variables to hold selected values
  String? selectedOpeningTime;
  String? selectedClosingTime;
  Map<String, String?> selectedOpeningTimes = {}; // Map to store selected opening times for each day
  Map<String, String?> selectedClosingTimes = {}; // Map to store selected closing times for each day
  Map<String, bool> checkBoxValues = {}; // Map to store checkbox values for each day

// Update onChanged callback for both DropdownButtons
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

  void sendDataToServer(List<OpeningAndClosingTimeModel> models) {
    if (models.isNotEmpty) {
      // Call the controller function to send data to the server
      APIController.openingAndClosingPostData(models).then((response) {
        // Handle the response from the server
        // For example, show a success message or update UI accordingly
      }).catchError((error) {
        // Handle error
        print('Error: $error');
      });
    } else {
      // Handle case when the list is empty
      print('No data to send.');
    }
  }

  List<String> items = [
    'Select report category',
    'Nudity',
    'Spam',
    'False news'
  ];
  String selectedValue = 'Select report category';
  // String selectedCategory = "";
  List<String> businessCategories = [
    // 'Category 1',
    // 'Category 2',
    // 'Category 3',
    // 'Category 4',
    // 'Category 5',
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
  bool checkTime = false; // Initial state of the checkbox

  // social media link
  bool socialMediaLink = false; // Initial state of the checkbox


  TextEditingController categoryController = TextEditingController();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  /// SpecialityController
  TextEditingController specialityController1 = TextEditingController();
  TextEditingController specialityController2 = TextEditingController();
  TextEditingController specialityController3 = TextEditingController();
  TextEditingController specialityController4 = TextEditingController();
  /// ownerNameController
  TextEditingController ownerNameController1 = TextEditingController();
  TextEditingController ownerNameController2 = TextEditingController();
  TextEditingController ownerNameController3 = TextEditingController();
  TextEditingController ownerNameController4 = TextEditingController();
  /// ContactNumber Controller
  TextEditingController contactNumController1 = TextEditingController();
  TextEditingController contactNumController2 = TextEditingController();
  TextEditingController contactNumController3 = TextEditingController();
  TextEditingController contactNumController4 = TextEditingController();
  /// Other Field Controller
  TextEditingController whatsAppController = TextEditingController();
  TextEditingController searchController = TextEditingController();
  /// Social Media Controller
  TextEditingController emailController = TextEditingController();
  TextEditingController iOsController = TextEditingController();
  TextEditingController androidController = TextEditingController();
  TextEditingController faxController = TextEditingController();
  TextEditingController faceBookController = TextEditingController();
  TextEditingController webController = TextEditingController();
  TextEditingController twitterController = TextEditingController();
  TextEditingController instagramController = TextEditingController();


  TextEditingController addressController = TextEditingController();
  RegisterYourBusinessModel registerYourBusinessModel = RegisterYourBusinessModel();
  final BopkController _controller = BopkController();
  HomePageMainCategory? selectedCategory; // Variable to hold the selected category

  @override
  void initState() {
    super.initState();
    // categoryController.text = selectedCategory;
    _fetchCategories();
  }
  Future<void> _fetchCategories() async {
    await _controller.fetchHomePageCategories();
    setState(() {}); // Update the UI after fetching categories
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
  Future<void> uploadImage(int id) async {
    // Check if an image is selected
    if (imageFile == null) {
      print('No image selected.');
      return;
    }
    try {
      // Create a multipart request
      var request = http.MultipartRequest(
          'POST',
          Uri.parse('http://144.91.86.203/bopkapi/api/RegisterImage/UploadImages')
      );
      // Add the query parameters directly to the URI
      request.fields['KId'] = id.toString();
      // Add the image file to the request
      request.files.add(
          await http.MultipartFile.fromPath('file', imageFile!.path)
      );
      // Send the request
      var response = await request.send();
      // Check the response status code
      if (response.statusCode == 200) {
        // If successful, print the response
        print('Image uploaded successfully');
        print(await response.stream.bytesToString());
      } else {
        // If not successful, print the error status code and reason
        print('Failed to upload image. Error: ${response.statusCode}');
        print(await response.stream.bytesToString());
      }
    } catch (e) {
      // Catch any exceptions that occur during the request
      print('Error uploading image: $e');
    }
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


  List<OpeningAndClosingTimeModel> modelsForAllDays = [];
  DateFormat formatter = DateFormat('HH:mm'); // Format for hours and minutes


  APIController apiController = APIController();


  @override
  Widget build(BuildContext context) {
    String defaultValue = '10:00AM'; // Set your default value
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
                /// How to Register business? Button
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
                  controller: titleController,
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
                  style: TextStyle(color: Colors.grey),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
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
                  controller: descriptionController,
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
                  controller: specialityController1,
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
                          controller: specialityController2,
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
                          controller: specialityController3,
                          onChanged: (val) {
                            // registerYourBusinessModel.speciality = val;
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
                          controller: specialityController4,
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
                  controller: ownerNameController1,
                  onChanged: (val) {
                    // ownerNameController1.text=val;
                    registerYourBusinessModel.contactName=val;
                  },
                  hint: "Owner Name1 ",
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
                          controller: ownerNameController2,
                          onChanged: (val) {
                            // ownerNameController2.text=val;
                            registerYourBusinessModel.contactName=val;
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
                          controller: ownerNameController3,
                          onChanged: (val) {
                            // ownerNameController3.text=val;
                            registerYourBusinessModel.contactName=val;
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
                          controller: ownerNameController4,
                          onChanged: (val) {
                            // ownerNameController4.text=val;
                            registerYourBusinessModel.contactName=val;
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
                  controller: contactNumController1,
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
                          controller: contactNumController2,
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
                          controller: contactNumController3,
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
                          controller: contactNumController4,
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
                          controller: whatsAppController,
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
                          controller: emailController,
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
                          controller: webController,
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
                          controller: iOsController,
                          onChanged: (val) {
                            registerYourBusinessModel.iOsurl = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Android App Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          controller: androidController,
                          onChanged: (val) {
                            registerYourBusinessModel.androidUrl = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Fax Number",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          controller: faxController,
                          onChanged: (val) {
                            registerYourBusinessModel.faxNumber = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "FaceBook Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          controller: faceBookController,
                          onChanged: (val) {
                            registerYourBusinessModel.facebookUrl = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Twitter Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          controller: twitterController,
                          onChanged: (val) {
                            registerYourBusinessModel.twitterUrl = val;
                          },
                          hint: "Optional",
                          borderRadius: 10,
                          borderSide: BorderSide(width: 2),
                        ),
                        CustomText(
                            title: "Instagram Link",
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp),
                        CustomTextFormFieldWidget(
                          controller:  instagramController,
                          onChanged: (val) {
                            registerYourBusinessModel.instagramUrl = val;
                          },
                          hint: "Optional",
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
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              // Iterate through each day and set its checkbox value to true
                              for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']) {
                                checkBoxValues[day] = checkBoxValues[day] == null ? false : !checkBoxValues[day]!;
                              }
                            });
                          },
                          child: CustomText(
                              title: "Set to All",
                              fontWeight: FontWeight.bold,
                              fontSize: 20.sp,
                              color: greenColor2
                          ),
                        ),
                      ],
                    ),

                    // SizedBox(
                    //   height: ScreenUtil().setHeight(20.h),
                    // ),
                    for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                        child: Column(
                          children: [
                            OpenHoursContainer(
                              isChecked: true,
                              customCheckbox: Checkbox(
                                onChanged: (value) {
                                  setState(() {
                                    checkBoxValues[day] = value!;
                                    print('Checkbox value changed: $value');
                                  });
                                },
                                value: checkBoxValues[day] ?? false,
                                activeColor: greenColor2,
                              ),
                              child:  CustomText(title: day),
                            ),
                            // Text(day),
                            SizedBox(height: 08,),
                            Visibility(
                              visible: checkBoxValues[day] ?? false,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width/3.5,
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: grayColor,
                                            blurRadius: 7,
                                            spreadRadius: 1,
                                            offset: Offset(0,0),
                                          )
                                        ]
                                    ),
                                    child: Center(
                                      child: DropdownButton<String>(

                                        borderRadius: BorderRadius.circular(10),
                                        underline: Text(""),
                                        value:  selectedOpeningTimes[day] ?? timeList.first,
                                        items: timeList.map((String value) {
                                          return DropdownMenuItem<String>(

                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedOpeningTimes[day] = value;
                                          });
                                        },
                                      ),
                                    ),
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/3.5,
                                    decoration: BoxDecoration(
                                        color: whiteColor,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow:const [
                                          BoxShadow(
                                            color: grayColor,
                                            blurRadius: 7,
                                            spreadRadius: 1,
                                            offset: Offset(0,0),
                                          )
                                        ]
                                    ),
                                    child: Center(
                                      child: DropdownButton<String>(
                                        borderRadius: BorderRadius.circular(10),
                                        underline: Text(""),
                                        value: selectedClosingTimes[day] ?? timeList.first,
                                        items: timeList.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          setState(() {
                                            selectedClosingTimes[day] = value;
                                          });
                                        },
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
                /// end OF Open And Close hour
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                Divider(thickness: 2, color: greenColor2),
                // CustomText(
                //     title: "LOCATION",
                //     fontWeight: FontWeight.bold,
                //     fontSize: 20.sp,
                //     color: greenColor2),
                SizedBox(
                  height: ScreenUtil().setHeight(20.h),
                ),
                // CustomText(
                //     title: "Area Name*",
                //     fontWeight: FontWeight.bold,
                //     fontSize: 14.sp,
                // ),
                // CustomTextFormFieldWidget(
                //     // onChanged: (val){
                //     //   registerYourBusinessModel.a = val;
                //     // },
                //
                //     hint: "Search Location",
                //     borderRadius: 10),
                SizedBox(height: ScreenUtil().setHeight(4.h)),
                Image.asset('assets/images/bopk1.png'),
                SizedBox(
                  height: ScreenUtil().setHeight(10.h),
                ),
                CustomText(
                  title: "Address...",
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
                CustomTextFormFieldWidget(
                  controller: addressController,
                    onChanged: (val) {
                      registerYourBusinessModel.address = val;
                    },
                    hint: "Address",
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
                      decoration: BoxDecoration(boxShadow: [
                        BoxShadow(
                          color: Colors.grey,
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        )
                      ]),
                      child: Custom_Button_Widget(
                        ontap: ()  async{
                          print("click");
                          registerYourBusinessModel.karobarId = 0;
                          registerYourBusinessModel.lat = 0.0;
                          registerYourBusinessModel.lng = 0.0;
                          registerYourBusinessModel.location = Location();
                          registerYourBusinessModel.location?.locationId = 0;
                          registerYourBusinessModel.location?.locationName = "";
                          registerYourBusinessModel.location?.locLat = 0.0;
                          registerYourBusinessModel.location?.locLng = 0.0;
                          // APIController.registerBusinessPostData(registerYourBusinessModel, context);
                          apiController.registerBusinessPostData(registerYourBusinessModel, context);
                          int id = 1;
                          await uploadImage(id);


                          // Clear fields and image
                          setState(() {
                            imageFile = File('path/to/default/image.png');
                            // Clear other fields here if needed
                          });
                          setState(() {});
                          sendDataForAllDays();
                          clearFields();
                        },
                        rd: 10,
                        color: greenColor2,
                        width: ScreenUtil().screenWidth / 3,
                        child: CustomText(
                            title: "Register your Business",
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: whiteColor),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
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

  // void _showCategoryList(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Text("Select a Business Category"),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 TextField(
  //                   controller: searchController,
  //                   decoration: InputDecoration(
  //                     labelText: "Search Category",
  //                     prefixIcon: Icon(Icons.search),
  //                   ),
  //                   onChanged: (text) {
  //                     setState(() {
  //                       // Filter the categories based on the search text
  //                       businessCategories = businessCategories
  //                           .where((category) => category
  //                               .toLowerCase()
  //                               .contains(text.toLowerCase()))
  //                           .toList();
  //                     });
  //                   },
  //                 ),
  //                 Expanded(
  //                   child: ListView(
  //                     shrinkWrap: true,
  //                     children: businessCategories.map((category) {
  //                       return ListTile(
  //                         title: Text(category),
  //                         onTap: () {
  //                           setState(() {
  //                             selectedCategory = category;
  //                             categoryController.text = selectedCategory;
  //                           });
  //                           Navigator.of(context).pop();
  //                         },
  //                       );
  //                     }).toList(),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           );
  //         },
  //       );
  //     },
  //   );
  // }
  void sendDataForAllDays() {
    List<String> daysOfWeek =
    ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday",];
    List<OpeningAndClosingTimeModel> modelsForAllDays = [];
    for (String day in daysOfWeek) {
      OpeningAndClosingTimeModel model = OpeningAndClosingTimeModel(
        id: 0, // You may need to adjust this according to your model
        dayOfWeek: day,
        openingTime: selectedOpeningTimes[day] ?? "default open time", // Replace "" with default value if needed
        closingTime: selectedClosingTimes[day] ?? "default close time", // Replace "" with default value if needed
        isOpen:   false, // _getIsOpenForDay(day), // Checkbox value for each day
        fkKarobarId: 0, // You may need to adjust this according to your model
        is24Hour: false, // You may need to adjust this according to your model
      );
      modelsForAllDays.add(model);
    }

    // Send data to the server
    sendDataToServer(modelsForAllDays);
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
                        if (_controller.categories != null) {
                          businessCategories = (_controller.categories = _controller.categories!
                              .where((category) =>
                          category.mainCategoryName != null &&
                              category.mainCategoryName!
                                  .toLowerCase()
                                  .contains(text.toLowerCase()))
                              .toList()).cast<String>();
                          print(_controller.categories = _controller.categories);
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Builder(
                      builder: (BuildContext context) {
                        if (_controller.categories == null ||
                            _controller.categories!.isEmpty) {
                          return Center(
                            child: Text("No categories available"),
                          );
                        } else {
                          return ListView(
                            shrinkWrap: true,
                            children: _controller.categories!.map((category) {
                              return ListTile(
                                title: Text(category.mainCategoryName ?? ''),
                                onTap: () {
                                  print(category.mainCategoryName);
                                  setState(() {
                                    categoryController.text = category.mainCategoryName.toString() ;
                                  });
                                  Navigator.of(context).pop();
                                },
                                selected: category.mainCategoryName == defaultCategory,
                              );
                            }).toList(),
                          );
                        }
                      },
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
  void clearFields() {
    titleController.clear();
    descriptionController.clear();
    specialityController1.clear();
    specialityController2.clear();
    specialityController3.clear();
    specialityController4.clear();
    ownerNameController1.clear();
    ownerNameController2.clear();
    ownerNameController3.clear();
    ownerNameController4.clear();
    contactNumController1.clear();
    contactNumController2.clear();
    contactNumController3.clear();
    contactNumController4.clear();
    whatsAppController.clear();
    iOsController.clear();
    androidController.clear();
    faxController.clear();
    webController.clear();
    faceBookController.clear();
    instagramController.clear();
    twitterController.clear();
    addressController.clear();
  }



  }
