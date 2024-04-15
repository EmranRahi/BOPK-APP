import 'package:auto_size_text/auto_size_text.dart';
import 'package:businessonlinepk/Controllers/Api_Controller.dart';
import 'package:businessonlinepk/model/ContactUs_Model.dart';
import 'package:businessonlinepk/model/RegisterReviewRattingModel.dart';
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
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_button/group_button.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/DetailStaticBusinessModel.dart';
import '../model/DetailsPageProductModel.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'main_page_bopk.dart';
import 'menu_login.dart';
import 'mobile_shops.dart';

class StaticBusinessDetailsPage extends StatefulWidget {
  StaticBusinessDetailsPage(this.karobarId, this.title,);

  int? karobarId = 0;
  String? title = "";

  @override
  State<StaticBusinessDetailsPage> createState() => _StaticBusinessDetailsPageState();
}

class _StaticBusinessDetailsPageState extends State<StaticBusinessDetailsPage> with SingleTickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  ContactUsModel contactUsModel = ContactUsModel(user: User());
  RegisterReviewModel _reviewModel =RegisterReviewModel();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  /// contact us Controller
  TextEditingController nameForContactus = TextEditingController();
  TextEditingController emailForContactus = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  late TabController _tabController;

  // bool  checkboxValue =  false;
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
/// this function for Report Business
//   void _showAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           scrollable: true,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(10.0),
//           ),
//           title: CustomText(
//               title: "Report Business",
//               fontSize: 20,
//               color: greenColor2,
//               fontWeight: FontWeight.bold),
//           content: SingleChildScrollView(
//             child: Container(
//               height: ScreenUtil().screenHeight / 2.6,
//               child: ListView(
//                 children: [
//                   CustomText(
//                     title: "MOBILE SHOP (RS 5000)",
//                     color: grayColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   SizedBox(height: 20),
//                   DropdownButton<String>(
//                     elevation: 0,
//                     items: items.map((String item) {
//                       return DropdownMenuItem<String>(
//                         value: item,
//                         child: Text(item),
//                       );
//                     }).toList(),
//                     value: selectedValue,
//                     onChanged: (value) {
//                       selectedValue = value!;
//                     },
//                   ),
//                   SizedBox(height: 20.h),
//                   CustomText(
//                     title: "Your review here:",
//                     color: grayColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   CustomTextFormFieldWidget(
//                       maxLines: 3,
//                       borderRadius: 10,
//                       color: greenColor2), // Adjust maxLines as needed
//                   SizedBox(height: 10.h),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Custom_Button_Widget(
//                         ontap: () {
//                           Navigator.pop(context);
//                           print("Click Cancel");
//                         },
//                         rd: 4.r,
//                         height: 30.h,
//                         width: 70.h,
//                         color: greenColor,
//                         child: CustomText(
//                           title: "Cancel",
//                           color: whiteColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                       Custom_Button_Widget(
//                         ontap: () {
//                           print("Click report");
//                         },
//                         rd: 4.r,
//                         height: 30.h,
//                         width: 70.h,
//                         color: greenColor,
//                         child: CustomText(
//                           title: "Report",
//                           color: whiteColor,
//                           fontWeight: FontWeight.bold,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
 /// products List
  late List<DetailsPageProductModel> _products = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDetails(widget.karobarId);
    _tabController = TabController(length: 7, vsync: this);
    _fetchProducts();
  }


  Future<void> _fetchProducts() async {
    try {
      List<DetailsPageProductModel> products = await APIController.fetchProducts();
      setState(() {
        _products = products;
      });
    } catch (error) {
      print('Error fetching products: $error');
      // Handle error
    }
  }



  bool _isAboutTabSelected = false;
   _handleTabTap(int index) {
    // _tabController.animateTo(index);
     setState(() {
       _isAboutTabSelected = _tabController.index == 6;
     });

  }



  Future<void> getDetails(int? karobarId) async {
    APIController controller = APIController();

    // Call fetchDataDetails and await the result
    businessModel = await controller.fetchDataDetails(karobarId);

    // if (businessModel != null) {
    // print('Business Title: ${businessModel!.title}');
    print('Business Description: ${businessModel?.description}');
    // print('Business Location: ${businessModel?.location?.locationName}');
    // } else {
    // Handle the case where the data fetch was unsuccessful
    // }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    // contactUsModel.user=User();
    print('work');
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
        leading: IconButton(onPressed: () {
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back, color: greenColor2, size: 30,)),
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
                  /// ye code meny felhal comment kia hai.
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
      body: ListView(
         // keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        // physics: AlwaysScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            child: Column(
              children: [
              SizedBox(height: 20,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 10.w),
              child: Custom_Button_Widget(
                width: MediaQuery.of(context).size.width / 1.0,
                ontap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> MenuLogin()));
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
            SizedBox(height: 10,),
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height/3.5,
                  width:  MediaQuery.of(context).size.width,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.asset(
                      'assets/images/bopk1.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                // Map Image
                // Image.asset('assets/images/map.jpg',width: double.infinity,fit: BoxFit.fitWidth,),
                // Positioned(
                //   top: 90.h,
                //   left: 8.w,
                //   child:   Row(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: businessModel!.images![0].imageName != null && businessModel!.images![0].imageName!.isNotEmpty
                //             ? Image.network(
                //           "http://bopk.psea.pk/Images/Gallery/${businessModel!.karobarId}/${businessModel!.images![0].imageName}", // Assuming there's always at least one image in the first item
                //           width: MediaQuery.of(context).size.width / 3, // Adjust the width as needed
                //           height: MediaQuery.of(context).size.height / 3.9, // Adjust the height as needed
                //           fit: BoxFit.cover,
                //         )
                //             : Image.asset(
                //           'assets/images/bopk1.png', // Path to your default image asset
                //           width: MediaQuery.of(context).size.width / 3, // Adjust the width as needed
                //           height: MediaQuery.of(context).size.height / 3.9, // Adjust the height as needed
                //           fit: BoxFit.cover,
                //         ),
                //       ),
                //     ],
                //   ),
                //   // CircleAvatar(
                //   //   maxRadius: 30,
                //   //   backgroundImage: businessModel?.url != null
                //   //       ? AssetImage(businessModel!.url.toString())
                //   //       : AssetImage('assets/images/producimage1.png'),
                //   // ),
                // ),
                Positioned(
                  top: 90.h,
                  left: 8.w,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: businessModel != null && businessModel!.images != null && businessModel!.images!.isNotEmpty && businessModel!.images![0].imageName != null && businessModel!.images![0].imageName!.isNotEmpty
                            ? CircleAvatar(
                          radius: 30, // Radius of 30
                          backgroundImage: NetworkImage(
                            "https://businessonline.pk/Images/Gallery/${businessModel!.karobarId}/${businessModel!.images![0].imageName}", // Assuming there's always at least one image in the first item
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
                  top: 105,
                  left: 80,
                  child: CustomText(
                    title:  businessModel?.title ?? "Default Title",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    color: Colors.black,
                  ),
                ),
                Positioned(
                  top: 125,
                  left: 80,
                  child: RatingBar.builder(
                    itemSize: 10,
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemBuilder: (context, _) =>
                        Icon(
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
                  top: 150.h,
                    left: 60.w,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        businessModel?.whatsAppNumber==null
                            ? CustomContainer(
                      height: 40,
                      width: 40,
                      ontap: () {},
                      rd: 100,
                      color: whiteColor,
                      boxShadow: true,
                      child: Image.asset(
                          'assets/images/navigation1.png'),
                    ):CustomContainer(
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
                        businessModel?.contactPhone==null
                            ?  CustomContainer(
                        height: 40,
                        width: 40,
                        ontap: () {
                          print(businessModel?.contactPhone);
                          if (businessModel?.contactPhone != null) {
                            String phoneUrl = 'tel:${businessModel!.contactPhone}';
                            launchUrl(Uri.parse(phoneUrl));
                          }
                        },
                        rd: 100,
                        color: whiteColor,
                        boxShadow: true,
                        child:
                        Image.asset('assets/images/call1.png')): CustomContainer(
                            height: 40,
                            width: 40,
                            ontap: () {
                              print(businessModel?.contactPhone);
                              if (businessModel?.contactPhone != null) {
                                String phoneUrl = 'tel:${businessModel!.contactPhone}';
                                launchUrl(Uri.parse(phoneUrl));
                              }
                            },
                            rd: 100,
                            color: whiteColor,
                            boxShadow: true,
                            child:
                            Image.asset('assets/images/call.png')),
                    SizedBox(width: 5.w),
                        businessModel?.whatsAppNumber==null
                            ?  CustomContainer(
                        height: 40,
                        width: 40,
                        ontap: () {},
                        rd: 100,
                        color: whiteColor,
                        boxShadow: true,
                        child:
                        Image.asset('assets/images/sms1.png'))
                            : CustomContainer(
                            height: 40,
                            width: 40,
                            ontap: () {},
                            rd: 100,
                            color: whiteColor,
                            boxShadow: true,
                            child:
                            Image.asset('assets/images/sms.png')),
                    SizedBox(width: 5.w),
                    businessModel?.contactPhone==null
                   ? CustomContainer(
                    height: 40,
                    width: 40,
                    ontap: () {
                      print(businessModel?.contactPhone);
                      // String whatsappUrl = 'https://wa.me/+1${businessModel!.whatsAppNumber}';
                      if(businessModel?.contactPhone != null){
                        String whatsappUrl = 'https://wa.me/+1${businessModel!.contactPhone}';
                        launchUrl(Uri.parse(whatsappUrl));
                      }
                    },
                    rd: 100,
                    color: whiteColor,
                    boxShadow: true,
                    child: Image.asset(
                        'assets/images/whtsapp1.png'),)
                   : CustomContainer(
                    height: 40,
                    width: 40,
                    ontap: () {
                      print(businessModel?.contactPhone);
                      // String whatsappUrl = 'https://wa.me/+1${businessModel!.whatsAppNumber}';
                      if(businessModel?.contactPhone != null){
                        String whatsappUrl = 'https://wa.me/+1${businessModel!.contactPhone}';
                        launchUrl(Uri.parse(whatsappUrl));
                      }
                    },
                    rd: 100,
                    color: whiteColor,
                    boxShadow: true,
                    child: Image.asset(
                        'assets/images/whtsapp.png')),
                     SizedBox(width: 5.w),
                    businessModel?.whatsAppNumber==null
                            ?  CustomContainer(
                  height: 40,
                  width: 40,
                  ontap: () {

                  },
                  rd: 100,
                  color: whiteColor,
                  boxShadow: true,
                  child: Image.asset('assets/images/share2.png'),
                )
                            : CustomContainer(
                          height: 40,
                          width: 40,
                          ontap: () {},
                          rd: 100,
                          color: whiteColor,
                          boxShadow: true,
                          child: Image.asset('assets/images/share.png')),
              ],
            ),
          ),

        ],
      ),
      Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(children: [
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
              businessModel?.email == null ?
              CustomContainer(
                height: 50,
                width: 50,
                ontap: () {
                  if (businessModel?.email != null) {
                    launchUrl(Uri.parse('mailto:${businessModel!.email}'));
                  }
                },
                rd: 100,
                color: Colors.transparent,
                // boxShadow: true,
                child: Image.asset('assets/media/mesage.png',
                    scale: 2),
              )
                  :CustomContainer(
                height: 50,
                width: 50,
                ontap: () {
                  if (businessModel?.email != null) {
                    launchUrl(Uri.parse('mailto:${businessModel!.email}'));
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
                  ?  CustomContainer(
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
                  :CustomContainer(
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
                  ?  CustomContainer(
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
                  :  CustomContainer(
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
                  :CustomContainer(
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
                    title:businessModel?.contactPhone?.replaceAll(',', '') ?? "+92 333,786,830,8",
                    color: grayColor,
                    googleFont: "Jost",
                  ),
                  SizedBox(height: 10.h),
                  CustomText(
                      title: businessModel?.title?.replaceAll(',', '') ?? "businessName",
                      fontWeight: FontWeight.bold,
                      googleFont: "Jost",
                      fontSize: 16.sp),
                  SizedBox(
                    height: 6,
                  ),
                  CustomText(
                    title: businessModel?.contactName?.replaceAll(',', '') ?? "Imran Khan",
                    fontWeight: FontWeight.bold,
                    googleFont: "Jost",
                    fontSize: 14.sp,
                  ),
                  SizedBox(height: 20),
                  CustomText(
                    title:
                    businessModel?.address ??
                        "Satellite Town, Rawalpindi,Punjab,Pakistan",
                    fontSize: 13.sp,
                    color: grayColor,
                    maxLine: 2,
                    textOverflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
       /// Below Tab Bar View
          Container(
            height: 30, // Adjust the height of the tab container
            decoration: BoxDecoration(
              // color: Colors.grey[300],
              borderRadius: BorderRadius.circular(
                25.0,
              ),
            ),
            child: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  25.0,
                ),
                color: greenColor2,
              ),
              labelColor: Colors.white,
              unselectedLabelColor: greenColor2,
              tabs: [
                Tab(
                  child: CustomText(title:
                  'Overview',
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    // color: greenColor2,
                  ),
                ),
                Tab(
                  child: CustomText(
                    title: "Products",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    // color: greenColor2,
                  ),
                ),
                Tab(
                  child: CustomText(
                    title: "Gallery",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    // color: greenColor2,
                  ),
                ),
                Tab(
                  child: Row(
                    children: [
                      Icon(
                        Icons.access_time_rounded,
                        // color: greenColor2,
                        size: 20,
                      ),
                      SizedBox(width: 10,),
                      CustomText(
                        title: "Opening Hours",
                        fontWeight: FontWeight.bold,
                        fontSize: 14.sp,
                        // color: greenColor2,
                      ),
                    ],
                  ),
                ),
                Tab(
                  child: CustomText(
                    title: "User Review",
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    // color: greenColor2,
                  ),
                ),
                Tab(
                  child: CustomText(
                    title: "Contact us",
                    fontWeight: FontWeight.bold,
                    fontSize: 14.sp,
                    // color: greenColor2,
                  ),
                ),
                Tab(
                  child: CustomText(
                    title: "About",
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                    // color: greenColor2,
                  ),
                ),
              ],
              onTap: _handleTabTap,
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height/1.6,
            child: TabBarView(
              controller: _tabController,
              children:  [
                Container(
                  alignment: Alignment.center,
                  // height: 20.h,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                        CustomText(
                          title: businessModel?.description ??
                              'we deal in Samsung and Iphone Only',
                          fontSize: 14,
                          googleFont: "Jost",
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
                 /// Speciality code
                        Expanded(
                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            itemCount: businessModel?.speciality?.split(',').length ?? 0,
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
                                        Image.asset('assets/images/checkicon.png', scale: 30),
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

                        /// product grid view
                        Expanded(
                          child: GridView.builder(
                              padding: EdgeInsets.all(0.5),
                              gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisSpacing: 3,
                                mainAxisSpacing: 4,
                                crossAxisCount: 2, // Number of columns
                              ),
                              itemCount: _products.length, // Number of items in the grid
                              itemBuilder: (context, index) {
                                final product = _products[index]; // Get the product at the current index
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ProductScreen()));
                                    print('GridView');
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
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
                                              offset: Offset(0, 0),
                                            ),
                                          ]),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Center(
                                            child:  Image.asset(
                                              product.images != null && product.images!.isNotEmpty ? product.images![0] : 'assets/images/producimage1.png',
                                              scale: 7,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: CustomText(
                                              title: product.itemName ?? 'Iphone',
                                              color: grayColor,
                                            ),
                                          ),
                                          SizedBox(
                                            height: 2,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(left: 10),
                                            child: CustomText(
                                              title: 'Rs.${product.price}', // Display product price,
                                              color: tealColor1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          /// Product Screen button  comment for play store
                                          Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceAround,
                                            children: [
                                              Custom_Button_Widget(
                                                ontap: () {
                                                  if (businessModel?.contactPhone != null) {
                                                    String whatsappUrl = 'https://wa.me/+92${businessModel!.contactPhone?.replaceAll(',', '')}';
                                                    launchUrl(Uri.parse(whatsappUrl));
                                                  }
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
                                                  print(businessModel?.contactPhone);
                                                  if (businessModel?.contactPhone != null) {
                                                    String phoneUrl = 'tel:${businessModel!.contactPhone?.replaceAll(",", ",")}';
                                                    launchUrl(Uri.parse(phoneUrl));
                                                  }
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
                                  ),
                                );
                              }
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
                        CarouselSlider.builder(
                          options: CarouselOptions(
                            viewportFraction: 1.0,
                            enlargeCenterPage: false,
                            autoPlay: true,
                          ),
                          itemCount: businessModel?.images?.length ?? 0,
                          itemBuilder: (BuildContext context, int index, _) {
                            if (businessModel?.images != null &&
                                businessModel!.images!.isNotEmpty &&
                                index < businessModel!.images!.length &&
                                businessModel!.images![index].imageName != null &&
                                businessModel!.images![index].imageName!.isNotEmpty) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: Image.network("https://businessonline.pk/Images/Gallery/${businessModel!.karobarId}/${businessModel!.images![index].imageName}",
                                  fit: BoxFit.cover,
                                ),
                              );
                            } else {
                              return Image.asset(
                                'assets/images/gallery.jpg',
                                fit: BoxFit.cover,
                              );
                            }
                          },
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
                                      title: CustomText(title: "imran khan"),
                                      subtitle: CustomText(
                                        title: "waw3wo3eo",
                                      ),
                                      trailing: CustomText(
                                          title:
                                          "06/02/2024"),
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
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: grayColor2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(alignment: Alignment.centerLeft,
                              child: CustomText( title: 'Name',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: greenColor2,
                              ),),
                            Text("*",style: GoogleFonts.jost(color: Colors.red),),
                          ],
                        ),
                        CustomTextFormFieldWidget(
                          controller: nameForContactus,
                          onChanged: (val) {
                            // ownerNameController4.text=val;
                              contactUsModel.user!.name =val;
                          },
                            borderRadius: 10,
                          contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(alignment: Alignment.centerLeft,
                              child: CustomText( title: 'Email',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: greenColor2,
                              ),),
                            Text("*",style: GoogleFonts.jost(color: Colors.red),),
                          ],
                        ),
                        CustomTextFormFieldWidget(
                          controller: emailForContactus,
                            onChanged: (val) {
                              contactUsModel.user!.email = val;
                            },
                            borderRadius: 10,
                          contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(alignment: Alignment.centerLeft,
                              child: CustomText( title: 'Phone',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: greenColor2,
                              ),),
                            Text("*",style: GoogleFonts.jost(color: Colors.red),),
                          ],
                        ),
                        CustomTextFormFieldWidget(
                          controller: phoneController,
                           keyboardType: TextInputType.phone,
                          onChanged: (val) {
                            contactUsModel.user!.contact= val;
                          },
                          borderRadius: 10,
                          contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(alignment: Alignment.centerLeft,
                              child: CustomText( title: 'Massage',
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: greenColor2,
                              ),),
                            Text("*",style: GoogleFonts.jost(color: Colors.red),),
                          ],
                        ),
                        CustomTextFormFieldWidget(
                          controller: messageController,
                            onChanged: (val) {
                              contactUsModel.message =val;
                            },
                            borderRadius: 10,
                          // contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                           maxLines: 2,
                        ),
                        SizedBox(height: 20,),
                        Center(
                          child: Custom_Button_Widget(
                            height: ScreenUtil().setHeight(30.h),
                            ontap: () async{
                              contactUsModel.contactId=0;
                              contactUsModel.fkCityId = 0;
                              contactUsModel.fkServiceId = 0;
                              contactUsModel.fkProgramId =0;
                              contactUsModel.fkCountryId=0;
                              contactUsModel.fkPackageId=0;
                              contactUsModel.timing="";
                              contactUsModel.budget=0;
                              contactUsModel.area="";
                              contactUsModel.token="";
                              print(contactUsModel.user!.name);
                              APIController.contactUsPost(contactUsModel,context);
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
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: grayColor2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10,vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          title: "About Business Online",
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: greenColor2,
                        ),
                        Divider(
                          color: greenColor2,
                          thickness: 2,
                          indent: 1,
                          endIndent: 120,
                        ),
                        CustomText(
                          title: "Businessonline.pk is a product of High Performance Computing Private Limited.\n"
                               " It is not just a normal marketing website but a platform for every small, medium and large Pakistani businesses to come together and present their products and services.\n"
                               "Pakistani users will benefit to find closest and local businesses ranging from butchers to cobblers, stationers to pizza shops, telecom to banks at an ease of just Businessonline.pk.\n"
                               " We Businessonline.pk are committed to covert tradition businesses in old Pakistan to latest technology in Naya Pakistan.\n"
                               "Let’s join our hands and work together to form Naya Pakistan in our own very special way In sha Allah .\n",
                          color: blackColor,
                          googleFont: "Jost",
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          // minFontSize: 5,
                          maxLine: 20,
                          textOverflow: TextOverflow.ellipsis,
                        ),

                      ],
                    ),
                  ),
                ),

              ],
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
                    initialRating: _reviewModel.rating != null ? _reviewModel.rating!.toDouble() : 0.0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding:
                    EdgeInsets.symmetric(horizontal: 3.0),
                    itemBuilder: (context, _) =>
                        Icon(
                          Icons.star,
                          color: greenColor2,
                        ),
                    onRatingUpdate: (rating) {
                      setState(() {
                        _reviewModel.rating = rating.toInt(); // Assuming rating is an integer
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
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10),),
                  CustomTextFormFieldWidget(
                    controller: emailController,
                    onChanged: (val) {
                      // whatsAppController.text=val;
                      _reviewModel.email = val;
                    },
                    hint: "Email",
                    borderRadius: 10.r,
                    contentPadding: EdgeInsets.fromLTRB(10, 5, 0, 5),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(10),),
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
                  SizedBox(height: ScreenUtil().setHeight(10),),
                  Custom_Button_Widget(
                    height: ScreenUtil().setHeight(40.h),
                    ontap: () async{
                      _reviewModel.rating;
                      _reviewModel.fkKarobarId =0;
                      _reviewModel.reviewId =0;
                      APIController.registerReviewModel(_reviewModel,context);
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

        ]

      ),

    );
  }


}