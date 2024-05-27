import 'dart:async';
import 'dart:convert';
import 'package:businessonlinepk/globle_variable/globle.dart';
import 'package:businessonlinepk/model/HomePageMainCategory.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/mobile_shops.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';
import 'package:upgrader/upgrader.dart';
import '../Controllers/Api_Controller.dart';
import '../Service/ApiResponse.dart';
import '../Service/ApiService.dart';
import '../model/BannerApiModel.dart';
import '../model/HomeCategory.dart';
import 'customs_widgets/custom_text.dart';
import 'menu_login.dart';

class HomePage extends StatefulWidget {
  final List<HomePageMainCategory> categories;

  HomePage({required this.categories});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController listScrollController = ScrollController();
  final TextEditingController _searchByKey = TextEditingController();
  String favoriteCity = 'Unavailable';
  String? categoryName = "-";
  String? image = "-";
  List? list1Share;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  var long = 0.0;
  var lat = 0.0;
  int? subCategoryid;

  /// for place api
  String _currentAddress = 'Search by Business';

  // double? picklat;
  // double? picklng;
  // Define a boolean variable to track whether the banners are loaded
  bool bannersLoaded = false;
  late StreamSubscription<Position> positionStream;
  final APIController controller = APIController();
  // String minRequiredVersion = '1.5';
  List<BannerApiModel>? banners = [];
  List<String> imgList = [
    'assets/newbopkpic/b2.png',
    'assets/newbopkpic/b3.png',
    'assets/newbopkpic/b4.png',
    'assets/newbopkpic/b5.png',
    'assets/newbopkpic/b6.png',
    'assets/newbopkpic/b7.png',
    'assets/newbopkpic/b8.png',
  ];

  @override
  void initState() {
    super.initState();
    checkGps();
    checkLocationPermission();
    loadBanners();
    getLocation();
    fetch();
  }

  void loadBanners() async {
    List<BannerApiModel> fetchedBanners = await APIController.getBanners();
    // Filter banners to include only those with isMain set to true
    List<BannerApiModel> mainBanners =
        fetchedBanners.where((banner) => banner.isMain == true).toList();
    setState(() {
      banners = mainBanners;
      bannersLoaded = true; // Set bannersLoaded to true once banners are loaded
    });
  }

  Future<void> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) {
        // Permissions are denied forever, handle appropriately.
        return;
      }
      if (permission == LocationPermission.denied) {
        // Permissions are denied, handle appropriately.
        return;
      }
    }
    if (permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse) {
      getLocation();
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
        lat = geometry.location.lat;
        long = geometry.location.lng;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Hide status bar icons by setting the system overlay style
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        // Set the status bar color to transparent
        statusBarIconBrightness:
            Brightness.light, // Use dark icons on the status bar
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UpgradeAlert(
        child: Scaffold(
          backgroundColor: Color(0xffE4E4E4),
          body: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(
                  children: [
// Inside your widget build method
                    bannersLoaded
                        ? CarouselSlider(
                            options: CarouselOptions(
                              aspectRatio: 16 / 8,
                              viewportFraction: 1.0,
                              autoPlay: true,
                              autoPlayInterval: Duration(seconds: 5),
                              autoPlayAnimationDuration:
                                  Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                            ),
                            items: banners!.map((banner) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 5.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      // Adjust the border radius as needed
                                      child: Image.network(
                                        "https://businessonline.pk/Image/Banners/${banner.bannerId!}/${banner.bannerName!}",
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          )
                        : Center(
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[300]!,
                              highlightColor: Colors.grey,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 5.0),
                                width: MediaQuery.of(context).size.width,
                                // Set the width to match the banner width
                                height: MediaQuery.of(context).size.width *
                                    (8 / 16),
                                // Set the height based on aspect ratio
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  // Adjust the border radius as needed
                                  color: Colors.grey[
                                      300], // Match the shimmer color with baseColor
                                ),
                              ),
                            ),
                          ),

                    Positioned(
                      top: ScreenUtil().setHeight(20),
                      right: ScreenUtil().setWidth(5),
                      child: PopupMenuButton<int>(
                        icon: Icon(Icons.menu, color: Colors.white, size: 30),
                        color: whiteColor,
                        itemBuilder: (BuildContext context) {
                          return <PopupMenuEntry<int>>[
                            PopupMenuItem<int>(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MenuLogin()));
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
                                        builder: (context) =>
                                            RegisterYourBusiness()));
                              },
                              value: 1,
                              child: CustomText(
                                  title: "Register Your Business",
                                  fontStyle: FontStyle.italic),
                            ),
                            PopupMenuDivider(),

                            /// ye code meny felhal comment kia hai.
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
                    ),
                    Positioned(
                      bottom: ScreenUtil().setHeight(24.h),
                      left: ScreenUtil().setWidth(10.w),
                      right: ScreenUtil().setWidth(10.w),
                      child: Container(
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              spreadRadius: 0,
                              blurRadius: 30,
                              offset:
                                  Offset(0, 0), // changes position of shadow
                            ),
                          ],
                          borderRadius: BorderRadius.circular(
                              40), // Ensuring circular shape
                        ),
                        width: MediaQuery.of(context).size.width -
                            60, // Adjust the width as needed
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                _showPlacePicker();
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: greenColor2,
                                  borderRadius: BorderRadius.circular(
                                      10), // Ensuring circular shape
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(10.0),
                                  child: Icon(
                                    Icons.near_me_rounded,
                                    color: Colors.white,
                                  ), // Add your direction icon here
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      40), // Ensuring circular shape
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    _searchByKey.text = value;
                                  },
                                  textInputAction: TextInputAction.search,
                                  // Add search button to keyboard
                                  onSubmitted: (value) {
                                    _searchByKey.text = value;
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) {
                                          return MobileShops(
                                              _searchByKey.text.toString(),
                                              0,
                                              lat,
                                              long);
                                        },
                                      ),
                                    );
                                  },
                                  decoration: InputDecoration(
                                    hintText: _currentAddress,
                                    filled: true,
                                    fillColor: Colors.white,
                                    // Set background color to white
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) {
                                              return MobileShops(
                                                  _searchByKey.text.toString(),
                                                  0,
                                                  lat,
                                                  long);
                                            },
                                          ),
                                        );
                                      },
                                      icon: Icon(Icons.search),
                                    ),
                                    contentPadding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    Positioned(
                        bottom: -14,
                        // Adjust the bottom position for the text field
                        // left: 50, // Adjust the left position for the text field
                        right: 5,
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        RegisterYourBusiness()));
                          },
                          child: Row(children: [
                            Icon(
                              Icons.edit,
                              size: 15,
                            ),
                            CustomText(
                              title: "Register Your Business",
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            )
                          ]),
                        )),
                  ],
                ),
              ),

              /// New
              // Container(
              //   // width: MediaQuery.of(context).size.width,
              //   height:  MediaQuery.of(context).size.height /3.0,
              //   // color: Colors.red,
              //   child: Stack(
              //     children: [
              //       CarouselSlider(
              //         options: CarouselOptions(
              //           viewportFraction: 1.0,
              //           enlargeCenterPage: false,
              //           autoPlay: true,
              //         ),
              //         items: imgList.map((item) {
              //           return Container(
              //             width: MediaQuery.of(context).size.width,
              //             child: Image.asset(
              //               item,
              //               fit: BoxFit.fill,
              //             ),
              //           );
              //         }).toList(),
              //       ),
              //       Positioned(
              //         top: ScreenUtil().setHeight(10),
              //         right: ScreenUtil().setWidth(5),
              //         child: PopupMenuButton<int>(
              //           icon: Icon(Icons.menu, color: Colors.white, size: ScreenUtil().setWidth(30)),
              //           color: whiteColor,
              //           itemBuilder: (BuildContext context) {
              //             return <PopupMenuEntry<int>>[
              //               // Your PopupMenuItems
              //             ];
              //           },
              //           onSelected: (int value) {
              //             // Handle menu selection
              //           },
              //         ),
              //       ),
              //       Positioned(
              //         // bottom: ScreenUtil().setHeight(25),
              //         top: ScreenUtil().screenHeight/4.5,
              //         left: ScreenUtil().setWidth(50),
              //         right: ScreenUtil().setWidth(50),
              //         child:Container(
              //                     decoration: BoxDecoration(
              //                       boxShadow: [
              //                         BoxShadow(
              //                           color: Colors.black.withOpacity(0.2),
              //                           spreadRadius: 0,
              //                           blurRadius: 30,
              //                           offset: Offset(0, 0), // changes position of shadow
              //                         ),
              //                       ],
              //                     ),
              //                     width: MediaQuery.of(context).size.width - 60, // Adjust the width as needed
              //                     child: CustomTextFormFieldWidget(
              //                       textInputAction: TextInputAction.search,
              //                       onChanged: (v){
              //                         _searchByKey.text=v;
              //                       },
              //                       hint: "Search by Business",
              //                       color: Colors.white,
              //                       fillColor: true,
              //                       borderRadius: 80.r,
              //                       borderSide: BorderSide.none,
              //                       suffixIcon: IconButton(onPressed: (){
              //                         Navigator.push(context, MaterialPageRoute(builder: (context){
              //                           return MobileShops(_searchByKey.text.toString(),0);
              //                         },),);
              //                       }, icon: Icon(Icons.search)),
              //                       // prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: greenColor2,),),
              //                       contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              //                     ),
              //                   ),
              //                 ),
              //
              //       Positioned(
              //         bottom: ScreenUtil().setHeight(-14),
              //         right: ScreenUtil().setWidth(5),
              //         child: TextButton(
              //           onPressed: () {
              //             Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterYourBusiness()));
              //           },
              //           child: Row(
              //             children: [
              //               Icon(Icons.edit, size: ScreenUtil().setWidth(15)),
              //               CustomText(
              //                 title: "Register Your Business",
              //                 fontSize: ScreenUtil().setSp(10),
              //                 fontWeight: FontWeight.bold,
              //                 decoration: TextDecoration.underline,
              //               ),
              //             ],
              //           ),
              //         ),
              //       ),
              //     ],
              //   ),
              // ),
              /// felhal comment
              Flexible(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    keyboardDismissBehavior:
                        ScrollViewKeyboardDismissBehavior.onDrag,
                    scrollDirection: Axis.vertical,
                    itemCount: widget.categories.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          widget.categories[index].mainCategoryName == null
                              ? SizedBox.shrink()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CustomText(
                                    title: widget.categories[index].mainCategoryName
                                            .toString() ??
                                        "NO ",
                                    googleFont: 'Jost',
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                          SizedBox(
                            height: 90,
                            child: widget.categories[index].categories ==
                                    null
                                ? Center(
                                    child: CircularProgressIndicator(),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    keyboardDismissBehavior:
                                        ScrollViewKeyboardDismissBehavior
                                            .onDrag,
                                    itemCount: widget.categories[index].categories!.length,
                                    itemBuilder: (context, index1) {
                                      print(
                                          "${"https://businessonline.pk/images/icons/"}${widget.categories[index].categories![index1].categoryName}.png");
                                      // String? subCategoryName = _categoryList[index]["subCategories"][index1]["subCategoryName"];
                                      return GestureDetector(
                                        onTap: () {
                                          print(
                                              "Tapped on subcategory at index: $index1");
                                          // Add your navigation logic or other functionality here
                                          // For example:
                                          print(widget.categories[index]
                                              .categories![index1].categoryId!);
                                          Globle.subCategoryId = widget.categories[index]
                                              .categories![index1]
                                              .categoryId!;
                                          Globle.subCategoryName =widget.categories[index]
                                              .categories![index1]
                                              .categoryName!;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MobileShops(
                                                  widget.categories[index]
                                                      .categories![index1]
                                                      .categoryName,
                                                  widget.categories[index]
                                                      .categories![index1]
                                                      .categoryId,
                                                  lat,
                                                  long),
                                            ),
                                          );
                                        },
                                        // Replace the image loading code inside the GestureDetector's child with this:
                                        // Replace the image loading code inside the GestureDetector's child with this:
                                        child: Container(
                                          width: 80,
                                          child: Card(
                                            elevation: 0,
                                            shadowColor: const Color.fromRGBO(
                                                0, 66, 37, 0.9),
                                            shape: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                color: Colors.green,
                                                width: 1,
                                              ),
                                            ),
                                            child: Column(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(4.0),
                                                  child: Container(
                                                    height: 30,
                                                    width: 30,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    // Use the Image widget here with errorBuilder
                                                    child: Image.network(
                                                      "${"https://businessonline.pk/images/icons/"}${widget.categories[index].categories![index1].categoryName}.png",
                                                      fit: BoxFit.cover,
                                                      errorBuilder: (context,
                                                          error, stackTrace) {
                                                        // Display a default image if the network image fails to load
                                                        return Image.asset(
                                                          'assets/images/producimage1.png',
                                                          // Provide the path to your default image asset
                                                          fit: BoxFit.cover,
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(height: 14.0),
                                                // Below this container is used for text green container
                                                Column(
                                                  children: [
                                                    Container(
                                                      width: 80,
                                                      height: 30,
                                                      decoration: BoxDecoration(
                                                        color: greenColor2,
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          bottomRight:
                                                              const Radius
                                                                  .circular(
                                                                  10.0),
                                                          bottomLeft:
                                                              const Radius
                                                                  .circular(
                                                                  10.0),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          /// if you want to adjust urdu text then uncomment this.
                                                          // Center(
                                                          //   child: LayoutBuilder(
                                                          //     builder: (context, constraints) {
                                                          //       return FittedBox(
                                                          //         fit: BoxFit.scaleDown,
                                                          //         child: CustomText(
                                                          //           title: "موبائل" ?? "ddd",
                                                          //           googleFont: "Inter",
                                                          //           fontSize: 08,
                                                          //           color: Colors.white,
                                                          //           maxLine: 3,
                                                          //           textOverflow: TextOverflow.ellipsis,
                                                          //           fontWeight: FontWeight.bold,
                                                          //         ),
                                                          //       );
                                                          //     },
                                                          //   ),
                                                          // ),
                                                          Container(
                                                            width: 80,
                                                            height: 30,
                                                            // height: 15,
                                                            decoration:
                                                                BoxDecoration(
                                                              color:
                                                                  greenColor2,
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .only(
                                                                bottomRight:
                                                                    const Radius
                                                                        .circular(
                                                                        10.0),
                                                                bottomLeft:
                                                                    const Radius
                                                                        .circular(
                                                                        10.0),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child:
                                                                  LayoutBuilder(
                                                                builder: (context,
                                                                    constraints) {
                                                                  return FittedBox(
                                                                    fit: BoxFit
                                                                        .scaleDown,
                                                                    child:
                                                                        CustomText(
                                                                      title:widget.categories[index]
                                                                              .categories![index1]
                                                                              .categoryName ??
                                                                          "ddd",
                                                                      googleFont:
                                                                          "Inter",
                                                                      fontSize:
                                                                          08,
                                                                      color: Colors
                                                                          .white,
                                                                      maxLine:
                                                                          3,
                                                                      textOverflow:
                                                                          TextOverflow
                                                                              .ellipsis,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),

                                        /// Old Code

                                        // Container(
                                        //   width: 80,
                                        //   child: Card(
                                        //     elevation: 8,
                                        //     shadowColor: const Color.fromRGBO(0, 66, 37, 0.9),
                                        //     shape: OutlineInputBorder(
                                        //       borderRadius: BorderRadius.circular(10),
                                        //       borderSide: const BorderSide(
                                        //         color: Colors.green,
                                        //         width: 1,
                                        //       ),
                                        //     ),
                                        //     child: Column(
                                        //       children: [
                                        //         Padding(
                                        //           padding: const EdgeInsets.all(4.0),
                                        //           child: Container(
                                        //             height: 30,
                                        //             width: 30,
                                        //             decoration: BoxDecoration(
                                        //               image: DecorationImage(
                                        //                 fit: BoxFit.cover,
                                        //                 image: NetworkImage(
                                        //                   "${"https://businessonline.pk/images/icons/"}${widget.categories[index].categories![index1].categoryName}.png",
                                        //                 ),
                                        //               ),
                                        //               borderRadius: BorderRadius.circular(10),
                                        //             ),
                                        //           ),
                                        //         ),
                                        //         SizedBox(height: 14.0),
                                        //         // Below this container is used for text green container
                                        //         Container(
                                        //           width: 80,
                                        //           height: 30,
                                        //           decoration: BoxDecoration(
                                        //             color: greenColor2,
                                        //             borderRadius: BorderRadius.only(
                                        //               bottomRight: const Radius.circular(10.0),
                                        //               bottomLeft: const Radius.circular(10.0),
                                        //             ),
                                        //           ),
                                        //           child: Center(
                                        //             child: LayoutBuilder(
                                        //               builder: (context, constraints) {
                                        //                 return FittedBox(
                                        //                   fit: BoxFit.scaleDown,
                                        //                   child: CustomText(
                                        //                     title: widget.categories[index].categories![index1].categoryName ?? "ddd",
                                        //                     googleFont: "Inter",
                                        //                     fontSize: 08,
                                        //                     color: Colors.white,
                                        //                     maxLine: 3,
                                        //                     textOverflow: TextOverflow.ellipsis,
                                        //                     fontWeight: FontWeight.bold,
                                        //                   ),
                                        //                 );
                                        //               },
                                        //             ),
                                        //           ),
                                        //         ),
                                        //       ],
                                        //     ),
                                        //   ),
                                        // ),
                                      );
                                    },
                                  ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<HomeCategory>> gettListCategory() async {
    List<HomeCategory> list = [];
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData("http://144.91.86.203/boukapi/api/Home");
    if (res.StatusCode == 0) {
    } else if (res.StatusCode == 200) {
      List data = res.Response;
      print(data.toString());
      setState(() {});
      getData(data);
      return list = data
          .map<HomeCategory>((json) => HomeCategory.fromJson(json))
          .toList();
    } else {
      // SendToLoginScreen();
    }
    return list;
  }

  void _showEmptyDialog(String s) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
              content: Text("$s can't be empty"),
              actions: <Widget>[
                // ignore: deprecated_member_use
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("OK"))
              ],
            ));
  }

  Future<void> getData(List data) async {
    final jsonData = jsonEncode(data);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString("mykey", jsonData);
    print(prefs.getString("mykey")); // to print json data
    list1Share = jsonDecode(prefs.getString("mykey").toString());
    print("kam$list1Share");
    // Globle.listda = list1Share;
  }

  checkGps() async {
    servicestatus = await Geolocator.isLocationServiceEnabled();
    if (servicestatus) {
      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          print('Location permissions are denied');
        } else if (permission == LocationPermission.deniedForever) {
          print("'Location permissions are permanently denied");
        } else {
          haspermission = true;
        }
      } else {
        haspermission = true;
      }

      if (haspermission) {
        setState(() {
          //refresh the UI
        });
        print("'Location permissions are permanently Granted");
        getLocation();
      }
    } else {
      print("GPS Service is not enabled, turn on GPS location");
      // _showMultipleChoiceDialog(context);
      setState(() {
        showAlertDialogeGPS();
        //refresh the UI
      });
    }

    setState(() {
      //refresh the UI
    });
  }

  getLocation() async {
    position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    print(position.longitude); //Output: 80.24599079
    print(position.latitude); //Output: 29.6593457

    lat = position.latitude;
    long = position.longitude;

    setState(() {
      //refresh UI
    });
  }

  void showAlertDialogeGPS() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) => CupertinoAlertDialog(
              content: Text(
                "We need your location data so that we can display businesses near your location. Please enable your GPS",
                style: TextStyle(fontSize: 20),
              ),
              actions: <Widget>[
                // ignore: deprecated_member_use
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("No")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      // AppSettings.openLocationSettings();
                      setState(() {
                        //refresh UI on update
                        getLocation();
                      });
                    },
                    child: const Text("Yes"))
              ],
            ));
  }

  Future<void> fetch() async {
    await controller.fetchHomePageCategories();
    setState(() {});
  }
}
