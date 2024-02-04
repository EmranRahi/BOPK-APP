import 'dart:async';
import 'dart:convert';
import 'package:app_settings/app_settings.dart';
import 'package:businessonlinepk/globle_variable/globle.dart';
import 'package:businessonlinepk/model/BannerClass.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/mobile_shops.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:geolocator/geolocator.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../Controllers/BopkController.dart';
import '../Service/ApiResponse.dart';
import '../Service/ApiService.dart';
import '../model/HomeCategory.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'customs_widgets/custom_appbar.dart';
import 'customs_widgets/custom_text.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'main_page_bopk.dart';
import 'menu_login.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ScrollController listScrollController = ScrollController();
  final TextEditingController _searchByKey = TextEditingController();
  final CarouselController _carouselController = CarouselController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _typeAheadController2 = TextEditingController();
  String favoriteCity = 'Unavailable';
  String? categoryName = "-";
  String? image = "-";
  List? list1Share;
  bool servicestatus = false;
  bool haspermission = false;
  late LocationPermission permission;
  late Position position;
  String long = "", lat = "";
  int? subCategoryid;
  late StreamSubscription<Position> positionStream;
  final BopkController controller = BopkController();

  List<BannersClass>? listbaner = [];
  List<String> imgList = [
    'assets/newbopkpic/b1.png',
    'assets/newbopkpic/b2.png',
  ];
  @override
  void initState() {
    checkGps();
    getBanners();
    // Call the fetchHomePageCategories method when the widget initializes
    controller.fetchHomePageCategories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 3.1,
              // color: Colors.orange,
              child: Stack(
                children: [
                  // Positioned CarouselSlider covering the entire screen
                  CarouselSlider(
                    options: CarouselOptions(
                      // height: MediaQuery.of(context).size.height/3,
                      viewportFraction: 1.0, // Occupy full width
                      enlargeCenterPage: false,
                      autoPlay: true,
                    ),
                    items: imgList.map((item) {
                      return Container(
                        width: MediaQuery.of(context).size.width,
                        child: Image.asset(
                          item,
                          fit: BoxFit.fill,
                        ),
                      );
                    }).toList(),
                  ),
                  // CarouselSlider(
                  //   carouselController: _carouselController,
                  //   options: CarouselOptions(
                  //     autoPlay: true,
                  //   ),
                  //   items: imgList.map((item) {
                  //     return Container(
                  //       width: MediaQuery.of(context).size.width, // Set image width to the screen width
                  //       decoration: BoxDecoration(
                  //         color: Colors.transparent, // You can set a background color if needed
                  //       ),
                  //       child: Image.asset(
                  //         item,
                  //         fit: BoxFit.cover,
                  //       ),
                  //     );
                  //   }).toList(),
                  // ),

                  // Image.asset('assets/newbopkpic/b1.png', fit: BoxFit.cover),
                  Positioned(
                    top: 40,
                    left: 20,
                      child: Image.asset('assets/newbopkpic/p2.png',scale: 3,)),
                  Positioned(
                    top: 50,
                      left: 60,
                      child: CustomText(title: "Business",color: Colors.white,fontSize: 14.sp,fontWeight: FontWeight.bold)),

                  Positioned(
                    top: 25, // Adjust the top position for the menu button
                    right: 5, // Adjust the right position for the menu button
                    child:  PopupMenuButton<int>(
                   icon: Icon(Icons.menu, color: Colors.white,size: 30),
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
                           // Navigator.push(context, MaterialPageRoute(builder: (context)=> MobileShops()));
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
                  ),
                  Positioned(
                    bottom: 10, // Adjust the bottom position for the text field
                    left: 50, // Adjust the left position for the text field
                    right: 50,
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            spreadRadius: 0,
                            blurRadius: 30,
                            offset: Offset(0, 0), // changes position of shadow
                          ),
                        ],
                      ),
                      width: MediaQuery.of(context).size.width - 60, // Adjust the width as needed
                      child: CustomTextFormFieldWidget(
                        onChanged: (v){
                          _searchByKey.text=v;
                        },
                        hint: "Search by Business",
                        color: Colors.white,
                        fillColor: true,
                        borderRadius: 80.r,
                        borderSide: BorderSide.none,
                        suffixIcon: IconButton(onPressed: (){
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return MobileShops(_searchByKey.text.toString(),0);
                          },),);
                        }, icon: Icon(Icons.search)),
                        prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: greenColor2,),),
                        contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                // Flexible(
                //   // optional flex property if flex is 1 because the default flex is 1
                //   flex: 1,
                //   child: Padding(
                //     padding: const EdgeInsets.only(left: 8.0, right: 2.0),
                //     child: Container(
                //       decoration: BoxDecoration(
                //         border: Border.all(
                //           color: Colors.black,
                //         ),
                //         borderRadius: BorderRadius.all(Radius.circular(5)),
                //       ),
                //       child: Column(
                //         children: <Widget>[
                //           Padding(
                //             padding: const EdgeInsets.only(left: 8.0, right: 3.0),
                //             child: TypeAheadFormField(
                //               textFieldConfiguration: TextFieldConfiguration(
                //                 style: TextStyle(fontSize: 18),
                //                 decoration: InputDecoration(hintText: 'Search by town',
                //                     suffixIcon: _typeAheadController.text.isEmpty
                //                         ? null // Show nothing if the text field is empty
                //                         : IconButton(
                //                       icon: const Icon(Icons.clear),
                //                       onPressed:(){
                //                         _typeAheadController.clear();
                //                       },
                //                     ), ),
                //                 controller: this._typeAheadController,
                //               ),
                //               suggestionsCallback: (pattern) {
                //                 return TownName.getSuggestionsTown(pattern);
                //               },
                //               itemBuilder: (context, dynamic suggestion) {
                //                 return ListTile(
                //                   title: Text(suggestion),
                //                 );
                //               },
                //               transitionBuilder:
                //                   (context, suggestionsBox, controller) {
                //                 return suggestionsBox;
                //               },
                //               onSuggestionSelected: (dynamic suggestion) {
                //                 this._typeAheadController.text = suggestion;
                //               },
                //               validator: (value) =>
                //               value!.isEmpty ? 'Please select a city' : null,
                //               onSaved: (value) => this.favoriteCity = value!,
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ),
                SizedBox(width: 10.0),
                // Padding(
                //   padding: const EdgeInsets.only(right: 8.0),
                //   child: Container(
                //     decoration: BoxDecoration(
                //       color: Colors.white,
                //       shape: BoxShape.circle,
                //       boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, spreadRadius: 3)],
                //     ),
                //     child: CircleAvatar(
                //       radius: 28,
                //       backgroundColor: greenColor2,
                //       child: IconButton(
                //           color: Colors.white,
                //           padding: const EdgeInsets.all(5),
                //           iconSize: 28,
                //           icon: const Icon(Icons.search),
                //           onPressed: () {
                //             FocusScope.of(context).unfocus();
                //             if (_typeAheadController2.text.trim().isEmpty) {
                //               _showEmptyDialog("Type something");
                //             } else {
                //               FocusScope.of(context).requestFocus(new FocusNode());
                //               // Navigator.of(context).push(MaterialPageRoute(
                //               //     builder: (context) => ListingPageBusiness(
                //               //       lat: lat,
                //               //       lng: long,
                //               //       areaSearch:
                //               //       _typeAheadController.text.trim(),
                //               //       searchLocation:
                //               //       _typeAheadController2.text.trim(),
                //               //       id: 0,
                //               //     )));
                //               setState(() {});
                //             }
                //           }),
                //     ),
                //   ),
                //     ),

              ],
            ),
            // Flexible(
            //   child: SingleChildScrollView(
            //     child: ListView.builder(
            //       scrollDirection: Axis.vertical,
            //       itemCount: _categoryList.length,
            //       shrinkWrap: true,
            //       physics: NeverScrollableScrollPhysics(),
            //       itemBuilder: (context, index) {
            //         return GestureDetector(
            //           onTap: (){
            //             Navigator.push(context, MaterialPageRoute(builder: (context){
            //               return MobileShops();
            //             },),);
            //           },
            //           child: Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             children: [
            //               Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Text(
            //                   _categoryList[index]["categoryName"] ?? "NO ",
            //                   style: const TextStyle(
            //                       fontSize: 18,
            //                       color: Colors.black,
            //                       fontWeight: FontWeight.bold),
            //                 ),
            //               ),
            //               SizedBox(
            //                 height: 90,
            //                 child: ListView.builder(
            //                     scrollDirection: Axis.horizontal,
            //                     itemCount: _categoryList[index]["subCategories"]
            //                         .length,
            //                     itemBuilder: (context, index1) {
            //                       String? subCategoryName = _categoryList[index]
            //                                   ["subCategories"][index1]
            //                               ["subCategoryName"] ??
            //                           0;
            //
            //                       image = _categoryList[index]["subCategories"]
            //                           [index1]["subCategoryIcon"];
            //                       return Container(
            //                         height: 90,
            //                         width: 80,
            //                         child: InkWell(
            //                           child: Card(
            //                             elevation: 8,
            //                             shadowColor: const Color.fromRGBO(
            //                                 0, 66, 37, 0.9),
            //                             // margin: EdgeInsets.all(20),
            //                             shape: OutlineInputBorder(
            //                                 borderRadius:
            //                                     BorderRadius.circular(10),
            //                                 borderSide: const BorderSide(
            //                                     color: Colors.green, width: 1)),
            //                             child: Column(
            //                               children: [
            //                                 // Padding(
            //                                 //       padding: const EdgeInsets.only(
            //                                 //           top: 8.0,
            //                                 //           left: 0.0,
            //                                 //           right: 0.0,
            //                                 //           bottom: 0.0),
            //                                 //       child: Image.network(
            //                                 //          "https://purepng.com/public/uploads/large/purepng.com-mariomariofictional-charactervideo-gamefranchisenintendodesigner-1701528634653vywuz.png",
            //                                 //        // list[index].subCategories[index1].subCategoryIcon??"ddd",
            //                                 //         width: 50,
            //                                 //         height: 50,
            //                                 //       ),
            //                                 //     ),
            //                                 Padding(
            //                                   padding:
            //                                       const EdgeInsets.all(4.0),
            //                                   child: Container(
            //                                     height: 30,
            //                                     width: 30,
            //                                     decoration: BoxDecoration(
            //                                       image: DecorationImage(
            //                                         fit: BoxFit.cover,
            //                                         image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwGew7kiO-3fKN_s-G3Aauz9csC64n6e6al1Vd1cqGiw&s"
            //                                           // "https://www.businessonlineuk.com/Images/CategoryIcons/" +
            //                                           //     image!,
            //                                         ),
            //                                       ),
            //                                       // color: Colors.red,
            //                                       borderRadius:
            //                                           BorderRadius.circular(10),
            //                                     ),
            //                                   ),
            //                                 ),
            //                                 SizedBox(
            //                                   height: 14.0,
            //                                 ),
            //                                 Container(
            //                                   width: 80,
            //                                   height: 30,
            //                                   decoration: new BoxDecoration(
            //                                       color: greenColor2,
            //                                       borderRadius:
            //                                           new BorderRadius.only(
            //                                         // topLeft: const Radius.circular(10.0),
            //                                         // topRight: const Radius.circular(10.0),
            //                                         bottomRight:
            //                                             const Radius.circular(
            //                                                 10.0),
            //                                         bottomLeft:
            //                                             const Radius.circular(
            //                                                 10.0),
            //                                       )),
            //                                   // color: Colors.green,
            //                                   child: Container(
            //                                     child: Padding(
            //                                       padding:
            //                                           const EdgeInsets.only(
            //                                               left: 5.0,
            //                                               right: 5.0),
            //                                       child: Center(
            //                                         child: Text(
            //                                           subCategoryName ?? "ddd",
            //                                           style: const TextStyle(
            //                                             fontSize: 10,
            //                                             color: Colors.white,
            //                                           ),
            //                                         ),
            //                                       ),
            //                                     ),
            //                                   ),
            //                                 ),
            //                               ],
            //                             ),
            //                           ),
            //                           onTap: () {
            //                             subCategoryid = _categoryList[index]
            //                                         ["subCategories"][index1]
            //                                     ["subCategoryId"] ??
            //                                 0;
            //                             // Navigator.of(context).push(
            //                             //     CupertinoPageRoute(
            //                             //         builder:
            //                             //             (BuildContext context) =>
            //                             //                 BusinessListingPageByCategory(
            //                             //                   lat: lat,
            //                             //                   lng: long,
            //                             //                   areaSearch: '',
            //                             //                   searchLocation: '',
            //                             //                   id: subCategoryid!
            //                             //                       .toInt(),
            //                             //                 )));
            //                           },
            //                         ),
            //                       );
            //                     }),
            //               )
            //             ],
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Flexible(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: ListView.builder(
                  keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                  scrollDirection: Axis.vertical,
                  itemCount:  controller.categories.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            controller.categories[index].mainCategoryName.toString() ?? "NO ",
                            style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 90,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                            itemCount:controller.categories[index].categories?.length??0,
                            itemBuilder: (context, index1) {
                              // String? subCategoryName = _categoryList[index]["subCategories"][index1]["subCategoryName"];
                              return GestureDetector(
                                onTap: () {
                                  print("Tapped on subcategory at index: $index1");
                                  // Add your navigation logic or other functionality here
                                  // For example:
                                  print(controller.categories[index].categories![index1].categoryId!);
                                 Globle.subCategoryId= controller.categories[index].categories![index1].categoryId!;
                                 Globle.subCategoryName= controller.categories[index].categories![index1].categoryName!;
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => MobileShops(controller.categories[index].categories![index1].categoryName,controller.categories[index].categories![index1].categoryId)),
                                  );
                                },
                                child: Container(
                                  width: 80,
                                  child: Card(
                                    elevation: 8,
                                    shadowColor: const Color.fromRGBO(0, 66, 37, 0.9),
                                    shape: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        color: Colors.green,
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Container(
                                            height: 30,
                                            width: 30,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSwGew7kiO-3fKN_s-G3Aauz9csC64n6e6al1Vd1cqGiw&s",
                                                ),
                                              ),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 14.0),
                                        // belo this container is used for text green container
                                        Container(
                                          width: 80,
                                          height: 30,
                                          decoration: BoxDecoration(
                                            color: greenColor2,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: const Radius.circular(10.0),
                                              bottomLeft: const Radius.circular(10.0),
                                            ),
                                          ),
                                          child: Center(
                                            child: Text(
                                              controller.categories[index].categories?[index1].categoryName ?? "ddd",
                                              style: const TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            ),
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
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
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
    print("kam" + list1Share.toString());
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

    long = position.longitude.toString();
    lat = position.latitude.toString();

    setState(() {
      //refresh UI
    });

    LocationSettings locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high, //accuracy of the location data
      distanceFilter: 100, //minimum distance (measured in meters) a
      //device must move horizontally before an update event is generated;
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings)
            .listen((Position position) {
      print(position.longitude); //Output: 80.24599079
      print(position.latitude); //Output: 29.6593457

      long = position.longitude.toString();
      lat = position.latitude.toString();

      setState(() {
        //refresh UI on update
      });
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
                      AppSettings.openLocationSettings();
                      setState(() {
                        //refresh UI on update
                        getLocation();
                      });
                    },
                    child: const Text("Yes"))
              ],
            ));
  }

  Future<List<BannersClass>> getBanners() async {
    List<BannersClass> list = [];
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData(
        "http://144.91.86.203/boukapi/api/Banners/allBanners");
    print(res.StatusCode);
    if (res.StatusCode == 0) {
    } else if (res.StatusCode == 200) {
      List data = res.Response;
      print(data.toString());
      setState(() {});
      print("xxxxxxxxxxxxxx"+data.toString());

      return listbaner = data
          .map<BannersClass>((json) => BannersClass.fromJson(json))
          .toList();
    } else {
      // SendToLoginScreen();
    }
    return list;
  }
}

class TownName {
  static Future<List<dynamic>> getSuggestionsTown(String strTown) async {
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData(
        "http://144.91.86.203/boukapi/api/Cities/GetTowns/" + strTown);

    // List<String> data = res.Response;
    print("rash" + res.Response.toString());
    List<dynamic> matches = <dynamic>[];
    matches.addAll(res.Response);

    matches.retainWhere((s) => s.toLowerCase().contains(strTown.toLowerCase()));
    return matches;
  }
}

class CitiesService {
  static Future<List<dynamic>> getSuggestions(String query, String lat, String long) async {
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData(
        "http://144.91.86.203/boukapi/api/Home/autoCompSubCatName?prefix=" +
            query +
            "&clat="+lat+"&clong="+long);

    // List<String> data = res.Response;
    print("rash" + res.Response.toString());
    List<dynamic> matches = <dynamic>[];
    matches.addAll(res.Response);

    matches.retainWhere((s) => s.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }
}

//App Bar
// appBar: PreferredSize(
//   preferredSize:  Size.fromHeight(200),
//   child: AppBar(
//    flexibleSpace:Container(
//      decoration:BoxDecoration(
//        image: DecorationImage(
//          image:  AssetImage("assets/newbopkpic/b1.png"),
//          fit: BoxFit.fill,
//        ),
//      ),
//    ),
//   ),
// ),

// backgroundColor: Colors.white,
// drawer: NavBar(),
// appBar: customAppBar1(
//   elevation: 0,
//   centerTitle: false,
//   title: CustomText(
//     title: 'Business',
//     color: grayColor,
//     fontWeight: FontWeight.bold,
//   ),
//
//   action: Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//
//       // PopupMenuButton<int>(
//       //   icon: Icon(Icons.menu, color: greenColor2,size: 30),
//       //   color: whiteColor,
//       //   itemBuilder: (BuildContext context) {
//       //     return <PopupMenuEntry<int>>[
//       //
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> MenuLogin()));
//       //         },
//       //         value: 0,
//       //         child: CustomText(title: "Login", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> RegisterYourBusiness()));
//       //         },
//       //         value: 1,
//       //         child: CustomText(title: "Register Your Business", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> HomePage()));
//       //         },
//       //         value: 2,
//       //         child: CustomText(title: "BOPK Home", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> VerifyDownLoadScreen()));
//       //         },
//       //         value: 3,
//       //         child: CustomText(title: "Verify Download", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> PayNowScreen()));
//       //         },
//       //         value: 4,
//       //         child: CustomText(title: "Pay Now", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> GetDisCountCard()));
//       //         },
//       //         value: 5,
//       //         child: CustomText(title: "Get Discount Card", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> GetYourBusinessNow()));
//       //         },
//       //         value: 6,
//       //         child: CustomText(title: "Get Your Business Verify Now", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> DealAndDisCount()));
//       //         },
//       //         value: 7,
//       //         child: CustomText(title: "Deal And Discount ", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> MobileShops()));
//       //         },
//       //         value: 8,
//       //         child: CustomText(title: "Mobile Shops", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> BusinessForSale()));
//       //         },
//       //         value: 10,
//       //         child: CustomText(title: "Business For Sale", fontStyle: FontStyle.italic),
//       //       ),
//       //       PopupMenuDivider(),
//       //       PopupMenuItem<int>(
//       //         onTap: (){
//       //           Navigator.push(context, MaterialPageRoute(builder: (context)=> AddJobs()));
//       //         },
//       //         value: 8,
//       //         child: CustomText(title: "Add Jobs", fontStyle: FontStyle.italic),
//       //       ),
//       //
//       //     ];
//       //   },
//       //   onSelected: (int value) {
//       //     if (value == 0) {
//       //       print("Login menu is selected.");
//       //     } else if (value == 1) {
//       //       print("Register Your Business menu is selected.");
//       //     } else if (value == 2) {
//       //       print("BOPK Home menu is selected.");
//       //     } else if (value == 3) {
//       //       print("Business For Sale menu is selected.");
//       //     } else if (value == 4) {
//       //       print("About us menu is selected.");
//       //     } else if (value == 5) {
//       //       print("Contact us menu is selected.");
//       //     }else if (value == 6) {
//       //       print("Contact us menu is selected.");
//       //     }else if (value == 7) {
//       //       print("Contact us menu is selected.");
//       //     }
//       //   },
//       // ),
//     ],
//   ),