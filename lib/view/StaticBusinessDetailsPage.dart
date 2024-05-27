import 'package:auto_size_text/auto_size_text.dart';
import 'package:businessonlinepk/Controllers/Api_Controller.dart';
import 'package:businessonlinepk/model/ContactUs_Model.dart';
import 'package:businessonlinepk/model/RegisterReviewRattingModel.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/product_deatils_screen/product_details.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:photo_view/photo_view.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/DetailStaticBusinessModel.dart';
import '../model/DetailsPageProductModel.dart';
import '../model/DisplayReviewModel.dart';
import '../model/OpenningHour.dart';
import 'AllProductsScreen.dart';
import 'AllReviewsScreen.dart';
import 'menu_login.dart';

class StaticBusinessDetailsPage extends StatefulWidget {
  StaticBusinessDetailsPage(
    this.karobarId,
    this.title,
  );

  int? karobarId = 0;
  String? title = "";

  @override
  State<StaticBusinessDetailsPage> createState() =>
      _StaticBusinessDetailsPageState();
}

class _StaticBusinessDetailsPageState extends State<StaticBusinessDetailsPage>
    with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ContactUsModel contactUsModel = ContactUsModel(user: User());
  RegisterReviewModel _reviewModel = RegisterReviewModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  /// contact us Controller
  TextEditingController nameForContactus = TextEditingController();
  TextEditingController emailForContactus = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late GoogleMapController myController;
  LatLng? _center;

  void _onMapCreated(GoogleMapController controller) {
    myController = controller;
  }
  List<OpenningHour> openningHours = [];
  List<bool> checkboxValues =
      List.generate(30, (index) => false); // 30 checkboxess
  DetailStaticBusinessModel? businessModel = DetailStaticBusinessModel();
  List<String> items = [
    'Select report category',
    'Nudity',
    'Spam',
    'False news'
  ];
  String selectedValue = 'Select report category';

  late Future<List<DisplayReviewModel>> futureReviews;

   late TabController _tabController;
  String? phoneNumb1 = "";
  String? phoneNumb2 = "";
  String? phoneNumb3 = "";
  String? phoneNumb4 = "";
  int specialtyCount =0;
  double totalHeight=0;
  String? contact1 = "";
  String? contact2 = "";
  String? contact3 = "";
  String? contact4 = "";
  bool showFullText = false;
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  /// products List
  late List<DetailsPageProductModel> _products = [];

  Future<void> _fetchProducts() async {
    try {
      List<DetailsPageProductModel> products =
          await APIController.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (error) {
      print('Error fetching products: $error');
      // Handle error
    }
  }

  bool _isAboutTabSelected = false;

  double height = 110; // Initial default height
  void _handleTabChange() {
    _updateHeight(_tabController.index);
  }

  void _handleTabTap(int index) {
    _tabController.animateTo(index);
  }

  void _updateHeight(int index) {
    setState(() {
      if (index == 0) {
        height = 110; // Height for index 0
      } else if (index == 1) {
        height = 400; // Height for index 1
      } else if (index == 2) {
        height = 500; // Height for index 2
      } else if (index == 3) {
        height = 480; // Height for index 3
      } else if (index == 4) {
        height = 400; // Height for index 4
      } else if (index == 5) {
        height = 430; // Height for index 5
      } else {
        height = 480; // Default height for other indices
      }
      _isAboutTabSelected = _tabController.index == 3;
      print(index);
    });
  }
  // void _handleTabTap(int index) {
  //   setState(() {
  //     if (index == 0) {
  //       height = 250; // Height for index 0
  //     } else if (index == 1) {
  //       height = 400; // Height for index 2
  //     } else if (index == 2) {
  //       height = 260; // Height for index 2
  //     } else if (index == 3) {
  //       height = 480; // Height for index 2
  //     } else if (index == 4) {
  //       height = 400; // Height for index 2
  //     } else if (index == 5) {
  //       height = 430; // Height for index 2
  //     } else {
  //       height = 480; // Default height for other indices
  //       _isAboutTabSelected = _tabController.index == 6;
  //     }
  //     print(index);
  //   });
  // }

  Future<void> getDetails(int? karobarId) async {
    APIController controller = APIController();
    businessModel = await controller.fetchDataDetails(karobarId);

    if (businessModel != null && businessModel!.lat != null && businessModel!.lng != null) {
      _center = LatLng(
        businessModel!.lat!.toDouble(),
        businessModel!.lng!.toDouble(),
      );
      if (businessModel?.openningHours == null || businessModel!.openningHours!.isEmpty) {
        setDefaultOpenningHours();
        print("gggggggggggggggggg" + openningHours.toString());
      } else {
        openningHours = businessModel!.openningHours!;
        print("hhhhhhhhhhmmmmmmmmm" + openningHours.length.toString());
      }
      setState(() {}); // Rebuild the widget tree to reflect the updated _center value

      // Specialty code
      specialtyCount = businessModel?.speciality?.split(',').length ?? 0;
      // double baseHeight =50.0; // Base height for one item, adjust as needed
      // totalHeight = baseHeight * (specialtyCount > 4 ? 4 : specialtyCount);
    } else {
      // Handle the case where businessModel or its properties are null
    }

    List<String>? phoneNumbers = businessModel?.otherNumbers?.split(',');
    if (phoneNumbers != null && phoneNumbers.length >= 2) {
      phoneNumb1 = phoneNumbers[0];
      phoneNumb2 = phoneNumbers[1];
      phoneNumb3 = phoneNumbers[2];
    }

    List<String>? ownerName = businessModel?.contactName?.split(',');
    if (ownerName != null && ownerName.length >= 3) {
      contact1 = ownerName[0];
      contact2 = ownerName[1];
      contact3 = ownerName[2];
      contact4 = ownerName[3];
    }
  }

   setDefaultOpenningHours() {
    openningHours = [
      OpenningHour(dayOfWeek: 'Monday', openingTime: '10:00 AM', closingTime: '10:00 PM'),
      OpenningHour(dayOfWeek: 'Tuesday', openingTime: '10:00 AM', closingTime: '10:00 PM'),
      OpenningHour(dayOfWeek: 'Wednesday', openingTime: '10:00 AM', closingTime: '10:00 PM'),
      OpenningHour(dayOfWeek: 'Thursday', openingTime: '10:00 AM', closingTime: '10:00 PM'),
      OpenningHour(dayOfWeek: 'Friday', openingTime: '10:00 AM', closingTime: '10:00 PM'),
      OpenningHour(dayOfWeek: 'Saturday', openingTime: '10:00 AM', closingTime: '10:00 PM'),
      OpenningHour(dayOfWeek: 'Sunday', openingTime: '10:00 AM', closingTime: '10:00 PM'),
    ];
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails(widget.karobarId);
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_handleTabChange);
    // _tabController.addListener(_handleTabSelection);
    _fetchProducts();
    futureReviews = APIController().fetchReviews(widget.karobarId!.toInt());  // Use the appropriate ID
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    futureReviews = APIController().fetchReviews(widget.karobarId!.toInt());
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
      key: _scaffoldKey,
      appBar: customAppBar1(
        backgroundColor: Color(0xffE4E4E4),
        elevation: 0,
        centerTitle: false,
        title: CustomText(
          title: widget.title ?? 'Mobile Shops',
          color: grayColor,
          fontSize: 16,
          googleFont: "Jost",
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: greenColor2,
              size: 30,
            )),
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
      body: SingleChildScrollView(
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Custom_Button_Widget(
                    width: MediaQuery.of(context).size.width / 1.0,
                    ontap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MenuLogin()));
                    },
                    rd: 7,
                    color: greenColor2,
                    child: CustomText(
                      title: "Login to Manage the business",
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: whiteColor,
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                      width: MediaQuery.of(context).size.width,
                      child: _center != null
                          ? GoogleMap(
                              onMapCreated: _onMapCreated,
                              initialCameraPosition: CameraPosition(
                                target: _center!,
                                // Use null check operator (!) to access non-nullable LatLng value
                                zoom: 14.0,
                              ),
                              markers: <Marker>{
                                Marker(
                                  markerId: MarkerId('Exact Location'),
                                  position: _center!,
                                  infoWindow:
                                      InfoWindow(title: 'Exact Location'),
                                ),
                              },
                            )
                          : Center(
                              child: CircularProgressIndicator(),
                            ),
                    ),
                    Positioned(
                      top: 130.h,
                      left: 8.w,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: businessModel != null &&
                                    businessModel!.images != null &&
                                    businessModel!.images!.isNotEmpty &&
                                    businessModel!.images![0].imageName !=
                                        null &&
                                    businessModel!
                                        .images![0].imageName!.isNotEmpty
                                ? CircleAvatar(
                                    radius: 30, // Radius of 30
                                    backgroundImage: NetworkImage(
                                      "https://businessonline.pk/Image/Business/Gallery/${businessModel!.karobarId}/${businessModel!.images![0].imageName}", // Assuming there's always at least one image in the first item
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 30, // Radius of 30
                                    backgroundImage: AssetImage(
                                      'assets/images/bopk1.png', // Path to your default image asset
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),

                    Positioned(
                      top: 185,
                      left: 80,
                      child: CustomText(
                        title: businessModel?.title ?? "",
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Colors.black,
                        maxLine: 2,
                      ),
                    ),
                    Positioned(
                      top: 200,
                      left: 80,
                      child: RatingBar.builder(
                        itemSize: 20,
                        initialRating: 0,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: true,
                        itemCount: 5,
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        onRatingUpdate: (rating) {
                          print(rating);
                        },
                      ),
                    ),

                    /// Navigation images comment for play store
                    Positioned(
                      top: 190.h,
                      left: 60.w,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          businessModel?.whatsAppNumber == null
                              ? CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {},
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child: Image.asset(
                                      'assets/images/navigation1.png'),
                                )
                              : CustomContainer(
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
                          businessModel?.contactPhone == null
                              ? CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {
                                    print(businessModel?.contactPhone);
                                    if (businessModel?.contactPhone != null) {
                                      String phoneUrl =
                                          'tel:${businessModel!.contactPhone}';
                                      launchUrl(Uri.parse(phoneUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child: Image.asset('assets/images/call1.png'))
                              : CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {
                                    print(businessModel?.contactPhone);
                                    if (businessModel?.contactPhone != null) {
                                      String phoneUrl =
                                          'tel:${businessModel?.contactPhone?.replaceAll(',', '')}';
                                      launchUrl(Uri.parse(phoneUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child: Image.asset('assets/images/call.png')),
                          SizedBox(width: 5.w),
                          businessModel?.whatsAppNumber == ""
                              ? CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {},
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child: Image.asset('assets/images/sms1.png'))
                              : CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {},
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child: Image.asset('assets/images/sms.png')),
                          SizedBox(width: 5.w),
                          businessModel?.contactPhone == null
                              ? CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {
                                    print(businessModel?.contactPhone);
                                    // String whatsappUrl = 'https://wa.me/+1${businessModel!.whatsAppNumber}';
                                    if (businessModel?.whatsAppNumber != null) {
                                      String whatsappUrl =
                                          'https://wa.me/+1${businessModel!.whatsAppNumber}';
                                      launchUrl(Uri.parse(whatsappUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child:
                                      Image.asset('assets/images/whtsapp1.png'),
                                )
                              : CustomContainer(
                                  height: 40,
                                  width: 40,
                                  ontap: () {
                                    print(businessModel?.contactPhone);
                                    // String whatsappUrl = 'https://wa.me/+1${businessModel!.whatsAppNumber}';
                                    if (businessModel?.whatsAppNumber != null) {
                                      String whatsappUrl =
                                          'https://wa.me/+1${businessModel!.whatsAppNumber}';
                                      launchUrl(Uri.parse(whatsappUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: whiteColor,
                                  boxShadow: true,
                                  child:
                                      Image.asset('assets/images/whtsapp.png')),
                          SizedBox(width: 5.w),
                          CustomContainer(
                            height: 40,
                            width: 40,
                            ontap: () {
                              // whatsapp();
                              String shareData =
                                  "${businessModel!.title}\n${businessModel!.description}\n${businessModel!.speciality!
                                          .replaceAll(',', '')}\n${businessModel!.contactPhone!
                                          .replaceAll(',', '')}\n${businessModel!.contactName!
                                          .replaceAll(',', '')}\n${businessModel!.address!}\n${businessModel!.url}";
                              _shareData(shareData);
                            },
                            rd: 100,
                            color: whiteColor,
                            boxShadow: true,
                            child: Image.asset('assets/images/share.png'),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Column(
                    children: [
                      Divider(
                        thickness: 1,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(children: [
                          /// comment for play store
                          // CustomContainer(
                          //   height: 50.h,
                          //   width: 50,
                          //   ontap: () {},
                          //   rd: 100,
                          //   color: Colors.transparent,
                          //   // boxShadow: true,
                          //   child: Image.asset('assets/media/gallery1.png',
                          //       scale: 3),
                          // ),
                          businessModel?.email == ""
                              ? CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.email != null) {
                                      launchUrl(Uri.parse(
                                          'mailto:${businessModel!.email}'));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/mesage.png',
                                      scale: 2),
                                )
                              : CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.email != null) {
                                      launchUrl(Uri.parse(
                                          'mailto:${businessModel!.email}'));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/mesage.png',
                                      scale: 2),
                                ),

                          ///  comment for play store
                          // CustomContainer(
                          //   height: 50,
                          //   width: 50,
                          //   ontap: () {},
                          //   rd: 100,
                          //   color: Colors.transparent,
                          //   // boxShadow: true,
                          //   child: Image.asset('assets/media/share1.png',
                          //       scale: 2),
                          // ),
                          /// this is the facebook URL
                          businessModel?.facebookUrl == null
                              ? CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.facebookUrl != null) {
                                      String facebookUrl =
                                          'https://www.facebook.com/${businessModel!.facebookUrl}';
                                      launchUrl(Uri.parse(facebookUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset(
                                    'assets/media/facebook.png',
                                  ),
                                )
                              : CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.facebookUrl != null) {
                                      String facebookUrl =
                                          'https://www.facebook.com/${businessModel!.facebookUrl}';
                                      launchUrl(Uri.parse(facebookUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset(
                                    'assets/media/facebook.png',
                                  ),
                                ),

                          /// this is the YouTube URl
                          businessModel?.youtubeUrl == null
                              ? CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.youtubeUrl != null) {
                                      String youtubeUrl =
                                          'https://www.youtube.com/${businessModel!.youtubeUrl}';
                                      launchUrl(Uri.parse(youtubeUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/youtub.png',
                                      scale: 2.1),
                                )
                              : CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.youtubeUrl != null) {
                                      String youtubeUrl =
                                          'https://www.youtube.com/${businessModel!.youtubeUrl}';
                                      launchUrl(Uri.parse(youtubeUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/youtub.png',
                                      scale: 2.1),
                                ),

                          /// this is the Twitter URl
                          businessModel?.twitterUrl == null
                              ? CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.twitterUrl != null) {
                                      String twitterUrl =
                                          'https://twitter.com/${businessModel!.twitterUrl}';
                                      launchUrl(Uri.parse(twitterUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/twitte.png',
                                      scale: 3),
                                )
                              : CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.twitterUrl != null) {
                                      String twitterUrl =
                                          'https://twitter.com/${businessModel!.twitterUrl}';
                                      launchUrl(Uri.parse(twitterUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/twitte.png',
                                      scale: 3),
                                ),

                          /// this is the instagram URL
                          businessModel?.instagramUrl == null
                              ? CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.instagramUrl != null) {
                                      String instagramUrl =
                                          'https://www.instagram.com/${businessModel!.instagramUrl}';
                                      launchUrl(Uri.parse(instagramUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/insta.png',
                                      scale: 2.1),
                                )
                              : CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.instagramUrl != null) {
                                      String instagramUrl =
                                          'https://www.instagram.com/${businessModel!.instagramUrl}';
                                      launchUrl(Uri.parse(instagramUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/insta.png',
                                      scale: 2.1),
                                ),

                          /// this is the linkedIn URL
                          businessModel?.linkedInUrl == null
                              ? CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.linkedInUrl != null) {
                                      String linkedinUrl =
                                          'https://www.linkedin.com/in/${businessModel!.linkedInUrl}';
                                      launchUrl(Uri.parse(linkedinUrl));
                                    }
                                  },
                                  rd: 100,
                                  color: Colors.transparent,
                                  // boxShadow: true,
                                  child: Image.asset('assets/media/linke.png',
                                      scale: 3.1),
                                )
                              : CustomContainer(
                                  height: 50,
                                  width: 50,
                                  ontap: () {
                                    if (businessModel?.linkedInUrl != null) {
                                      String linkedinUrl =
                                          'https://www.linkedin.com/in/${businessModel!.linkedInUrl}';
                                      launchUrl(Uri.parse(linkedinUrl));
                                    }
                                  },
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
                                  title: businessModel?.title
                                          ?.replaceAll(',', '') ??
                                      "businessName",
                                  fontWeight: FontWeight.bold,
                                  googleFont: "Jost",
                                  fontSize: 16.sp),
                              SizedBox(
                                height: 6,
                              ),
                              Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      (contact1 != null && contact1!.isNotEmpty)
                                          ? Flexible(
                                        child: CustomText(
                                          title: "Owner Name: ${contact1!}",
                                          fontWeight: FontWeight.bold,
                                          googleFont: "Jost",
                                          fontSize: 14.sp,
                                          maxLine: 4,
                                          textOverflow: TextOverflow.ellipsis, // Add this to handle overflow
                                        ),
                                      )
                                          : SizedBox.shrink(),
                                      (contact2 != null && contact2!.isNotEmpty)
                                          ? Flexible(
                                        child: CustomText(
                                          title: "Owner Name: ${contact2!}",
                                          fontWeight: FontWeight.bold,
                                          googleFont: "Jost",
                                          fontSize: 14.sp,
                                          maxLine: 4,
                                          textOverflow: TextOverflow.ellipsis, // Add this to handle overflow
                                        ),
                                      )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                              SizedBox(height: 10), // Space between rows
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      (contact3 != null && contact3!.isNotEmpty)
                                          ?  CustomText(
                                    title:"Owner Name: ${contact3!}" ??
                                        "Imran Khan",
                                    fontWeight: FontWeight.bold,
                                    googleFont: "Jost",
                                    fontSize: 14.sp,
                                    maxLine: 4,
                                  )
                                          : SizedBox.shrink(),
                                      (contact4 != null && contact4!.isNotEmpty)
                                          ?  CustomText(
                                        title: "Owner Name: ${contact4!}" ??
                                            "Imran Khan",
                                        fontWeight: FontWeight.bold,
                                        googleFont: "Jost",
                                        fontSize: 14.sp,
                                        maxLine: 4,
                                      )
                                          : SizedBox.shrink(),
                                    ],
                                  ),
                                ],
                              ),
                              // CustomText(
                              //   title: businessModel?.contactName
                              //           ?.replaceAll(',', '') ??
                              //       "Imran Khan",
                              //   fontWeight: FontWeight.bold,
                              //   googleFont: "Jost",
                              //   fontSize: 14.sp,
                              //   maxLine: 4,
                              // ),
                              SizedBox(height: 20),
                              CustomText(
                                title: businessModel?.address ??
                                    "Satellite Town, Rawalpindi,Punjab,Pakistan",
                                fontSize: 13.sp,
                                color: grayColor,
                                maxLine: 4,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 5.h),
                              // phoneNumb1!.isNotEmpty
                              //     ? GestureDetector(
                              //         onTap: () {
                              //           print(businessModel?.contactPhone);
                              //           if (businessModel?.otherNumbers !=
                              //               null) {
                              //             String? firstPhoneNumber =
                              //                 phoneNumb1?.replaceAll(
                              //                     ' ', ''); // Remove any spaces
                              //             String phoneUrl =
                              //                 'tel:$firstPhoneNumber';
                              //             launchUrl(Uri.parse(phoneUrl));
                              //           }
                              //         },
                              //         child: CustomText(
                              //           title:
                              //               phoneNumb1?.replaceAll(',', '') ??
                              //                   "+92 333,786,830,8",
                              //           color: grayColor,
                              //           googleFont: "Jost",
                              //         ),
                              //       )
                              //     // : phoneNumb2!.isNotEmpty
                              //     //     ? GestureDetector(
                              //     //         onTap: () {
                              //     //           print(businessModel?.contactPhone);
                              //     //           if (businessModel?.contactPhone !=
                              //     //               null) {
                              //     //             String? firstPhoneNumber =
                              //     //                 phoneNumb2?.replaceAll(' ',
                              //     //                     ''); // Remove any spaces
                              //     //             String phoneUrl =
                              //     //                 'tel:$firstPhoneNumber';
                              //     //             launchUrl(Uri.parse(phoneUrl));
                              //     //           }
                              //     //         },
                              //     //         child: CustomText(
                              //     //           title: phoneNumb2?.replaceAll(
                              //     //                   ',', '') ??
                              //     //               "+92 333,786,830,8",
                              //     //           color: grayColor,
                              //     //           googleFont: "Jost",
                              //     //         ),
                              //     //       )
                              //     //     : phoneNumb3 != ""
                              //     //         ? GestureDetector(
                              //     //             onTap: () {
                              //     //               print(businessModel
                              //     //                   ?.contactPhone);
                              //     //               if (businessModel
                              //     //                       ?.contactPhone !=
                              //     //                   null) {
                              //     //                 String? firstPhoneNumber =
                              //     //                     phoneNumb3?.replaceAll(
                              //     //                         ' ',
                              //     //                         ''); // Remove any spaces
                              //     //                 String phoneUrl =
                              //     //                     'tel:$firstPhoneNumber';
                              //     //                 launchUrl(
                              //     //                     Uri.parse(phoneUrl));
                              //     //               }
                              //     //             },
                              //     //             child: CustomText(
                              //     //               title: phoneNumb3?.replaceAll(
                              //     //                       ',', '') ??
                              //     //                   "+92 333,786,830,8",
                              //     //               color: grayColor,
                              //     //               googleFont: "Jost",
                              //     //             ),
                              //     //           )
                              //     //         : phoneNumb4 != ""
                              //     //             ? GestureDetector(
                              //     //                 onTap: () {
                              //     //                   print(businessModel
                              //     //                       ?.contactPhone);
                              //     //                   if (businessModel
                              //     //                           ?.contactPhone !=
                              //     //                       null) {
                              //     //                     String? firstPhoneNumber =
                              //     //                         phoneNumb4?.replaceAll(
                              //     //                             ' ',
                              //     //                             ''); // Remove any spaces
                              //     //                     String phoneUrl =
                              //     //                         'tel:$firstPhoneNumber';
                              //     //                     launchUrl(
                              //     //                         Uri.parse(phoneUrl));
                              //     //                   }
                              //     //                 },
                              //     //                 child: CustomText(
                              //     //                   title:
                              //     //                       phoneNumb4?.replaceAll(
                              //     //                               ',', '') ??
                              //     //                           "+92 333,786,830,8",
                              //     //                   color: grayColor,
                              //     //                   googleFont: "Jost",
                              //     //                 ),
                              //     //               )
                              //                 : SizedBox.shrink(),

                              Column(
                                children: [
                                  (phoneNumb1 != null && phoneNumb1!.isNotEmpty)
                                      ? Text('Ph#: $phoneNumb1')
                                      : SizedBox.shrink(),
                                  (phoneNumb2 != null && phoneNumb2!.isNotEmpty)
                                      ? Text('Ph#: $phoneNumb2')
                                      : SizedBox.shrink(),
                                  (phoneNumb3 != null && phoneNumb3!.isNotEmpty)
                                      ? Text('Ph#: $phoneNumb3')
                                      : SizedBox.shrink(),
                                ],
                              )


                            ],
                          ),
                        ),
                      ),

                      /// Below Tab Bar View

                      // Container(
                      //   height: 30, // Adjust the height of the tab container
                      //   decoration: BoxDecoration(
                      //     // color: Colors.grey[300],
                      //     borderRadius: BorderRadius.circular(
                      //       25.0,
                      //     ),
                      //   ),
                      //   child:  TabBar(
                      //     controller: _tabController,
                      //     isScrollable: true,
                      //     indicator: BoxDecoration(
                      //       // borderRadius: BorderRadius.circular(25.0),
                      //       color: greenColor2, // Adjust the color as needed
                      //     ),
                      //     labelColor: Colors.white,
                      //     unselectedLabelColor: Colors.green,
                      //     tabs: [
                      //       Tab(
                      //         child: CustomText(
                      //           title: 'Overview',
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //       Tab(
                      //         child: CustomText(
                      //           title: "Products",
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //       Tab(
                      //         child: CustomText(
                      //           title: "Gallery",
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //       Tab(
                      //         child: Row(
                      //           children: [
                      //             Icon(
                      //               Icons.access_time_rounded,
                      //               size: 20,
                      //             ),
                      //             SizedBox(width: 10),
                      //             CustomText(
                      //               title: "Opening Hours",
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 14,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Tab(
                      //         child: CustomText(
                      //           title: "User Review",
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //       Tab(
                      //         child: CustomText(
                      //           title: "Contact us",
                      //           fontWeight: FontWeight.bold,
                      //           fontSize: 14,
                      //         ),
                      //       ),
                      //     ],
                      //     onTap: _handleTabTap,
                      //   ),
                      // ),
                      Container(
                        height: 30, // Adjust the height of the tab container
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25.0),
                        ),
                        child: TabBar(
                          controller: _tabController,
                          isScrollable: true,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            color: greenColor2, // Adjust the color as needed
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: greenColor2,
                          labelPadding: EdgeInsets.symmetric(horizontal: 3.0),
                          tabs: [
                            SizedBox( // Adjust the width as needed
                              width: 100, // Example width
                              child: Tab(
                                child: CustomText(
                                  title: 'Overview',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            // Container( // Adjust the width as needed
                            //   width: 100, // Example width
                            //   child: Tab(
                            //     child: CustomText(
                            //       title: "Products",
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 14,
                            //     ),
                            //   ),
                            // ),
                            // Container( // Adjust the width as needed
                            //   width: 100, // Example width
                            //   child: Tab(
                            //     child: CustomText(
                            //       title: "Gallery",
                            //       fontWeight: FontWeight.bold,
                            //       fontSize: 14,
                            //     ),
                            //   ),
                            // ),
                            // Container( // Adjust the width as needed
                            //   width: 150, // Example width
                            //   child: Tab(
                            //     child: Row(
                            //       children: [
                            //         Icon(
                            //           Icons.access_time_rounded,
                            //           size: 20,
                            //         ),
                            //         SizedBox(width: 10),
                            //         CustomText(
                            //           title: "Opening Hours",
                            //           fontWeight: FontWeight.bold,
                            //           fontSize: 14,
                            //         ),
                            //       ],
                            //     ),
                            //   ),
                            // ),
                            Container( // Adjust the width as needed
                              width: 120, // Example width
                              child: Tab(
                                child: CustomText(
                                  title: "User Review",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            SizedBox( // Adjust the width as needed
                              width: 120, // Example width
                              child: Tab(
                                child: CustomText(
                                  title: "Contact us",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                          onTap: _handleTabTap,
                        ),
                      ),

                      SingleChildScrollView(
                        child: SizedBox(
                          height: height,
                          child: TabBarView(
                            controller: _tabController,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(vertical: 5),
                                decoration: BoxDecoration(
                                  border: Border.all(color: grayColor2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
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
                                      Text(
                                        businessModel!.description??"",
                                        maxLines: showFullText ? null :1,
                                      ),
                                      // SizedBox(
                                      //   height: 20,
                                      // ),
                                      if (!showFullText)
                                        GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return Dialog(
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(12.0),
                                                  ),
                                                  child: SingleChildScrollView(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(12.0),
                                                      child: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          CustomText(
                                                            title: "OVERVIEW",
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 14,
                                                            color: Colors.green, // replace greenColor2 with Colors.green
                                                          ),
                                                          Divider(
                                                            color: Colors.green, // replace greenColor2 with Colors.green
                                                            thickness: 2,
                                                            indent: 1,
                                                            endIndent: 250,
                                                          ),
                                                          Text(
                                                            businessModel!.description.toString(),
                                                          ),
                                                          SizedBox(height: 20),
                                                          Align(
                                                            alignment: Alignment.centerRight,
                                                            child: ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.of(context).pop();
                                                              },
                                                              child: Text("Close"),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                          child: Text(
                                            'View More',
                                            style: TextStyle(
                                              color: Colors.blue,
                                              decoration: TextDecoration.underline,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ),



                            FutureBuilder<List<DisplayReviewModel>>(
                                future: futureReviews,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Center(child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Center(child: Text('Error: ${snapshot.error}'));
                                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                                    return Center(child: Text('No reviews found'));
                                  } else {
                                    final reviews = snapshot.data!;
                                    return Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.symmetric(vertical: 8),
                                      decoration: BoxDecoration(
                                        border: Border.all(color: Colors.grey),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            CustomText(
                                              title: "USER REVIEWS",
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                              color: greenColor2, // Assuming greenColor2 is defined as Colors.green
                                            ),
                                            Expanded(
                                              child: ListView.builder(
                                                physics: NeverScrollableScrollPhysics(),
                                                itemCount: reviews.length > 3 ? 3 : reviews.length,
                                                itemBuilder: (context, index) {
                                                  final review = reviews[index];
                                                  return Column(
                                                    children: [
                                                      Container(
                                                        alignment: Alignment.center,
                                                        margin: EdgeInsets.symmetric(vertical: 5),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          borderRadius: BorderRadius.circular(12),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(3.0),
                                                          child: Column(
                                                            mainAxisAlignment: MainAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                children: [
                                                                  CustomText(
                                                                    title: review.fullName ?? 'No Name',
                                                                  ),
                                                                  CustomText(
                                                                    title: review.dated != null
                                                                        ? '${review.dated!.day}/${review.dated!.month}/${review.dated!.year}'
                                                                        : 'No Date',
                                                                  ),
                                                                ],
                                                              ),
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Text(
                                                                  review.review ?? 'No Review',
                                                                ),
                                                              ),
                                                              RatingBarIndicator(
                                                                rating: review.rating != null ? review.rating!.toDouble() : 0.0,
                                                                itemBuilder: (context, index) => Icon(
                                                                  Icons.star,
                                                                  color: Colors.amber,
                                                                ),
                                                                itemCount: 5,
                                                                itemSize: 30.0,
                                                                direction: Axis.horizontal,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  );
                                                },
                                              ),
                                            ),
                                            if (reviews.length > 3)
                                              Align(
                                                alignment: Alignment.centerRight,
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) => AllReviewsScreen(reviews: reviews),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      'View More',
                                                      style: TextStyle(
                                                        color: Colors.blue,
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(vertical: 8),
                                decoration: BoxDecoration(
                                  border: Border.all(color: grayColor2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 1),
                                  child: SingleChildScrollView(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: CustomText(
                                                title: 'Name',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: greenColor2,
                                              ),
                                            ),
                                            Text(
                                              "*",
                                              style: GoogleFonts.jost(
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        CustomTextFormFieldWidget(
                                          controller: nameForContactus,
                                          onChanged: (val) {
                                            // ownerNameController4.text=val;
                                            contactUsModel.user!.name = val;
                                          },
                                          borderRadius: 10,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 0, 5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: CustomText(
                                                title: 'Email',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: greenColor2,
                                              ),
                                            ),
                                            Text(
                                              "*",
                                              style: GoogleFonts.jost(
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        CustomTextFormFieldWidget(
                                          controller: emailForContactus,
                                          onChanged: (val) {
                                            contactUsModel.user!.email = val;
                                          },
                                          borderRadius: 10,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 0, 5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: CustomText(
                                                title: 'Phone',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: greenColor2,
                                              ),
                                            ),
                                            Text(
                                              "*",
                                              style: GoogleFonts.jost(
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        CustomTextFormFieldWidget(
                                          controller: phoneController,
                                          keyboardType: TextInputType.phone,
                                          onChanged: (val) {
                                            contactUsModel.user!.contact = val;
                                          },
                                          borderRadius: 10,
                                          contentPadding:
                                              EdgeInsets.fromLTRB(10, 5, 0, 5),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: Alignment.centerLeft,
                                              child: CustomText(
                                                title: 'Massage',
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: greenColor2,
                                              ),
                                            ),
                                            Text(
                                              "*",
                                              style: GoogleFonts.jost(
                                                  color: Colors.red),
                                            ),
                                          ],
                                        ),
                                        CustomTextFormFieldWidget(
                                          controller: messageController,
                                          onChanged: (val) {
                                            contactUsModel.message = val;
                                          },
                                          borderRadius: 10,
                                          // contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                                          maxLines: 2,
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        Center(
                                          child: Custom_Button_Widget(
                                            height:
                                                ScreenUtil().setHeight(30.h),
                                            ontap: () async {
                                              contactUsModel.contactId = 0;
                                              contactUsModel.fkCityId = 0;
                                              contactUsModel.fkServiceId = 0;
                                              contactUsModel.fkProgramId = 0;
                                              contactUsModel.fkCountryId = 0;
                                              contactUsModel.fkPackageId = 0;
                                              contactUsModel.timing = "";
                                              contactUsModel.budget = 0;
                                              contactUsModel.area = "";
                                              contactUsModel.token = "";
                                              print(contactUsModel.user!.name);
                                              APIController.contactUsPost(
                                                  contactUsModel, context);
                                              nameForContactus.clear();
                                              emailForContactus.clear();
                                              phoneController.clear();
                                              messageController.clear();
                                            },
                                            rd: 10,
                                            color: greenColor2,
                                            child: CustomText(
                                              title: "Send",
                                              color: whiteColor,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.sp,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // Container(
                              //   alignment: Alignment.topLeft,
                              //   margin: EdgeInsets.symmetric(vertical: 8),
                              //   decoration: BoxDecoration(
                              //     border: Border.all(color: grayColor2),
                              //     borderRadius: BorderRadius.circular(12),
                              //   ),
                              //   child: Padding(
                              //     padding: EdgeInsets.symmetric(
                              //         horizontal: 10, vertical: 15),
                              //     child: SingleChildScrollView(
                              //       child: Column(
                              //         mainAxisAlignment:
                              //             MainAxisAlignment.start,
                              //         crossAxisAlignment:
                              //             CrossAxisAlignment.start,
                              //         children: [
                              //           CustomText(
                              //             title: "About Business Online",
                              //             fontWeight: FontWeight.bold,
                              //             fontSize: 20,
                              //             color: greenColor2,
                              //           ),
                              //           Divider(
                              //             color: greenColor2,
                              //             thickness: 2,
                              //             indent: 1,
                              //             endIndent: 120,
                              //           ),
                              //           CustomText(
                              //             title:
                              //                 businessModel?.description??"",
                              //             color: blackColor,
                              //             googleFont: "Jost",
                              //             fontWeight: FontWeight.w600,
                              //             fontSize: 14.sp,
                              //             // minFontSize: 5,
                              //             maxLine: 20,
                              //             textOverflow: TextOverflow.ellipsis,
                              //           ),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: CustomText(
                          title: "SPECIALITIES",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: greenColor2,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Divider(
                          color: greenColor2,
                          thickness: 2,
                          indent: 1,
                          endIndent: 250,
                        ),
                      ),
                      // Container(
                      //   alignment: Alignment.center,
                      //   height: specialtyCount == 0 ? 50.0 : totalHeight,
                      //   margin: EdgeInsets.symmetric(vertical: 8),
                      //   decoration: BoxDecoration(
                      //     border: Border.all(color: Colors.grey),
                      //     borderRadius: BorderRadius.circular(12),
                      //   ),
                      //   child: Padding(
                      //     padding: EdgeInsets.only(top: 10.0), // Adjust as needed
                      //     child: specialtyCount == 0
                      //         ? Center(
                      //       child: CustomText(
                      //         title: "No specialties available.",
                      //         fontWeight: FontWeight.bold,
                      //         fontSize: 14,
                      //         color: Colors.grey, // Or any other color
                      //       ),
                      //     )
                      //        :
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true, // Allow the ListView to wrap its content
                    itemCount: specialtyCount,
                    itemBuilder: (context, index) {
                      List<String>? specialties = businessModel?.speciality?.split(',');
                      String? specialty = specialties?[index].trim();
                      if (specialty != null && specialty.isNotEmpty) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 7, left: 7, right: 12),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: [
                                Image.asset(
                                  'assets/images/checkicon.png',
                                  scale: 30,
                                ),
                                SizedBox(width: 10),
                                AutoSizeText(
                                  specialty,
                                  style: TextStyle(fontSize: 12, color: grayColor),
                                  minFontSize: 10,
                                  stepGranularity: 10,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        // Return an empty container if there's no specialty
                        return Container();
                      }
                    },
                  ),
                  ],
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: _products.isEmpty ? null : 480.0, // Adjust as needed for products
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(top: 10.0), // Adjust as needed
                      child: _products.isEmpty
                          ? Center(
                        child: CustomText(
                          title: "Currently, there are no products available.",
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.red, // Or any other color
                        ),
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: CustomText(
                              title: "PRODUCT",
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: greenColor2, // Assuming greenColor2 is defined as Colors.green
                            ),
                          ),
                          Divider(
                            color: greenColor2, // Assuming greenColor2 is defined as Colors.green
                            thickness: 2,
                            indent: 1,
                            endIndent: 250,
                          ),
                          Expanded(
                            child: GridView.builder(
                              padding: EdgeInsets.all(0.3),
                              physics: NeverScrollableScrollPhysics(),
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 1,
                                mainAxisSpacing: 4,
                                crossAxisCount: 2,
                              ),
                              itemCount: _products.length > 4 ? 4 : _products.length,
                              itemBuilder: (context, index) {
                                final product = _products[index];
                                return Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductScreen(),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.0),
                                        border: Border.all(color: Colors.grey),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.circular(8.0),
                                              child: Image.asset(
                                                product.images != null && product.images!.isNotEmpty
                                                    ? product.images![0]
                                                    : 'assets/images/prodc.jpg',
                                                scale: 2,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: CustomText(
                                              title: product.itemName ?? 'Iphone',
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(height: 2),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 5),
                                            child: CustomText(
                                              title: 'Rs.${product.price}',
                                              color: greenColor2,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                                              children: [
                                                Expanded(
                                                  child: Custom_Button_Widget(
                                                    ontap: () {
                                                      if (businessModel?.contactPhone != null) {
                                                        String whatsappUrl = 'https://wa.me/+92${businessModel!.contactPhone?.replaceAll(',', '')}';
                                                        launchUrl(Uri.parse(whatsappUrl));
                                                      }
                                                    },
                                                    rd: 4.0,
                                                    height: 30.0,
                                                    width: 50.0,
                                                    color: greenColor2,
                                                    child: CustomText(
                                                      title: "WhatsApp",
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 5,),
                                                Expanded(
                                                  child: Custom_Button_Widget(
                                                    ontap: () {
                                                      if (businessModel?.contactPhone != null) {
                                                        String phoneUrl = 'tel:${businessModel!.contactPhone?.replaceAll(",", ",")}';
                                                        launchUrl(Uri.parse(phoneUrl));
                                                      }
                                                    },
                                                    rd: 4.0,
                                                    height: 30.0,
                                                    width: 50.0,
                                                    color: greenColor2,
                                                    child: CustomText(
                                                      title: "Call",
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                          if (_products.length > 4)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AllProductsScreen(products: _products),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    'View More',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          border: Border.all(color: grayColor2),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: SingleChildScrollView(
                            // Wrap the Column with SingleChildScrollView
                            child: Column(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
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
                                CarouselSlider.builder(
                                  options: CarouselOptions(
                                    viewportFraction: 1.0,
                                    enlargeCenterPage: false,
                                    autoPlay: true,
                                  ),
                                  itemCount: businessModel?.images?.length ?? 0,
                                  itemBuilder: (BuildContext context, int index, int realIndex) {
                                    final String? imageUrl = businessModel?.images != null &&
                                        businessModel!.images!.isNotEmpty &&
                                        index < businessModel!.images!.length &&
                                        businessModel!.images![index].imageName != null &&
                                        businessModel!.images![index].imageName!.isNotEmpty
                                        ? "https://businessonline.pk/Image/Business/Gallery/${businessModel!.karobarId}/${businessModel!.images![index].imageName}"
                                        : null;

                                    return InkWell(
                                      onTap: () {
                                        if (imageUrl != null) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => FullScreenImage(imageUrl: imageUrl),
                                            ),
                                          );
                                        }
                                      },
                                      child: SizedBox(
                                        width: MediaQuery.of(context).size.width,
                                        child: imageUrl != null
                                            ? FutureBuilder(
                                          future: precacheImage(NetworkImage(imageUrl), context),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState == ConnectionState.done) {
                                              return PhotoView(
                                                imageProvider: NetworkImage(imageUrl),
                                                backgroundDecoration: BoxDecoration(
                                                  color: Theme.of(context).canvasColor,
                                                ),
                                                minScale: PhotoViewComputedScale.covered,
                                                maxScale: PhotoViewComputedScale.covered * 2,
                                                initialScale: PhotoViewComputedScale.contained,
                                                loadingBuilder: (context, event) => Center(
                                                  child: CircularProgressIndicator(),
                                                ),
                                              );
                                            } else {
                                              return Center(
                                                child: CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        )
                                            : Image.asset(
                                          'assets/images/gallery.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),

                              ],
                            ),
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
                              top: 10.h,
                              left: 10.w,
                              bottom: 10,
                              right: 10.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
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
                                    color: greenColor2,
                                  ),
                                ],
                              ),
                              businessModel?.openningHours == null || businessModel!.openningHours!.isEmpty?Center(
                                child: DataTable(
                                  columnSpacing: 20,

                                  columns: const <DataColumn>[
                                    DataColumn(
                                      label: Text('Day'),
                                    ),
                                    DataColumn(
                                      label: Text('Opening Time'),
                                    ),
                                    DataColumn(
                                      label: Text('Closing Time'),
                                    ),
                                  ],
                                  rows: const <DataRow>[
                                    DataRow(

                                      cells: <DataCell>[
                                        DataCell(Text('Monday')),
                                        DataCell(Text('9:00 AM')),
                                        DataCell(Text('6:00 PM')),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('Tuesday')),
                                        DataCell(Text('9:00 AM')),
                                        DataCell(Text('6:00 PM')),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('Wednesday')),
                                        DataCell(Text('9:00 AM')),
                                        DataCell(Text('6:00 PM')),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('Thursday')),
                                        DataCell(Text('9:00 AM')),
                                        DataCell(Text('6:00 PM')),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('Friday')),
                                        DataCell(Text('9:00 AM')),
                                        DataCell(Text('6:00 PM')),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('Saturday')),
                                        DataCell(Text('9:00 AM')),
                                        DataCell(Text('6:00 PM')),
                                      ],
                                    ),
                                    DataRow(
                                      cells: <DataCell>[
                                        DataCell(Text('Sunday')),
                                        DataCell(Text('Closed')),
                                        DataCell(Text('Closed')),
                                      ],
                                    ),
                                  ],
                                ),
                              ): SingleChildScrollView(
                                scrollDirection: Axis.vertical,
                                physics: ScrollPhysics(),
                                child: SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Card(
                                    child: DataTable(
                                      columnSpacing: 20,
                                      columns: const [
                                        DataColumn(label: Text('Day')),
                                        DataColumn(label: Text('Opening Time')),
                                        DataColumn(label: Text('Closing Time')),
                                      ],
                                      rows: openningHours.map((OpenningHour hour) {
                                        final dayOfWeek = hour.dayOfWeek ?? '';
                                        String openingTime;
                                        String closingTime;

                                        if (hour.isOpen == true) {
                                          if (hour.openingTime == "24Hours" || hour.closingTime == "24Hours") {
                                            openingTime = "24Hours";
                                            closingTime = "24Hours";
                                          } else {
                                            openingTime = hour.openingTime ?? 'Closed';
                                            closingTime = hour.closingTime ?? 'Closed';
                                          }
                                        } else {
                                          openingTime = 'Closed';
                                          closingTime = 'Closed';
                                        }

                                        return DataRow(
                                          color: MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
                                            return Colors.grey[200]; // Set your desired background color here
                                          }),
                                          selected: true,
                                          cells: <DataCell>[
                                            DataCell(Text(dayOfWeek)),
                                            DataCell(Text(openingTime)),
                                            DataCell(Text(closingTime)),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
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
                                initialRating: _reviewModel.rating != null
                                    ? _reviewModel.rating!.toDouble()
                                    : 0.0,
                                minRating: 1,
                                direction: Axis.horizontal,
                                allowHalfRating: true,
                                itemCount: 5,
                                itemPadding:
                                    EdgeInsets.symmetric(horizontal: 3.0),
                                itemBuilder: (context, _) => Icon(
                                  Icons.star,
                                  color: greenColor2,
                                ),
                                onRatingUpdate: (rating) {
                                  setState(() {
                                    _reviewModel.rating = rating
                                        .toInt(); // Assuming rating is an integer
                                  });
                                },
                              ),
                              CustomTextFormFieldWidget(
                                controller: nameController,
                                onChanged: (val) {
                                  // whatsAppController.text=val;
                                  _reviewModel.fullName = val;
                                },
                                hint: "User Name",
                                borderRadius: 10.r,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 5, 0, 5),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              CustomTextFormFieldWidget(
                                controller: emailController,
                                onChanged: (val) {
                                  // whatsAppController.text=val;
                                  _reviewModel.email = val;
                                },
                                hint: "Email",
                                borderRadius: 10.r,
                                contentPadding:
                                    EdgeInsets.fromLTRB(10, 5, 0, 5),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              CustomTextFormFieldWidget(
                                controller: descriptionController,
                                onChanged: (val) {
                                  // whatsAppController.text=val;
                                  _reviewModel.review = val;
                                },
                                hint: "Description...",
                                maxLines: 3,
                                borderRadius: 10,
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(10),
                              ),
                              Custom_Button_Widget(
                                height: ScreenUtil().setHeight(30.h),
                                ontap: () async {

                                  _reviewModel.fkKarobarId = widget.karobarId;
                                  _reviewModel.reviewId = 0;
                                  _reviewModel.dated = DateTime.now();
                                  APIController.registerReviewModel(
                                      _reviewModel, context);
                                  nameController.clear();
                                  emailController.clear();
                                  descriptionController.clear();
                                  // Clear the review model
                                },
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

                      /// comment for play store Repor Your Business
                      // Custom_Button_Widget(
                      //   ontap: () {
                      //      _showAlertDialog(context); // Call the function to show the alert dialog
                      //     print('Report');
                      //   },
                      //   rd: 10,
                      //   width: ScreenUtil().screenWidth / 2.2,
                      //   color: whiteColor,
                      //   border: Border.all(color: greenColor2, width: 2),
                      //   child: CustomText(
                      //     title: "Report this business",
                      //     color: yaleBlueColor,
                      //     fontWeight: FontWeight.bold,
                      //     fontSize: 15.sp,
                      //   ),
                      // ),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }

  void sendMessage(String data) {
    final message = 'Your data: $data';
    Share.share(message);
  }

  // whatsapp() async{
  //   var contact = "+923319234730";
  //   var androidUrl = "whatsapp://send?phone=$contact&text=Hi, I need some help";
  //   var iosUrl = "https://wa.me/$contact?text=${Uri.parse('Hi, I need some help')}";
  //
  //   try{
  //     if(Platform.isIOS){
  //       await launchUrl(Uri.parse(iosUrl));
  //     }
  //     else{
  //       await launchUrl(Uri.parse(androidUrl));
  //     }
  //   } on Exception{
  //     // EasyLoading.showError('WhatsApp is not installed.');
  //   }
  // }

  void _launchWhatsApp(String message) async {
    var whatsappUrl = "whatsapp://send?text=${Uri.encodeComponent(message)}";
    await launch(whatsappUrl).catchError((e) {
      print("Error launching WhatsApp: $e");
    });
  }

  void _shareData(String data) async {
    await Share.share(data);
  }
}

class FullScreenImage extends StatelessWidget {
  final String imageUrl;

  const FullScreenImage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image'),
      ),
      body: PhotoView(
        imageProvider: NetworkImage(imageUrl),
        backgroundDecoration: BoxDecoration(
          color: Colors.black, // Set background color
        ),
      ),
    );
  }
}
