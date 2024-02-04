import 'dart:convert';
import 'package:http/http.dart'as http;
import 'package:businessonlinepk/globle_variable/globle.dart';
import 'package:businessonlinepk/view/HomePage_ofBopk.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_popupofmenu.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/deal_and_discount_screen.dart';
import 'package:businessonlinepk/view/get_discount_card_screeen.dart';
import 'package:businessonlinepk/view/get_your_business_now.dart';
import 'package:businessonlinepk/view/main_page_bopk.dart';
import 'package:businessonlinepk/view/menu_login.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controllers/Api_Controller.dart';
import '../model/DetailStaticBusinessModel.dart';
import '../model/StaticListModelPage.dart';
import 'StaticBusinessDetailsPage.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';

class MobileShops extends StatefulWidget {
    MobileShops(this.searchKey,this.categoryId, {super.key});
   String? searchKey = "";
    int? categoryId=0;
  @override
  State<MobileShops> createState() => _MobileShopsState();
}

class _MobileShopsState extends State<MobileShops> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey = new GlobalKey<ScaffoldState>();
  // List<StaticListSearchModel> searchResults = [];
  TextEditingController searchController = TextEditingController();
  ScrollController _scrollController = ScrollController();
  StaticListModel? businessModel1 = StaticListModel();
  // final StaticListPageController subCategoryController = StaticListPageController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
  _scrollToTop() {
    _scrollController.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
  }

  final APIController apiController = APIController();
  List<StaticListModel>? data;
  @override
  void initState() {
    super.initState();
    if(widget.categoryId!>0){
      fetchData(widget.categoryId!.toInt());
    }else{
      fetchData1(widget.searchKey.toString());
    }


  }
  Future<void> fetchData1(String query) async {
    final response = await http.get(Uri.parse('http://144.91.86.203/bopkapi/Karobar/Search?search=$query'));
    print('http://144.91.86.203/bopkapi/Karobar/Search?search=$query');
    if (response.statusCode == 200) {
      // If the server returns a 200 OK response, parse the data
      List<StaticListModel> results = List<StaticListModel>.from(
        json.decode(response.body).map((x) => StaticListModel.fromJson(x)),
      );

      // Update the state to trigger a rebuild with the fetched data
      setState(() {
        data = results;
      });
    } else {
      // If the server did not return a 200 OK response, throw an exception.
      throw Exception('Failed to load data');
    }
  }
  void search() {
    String query = searchController.text;
    if (query.isNotEmpty) {
      fetchData1(query);
    }
  }
  Future<void> fetchData(int subCategoryId,) async {
    // try {
      List<StaticListModel>? fetchedData = await apiController.fetchData(subCategoryId);
      if (fetchedData != null) {
        data = fetchedData;
        print('Data length: ${data?.length}');
        setState(() {});
      } else {
        print('Error fetching data: Data is null');
      }
    // } catch (e) {
    //   print('Error fetching data: $e');
    // }
  }

  Future<void> getDetails(int? karobarId1) async {
    APIController controller = APIController();

    // Call fetchDataDetails and await the result
    businessModel1 = (await controller.fetchData(karobarId1!)) as StaticListModel?;

    // if (businessModel != null) {
    print('Business Title: ${businessModel1!.title}');
    print('Business Description: ${businessModel1?.description}');
    print('Business Location: ${businessModel1?.location?.locationName}');
    // } else {
    // Handle the case where the data fetch was unsuccessful
    // }
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      // drawer: Drawer(
      //     child: ListView(
      //         children: <Widget>[
      //           ListTile(
      //             leading: Icon(Icons.shopping_cart),
      //             title: Text('Checkout'),
      //             onTap: (){
      //               Navigator.pushNamed(context, '/home');
      //             },
      //           ),
      //           ListTile(
      //             leading: Icon(Icons.report),
      //             title: Text('Transactions'),
      //             onTap: (){
      //               Navigator.pushNamed(context, '/transactionsList');
      //             },
      //           ),
      //         ]
      //     )
      // ),
      appBar: customAppBar1(
        elevation: 0,
        centerTitle: false,
        title: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              CustomText(
                title: widget.searchKey,
                color: grayColor,
                googleFont: "Jost",
                fontWeight: FontWeight.w600,
                fontSize: 25.sp,
              ),
            ],
          ),
        ),
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },icon:
           Icon(
            Icons.arrow_back,
            color: greenColor2,
            size: 30,
          ),
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
          ],
        ),
      ),
      key: _drawerscaffoldkey, //set gobal key defined above
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Column(
            children: [
              Row(children: [
                Flexible(
                  flex: 8,
                  child: Container(
                      height: 40.h,
                    decoration: BoxDecoration(
                        color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          spreadRadius: 1,
                          blurRadius: 7,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: CustomTextFormFieldWidget(
                      onChanged: (v){
                        searchController.text=v;
                      },
                      borderRadius: 30,
                      contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      suffixIcon: IconButton(onPressed: (){
                        search();
                      }, icon: Icon(Icons.search),),
                      hint: "Search Your Business",
                      prefixIcon: IconButton(onPressed: (){}, icon: Icon(Icons.location_on,color: greenColor2),),
                      // color: Colors.white,
                      // fillColor: true,
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Align(
                  alignment: Alignment.topRight,
                  child: PopupMenuButton<String>(
                    elevation: 0,
                    onSelected: (String choice) {
                      // Handle menu item selection here
                      print("Selected: $choice");
                    },
                    // icon: Icon(
                    //   Icons.menu, // Change the icon here
                    //   color: tealColor, // You can customize the icon's color
                    // ),
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: '1',
                          child: CustomText(
                              title: 'Search by popularity', color: grayColor),
                        ),
                        PopupMenuItem<String>(
                          value: '2',
                          child: CustomText(
                              title: 'Show Open Shops', color: grayColor),
                        ),
                        PopupMenuItem<String>(
                          value: '3',
                          child: CustomText(
                              title: 'Show Close Shops', color: grayColor),
                        ),
                      ];
                    },
                    child: Image.asset('assets/newbopkpic/filter.png',scale: 3,)
                    // CustomText(
                    //     title: "Filter",
                    //     color: tealColor,
                    //     fontSize: 15.sp,
                    //     fontWeight: FontWeight.bold,
                    //   ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h,),
              //Do You Find Your Business
              // Custom_Button_Widget(
              //   width: MediaQuery.of(context).size.width / 1.0,
              //   ontap: () {},
              //   rd: 10,
              //   color: greenColor2,
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       CustomText(
              //         title: "Do You Find Your Business? No?",
              //         color: whiteColor,
              //         fontSize: 12,
              //         fontWeight: FontWeight.bold,
              //       ),
              //       CustomText(
              //         title: "Register It Now",
              //         fontSize: 12,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ],
              //   ),
              // ),
              /// add My More Code in this Place
              data == null
                  ? Center(child: CircularProgressIndicator())  // Show loading indicator while data is being loaded
                  : data!.isEmpty
                  ? Center(child: Text("No data available"))
                  : Expanded(
                child: ListView.builder(
                    keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
                    controller: _scrollController,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: data!.length,
                    itemBuilder: (context, index) {
                      print(data?[index].speciality);
                      String specialties = data?[index].speciality ?? "";
                      List<String> specialtyList = specialties.split(',');

                      // Take only the first 3 specialties
                      List<String> displaySpecialties = specialtyList.length > 3
                          ? specialtyList.sublist(0, 3)
                          : specialtyList;

                      List<Widget> specialtyButtons = [];

                      for (String specialty in displaySpecialties) {
                        if (specialty.trim().isNotEmpty) {
                          specialtyButtons.add(
                            Container(
                              height: 30,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    spreadRadius: 1,
                                    blurRadius: 7,
                                    offset: Offset(0, 0),
                                  ),
                                ],
                              ),

                              child: TextButton(
                                onPressed: () {
                                  // Handle button press
                                },
                                child: CustomText(title:specialty.trim(),googleFont: "Jost",color: grayColor,
                                fontSize: 10,
                                ),
                              ),
                            ),
                          );
                          specialtyButtons.add(SizedBox(width: 8)); // Add some spacing between buttons
                        }
                      }

                      return  Container(
                        // alignment: Alignment.center,
                        height: MediaQuery.of(context).size.height/3.9,
                        width: MediaQuery.of(context).size.width,
                        // padding: EdgeInsets.all(8),
                        margin: EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          border: Border.all(color: grayColor2),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Stack(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap:(){
                                /// add this area More code
                                Navigator.push(context, MaterialPageRoute(builder: (context) => StaticBusinessDetailsPage(data![index].karobarId,data![index].title)));
                              },
                              child: Image.asset('assets/images/bopk1.png',
                                width: MediaQuery.of(context).size.width/2.9,
                                repeat: ImageRepeat.noRepeat,

                              ),
                            ),
                            Positioned(
                              left:MediaQuery.of(context).size.width * 0.39,
                              top: 10,
                              child: CustomText(
                                title: data?[index].title,
                                color: greenColor2,
                                googleFont: "Jost",
                                fontWeight: FontWeight.bold,
                                fontSize:
                                MediaQuery.of(context).size.width * 0.03,
                                textOverflow: TextOverflow.ellipsis,
                                textOverflow1: TextOverflow.ellipsis,
                              ),
                            ),
                            // CustomText(
                            //   title: data?[index].title,
                            //   color: greenColor2,
                            //   fontWeight: FontWeight.bold,
                            //   fontSize: MediaQuery.of(context).size.width* 0.03,
                            // ),
                            Positioned(
                              left: 130.w,
                              top: 35.h,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    color: greenColor2,
                                  ),
                                  SizedBox(
                                      width: ScreenUtil()
                                          .screenWidth /
                                          40),
                                  CustomText(
                                    title:
                                    "0.01 KM away",
                                    googleFont: "Jost",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: grayColor,
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              left:130.w,
                              top: 65.h,
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.access_time_rounded,
                                    color: greenColor2,
                                  ),
                                  SizedBox(
                                      width: ScreenUtil()
                                          .screenWidth /
                                          40),
                                  CustomText(
                                    title: "Open Now",
                                    googleFont: "Jost",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: grayColor,
                                  )
                                ],
                              ),
                            ),
                            Positioned(
                              left: 130.w,
                              top: 100.h,
                              child: Row(
                                children: [
                                  CustomContainer(
                                    height: 30,
                                    width: 30,
                                    ontap: () {

                                    },
                                    rd: 100,
                                    color: whiteColor,
                                    boxShadow: true,
                                    child: Image.asset(
                                      'assets/images/navigation.png',),
                                  ),
                                  SizedBox(width: 10.w),
                                  businessModel1?.contactPhone==null
                                      ?  CustomContainer(
                                      height: 30,
                                      width: 30,
                                      ontap: () {
                                        print(businessModel1?.contactPhone);
                                        if (businessModel1?.contactPhone != null) {
                                          String phoneUrl = 'tel:${businessModel1!.contactPhone}';
                                          launchUrl(Uri.parse(phoneUrl));
                                        }
                                      },
                                      rd: 100,
                                      color: whiteColor,
                                      boxShadow: true,
                                      child: Image.asset(
                                          'assets/images/call1.png'))
                                      :  CustomContainer(
                                      height: 30,
                                      width: 30,
                                      ontap: () {
                                        print(businessModel1?.contactPhone);
                                        if (businessModel1?.contactPhone != null) {
                                          String phoneUrl = 'tel:${businessModel1!.contactPhone}';
                                          launchUrl(Uri.parse(phoneUrl));
                                        }
                                      },
                                      rd: 100,
                                      color: whiteColor,
                                      boxShadow: true,
                                      child: Image.asset(
                                          'assets/images/call.png')),


                                  SizedBox(width: 10.w),
                                  businessModel1?.contactPhone == null ?

                                  CustomContainer(
                                      height: 30,
                                      width: 30,
                                      ontap: () {
                                        print(businessModel1?.contactPhone);
                                        if (businessModel1?.contactPhone != null) {
                                          String whatsappUrl = 'https://wa.me/${businessModel1!.contactPhone}';
                                          launchUrl(Uri.parse(whatsappUrl));
                                        }
                                      },
                                      rd: 100,
                                      color: whiteColor,
                                      boxShadow: true,
                                      child: Image.asset(
                                          'assets/images/whtsapp.png')) :CustomContainer(
                                      height: 30,
                                      width: 30,
                                      ontap: () {
                                        print(businessModel1?.contactPhone);
                                        if (businessModel1?.contactPhone != null) {
                                          String whatsappUrl = 'https://wa.me/${businessModel1!.contactPhone}';
                                          launchUrl(Uri.parse(whatsappUrl));
                                        }
                                      },
                                      rd: 100,
                                      color: whiteColor,
                                      boxShadow: true,
                                      child: Image.asset(
                                          'assets/images/whtsapp.png')),
                                  SizedBox(width: 10.w),
                                  CustomContainer(
                                      height: 30,
                                      width: 30,
                                      ontap: () {},
                                      rd: 100,
                                      color: whiteColor,
                                      boxShadow: true,
                                      child: Image.asset(
                                          'assets/images/sms.png')),
                                  SizedBox(width: 10.w),
                                  CustomContainer(
                                    height: 30,
                                    width: 30,
                                    ontap: () {},
                                    rd: 100,
                                    color: whiteColor,
                                    boxShadow: true,
                                    child: Image.asset(
                                        'assets/images/share.png'),
                                  ),
                                ],
                              ),
                            ),

                            Positioned(
                              top:130.h,
                              left:10.w,
                              child:
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: specialtyButtons,
                                ),
                              ),
                            ),

                          ],
                        ),
                      );

                      // return Container(
                      //   // alignment: Alignment.center,
                      //   height: MediaQuery.of(context).size.height/3.9,
                      //   width: MediaQuery.of(context).size.width,
                      //   // padding: EdgeInsets.all(8),
                      //   margin: EdgeInsets.symmetric(vertical: 8),
                      //   decoration: BoxDecoration(
                      //     color: whiteColor,
                      //     border: Border.all(color: grayColor2),
                      //     borderRadius: BorderRadius.circular(12.r),
                      //   ),
                      //   child: Stack(
                      //     // mainAxisAlignment: MainAxisAlignment.start,
                      //     // crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       InkWell(
                      //         onTap:(){
                      //           /// add this area More code
                      //           Navigator.push(context, MaterialPageRoute(builder: (context) => StaticBusinessDetailsPage(data![index].karobarId,data![index].title)));
                      //         },
                      //         child: Image.asset('assets/images/bopk1.png',
                      //           width: MediaQuery.of(context).size.width/2.9,
                      //           repeat: ImageRepeat.noRepeat,
                      //
                      //         ),
                      //       ),
                      //       Positioned(
                      //         left:MediaQuery.of(context).size.width * 0.39,
                      //         top: 10,
                      //         child: CustomText(
                      //           title: data?[index].title,
                      //           color: greenColor2,
                      //           googleFont: "Jost",
                      //           fontWeight: FontWeight.bold,
                      //           fontSize:
                      //            MediaQuery.of(context).size.width * 0.04,
                      //           textOverflow: TextOverflow.ellipsis,
                      //           textOverflow1: TextOverflow.ellipsis,
                      //         ),
                      //       ),
                      //       // CustomText(
                      //       //   title: data?[index].title,
                      //       //   color: greenColor2,
                      //       //   fontWeight: FontWeight.bold,
                      //       //   fontSize: MediaQuery.of(context).size.width* 0.03,
                      //       // ),
                      //       Positioned(
                      //         left: 130.w,
                      //         top: 35.h,
                      //         child: Row(
                      //           children: [
                      //             Icon(
                      //               Icons.location_on,
                      //               color: greenColor2,
                      //             ),
                      //             SizedBox(
                      //                 width: ScreenUtil()
                      //                     .screenWidth /
                      //                     40),
                      //             CustomText(
                      //               title:
                      //               "0.01 KM away",
                      //               googleFont: "Jost",
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 12,
                      //               color: grayColor,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Positioned(
                      //         left:130.w,
                      //         top: 65.h,
                      //         child: Row(
                      //           children: [
                      //             Icon(
                      //               Icons.access_time_rounded,
                      //               color: greenColor2,
                      //             ),
                      //             SizedBox(
                      //                 width: ScreenUtil()
                      //                     .screenWidth /
                      //                     40),
                      //             CustomText(
                      //               title: "Open Now",
                      //               googleFont: "Jost",
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 12,
                      //               color: grayColor,
                      //             )
                      //           ],
                      //         ),
                      //       ),
                      //       Positioned(
                      //         left: 130.w,
                      //         top: 100.h,
                      //         child: Row(
                      //           children: [
                      //             CustomContainer(
                      //               height: 30,
                      //               width: 30,
                      //               ontap: () {
                      //
                      //               },
                      //               rd: 100,
                      //               color: whiteColor,
                      //               boxShadow: true,
                      //               child: Image.asset(
                      //                   'assets/images/navigation.png',),
                      //             ),
                      //               SizedBox(width: 10.w),
                      //           businessModel1?.contactPhone==null
                      //                 ?  CustomContainer(
                      //                 height: 30,
                      //                 width: 30,
                      //                 ontap: () {
                      //                   print(businessModel1?.contactPhone);
                      //                   if (businessModel1?.contactPhone != null) {
                      //                     String phoneUrl = 'tel:${businessModel1!.contactPhone}';
                      //                     launchUrl(Uri.parse(phoneUrl));
                      //                   }
                      //                 },
                      //                 rd: 100,
                      //                 color: whiteColor,
                      //                 boxShadow: true,
                      //                 child: Image.asset(
                      //                     'assets/images/call1.png'))
                      //                 :  CustomContainer(
                      //                 height: 30,
                      //                 width: 30,
                      //                 ontap: () {
                      //                   print(businessModel1?.contactPhone);
                      //                   if (businessModel1?.contactPhone != null) {
                      //                     String phoneUrl = 'tel:${businessModel1!.contactPhone}';
                      //                     launchUrl(Uri.parse(phoneUrl));
                      //                   }
                      //                 },
                      //                 rd: 100,
                      //                 color: whiteColor,
                      //                 boxShadow: true,
                      //                 child: Image.asset(
                      //                     'assets/images/call.png')),
                      //
                      //
                      //             SizedBox(width: 10.w),
                      //           businessModel1?.contactPhone == null ?
                      //
                      //           CustomContainer(
                      //                 height: 30,
                      //                 width: 30,
                      //                 ontap: () {
                      //                   print(businessModel1?.contactPhone);
                      //                   if (businessModel1?.contactPhone != null) {
                      //                     String whatsappUrl = 'https://wa.me/${businessModel1!.contactPhone}';
                      //                     launchUrl(Uri.parse(whatsappUrl));
                      //                   }
                      //                 },
                      //                 rd: 100,
                      //                 color: whiteColor,
                      //                 boxShadow: true,
                      //                 child: Image.asset(
                      //                     'assets/images/whtsapp.png')) :CustomContainer(
                      //               height: 30,
                      //               width: 30,
                      //               ontap: () {
                      //                 print(businessModel1?.contactPhone);
                      //                 if (businessModel1?.contactPhone != null) {
                      //                   String whatsappUrl = 'https://wa.me/${businessModel1!.contactPhone}';
                      //                   launchUrl(Uri.parse(whatsappUrl));
                      //                 }
                      //               },
                      //               rd: 100,
                      //               color: whiteColor,
                      //               boxShadow: true,
                      //               child: Image.asset(
                      //                   'assets/images/whtsapp.png')),
                      //             SizedBox(width: 10.w),
                      //             CustomContainer(
                      //                 height: 30,
                      //                 width: 30,
                      //                 ontap: () {},
                      //                 rd: 100,
                      //                 color: whiteColor,
                      //                 boxShadow: true,
                      //                 child: Image.asset(
                      //                     'assets/images/sms.png')),
                      //             SizedBox(width: 10.w),
                      //             CustomContainer(
                      //               height: 30,
                      //               width: 30,
                      //               ontap: () {},
                      //               rd: 100,
                      //               color: whiteColor,
                      //               boxShadow: true,
                      //               child: Image.asset(
                      //                   'assets/images/share.png'),
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Positioned(
                      //         top:135.h,
                      //         left:10.w,
                      //         child:
                      //         Row(
                      //           children: [
                      //             Custom_Button_Widget(
                      //               ontap: () {
                      //                 print('iphone');
                      //               },
                      //               rd: 7.r,
                      //               height: 25.h,
                      //               width: 90.w,
                      //               color: whiteColor,
                      //               boxShadow: true,
                      //               child:
                      //               CustomText(
                      //                 title: "${displayText}",
                      //                 googleFont: "Jost",
                      //                 color: grayColor,
                      //               ),
                      //             ),
                      //             // SizedBox(
                      //             //   width: MediaQuery.of(context).size.width / 25,
                      //             // ),
                      //             // Custom_Button_Widget(
                      //             //   ontap: () {
                      //             //     print("Click me Samsung");
                      //             //   },
                      //             //   rd: 7.r,
                      //             //   height: 25.h,
                      //             //   width: 90.w,
                      //             //   color: whiteColor,
                      //             //   boxShadow: true,
                      //             //   child: CustomText(
                      //             //     title: "Samsung",
                      //             //     googleFont: "Jost",
                      //             //     color: grayColor,
                      //             //   ),
                      //             // ),
                      //
                      //           ],
                      //         ),
                      //       ),
                      //
                      //     ],
                      //   ),
                      // );
                    }),
              ),
              // data == null
              //     ? Center(child: CircularProgressIndicator())
              //     : data!.isEmpty
              //     ? Center(child: Text("No data available"))
              //     : Expanded(
              //   child: ListView.builder(
              //     key: Key('your_unique_list_view_key'),
              //     controller: _scrollController,
              //     physics: ClampingScrollPhysics(),
              //     shrinkWrap: true,
              //     itemCount: data!.length,
              //     itemBuilder: (context, index) {
              //       return Container(
              //         // Your existing container code
              //         // ...
              //       );
              //     },
              //   ),
              // ),

              SizedBox(
                height: 10,
              )

              /// Add more Code
            ],
          ),
        ),

    );
  }
  // // Function to launch the phone call
  // void _launchPhoneCall(String phoneNumber) async {
  //   if (await canLaunch(phoneNumber)) {
  //     await launch(phoneNumber);
  //   } else {
  //     // Handle error
  //     print('Could not launch $phoneNumber');
  //   }
  // }
}

