import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_appbar.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Controllers/Api_Controller.dart';
import '../model/SearchBusinessModel.dart';
import '../model/StaticListModelPage.dart';
import 'StaticBusinessDetailsPage.dart';

class MobileShops extends StatefulWidget {
  MobileShops(this.searchKey, this.categoryId, this.lat, this.long,
      {super.key});

  String? searchKey = "";
  int? categoryId = 0;
  double? lat, long;

  @override
  State<MobileShops> createState() => _MobileShopsState();
}

class _MobileShopsState extends State<MobileShops> {
  final GlobalKey<ScaffoldState> _drawerscaffoldkey =
      GlobalKey<ScaffoldState>();
  TextEditingController searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  bool? boxShadow = true;
  SearchBusinessModel searchBusinessModel=SearchBusinessModel();
  final APIController apiController = APIController();
  List<StaticListModel>? data;

  late Future<StaticListModel> futureData;
  late Future<StaticListModel> getBusinessData;
  List<Datum> dataList = [];
  int page = 1;
  double _scrollPosition = 0.0;
  bool _loading = false;
  bool _hasMoreData = true;


  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
    if (widget.categoryId! > 0) {
      _loadMoreData("no");
    } else {
    _loadMoreData(widget.searchKey.toString());
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE4E4E4),
      appBar: customAppBar1(
        backgroundColor: Color(0xffE4E4E4),
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
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back,
            color: greenColor2,
            size: 30,
          ),
        ),

        ///
      ),
      key: _drawerscaffoldkey, //set gobal key defined above
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
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
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: TextField(
                        controller: searchController,
                        onChanged: (value) {
                          filterData(value);
                        },
                        textInputAction: TextInputAction.search,
                        onSubmitted: (value) {
                          filterData(value);
                        },
                        decoration: InputDecoration(
                          hintText: '    Search...',
                          border: InputBorder
                              .none, // Remove the line under the TextField
                        ),
                      ),
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
                      if (kDebugMode) {
                        print("Selected: $choice");
                      }
                    },
                    itemBuilder: (BuildContext context) {
                      return <PopupMenuEntry<String>>[
                        PopupMenuItem<String>(
                          value: '1',
                          child: CustomText(
                            title: 'Search by popularity',
                            color: grayColor,
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: '2',
                          child: CustomText(
                            title: 'Show Open Shops',
                            color: grayColor,
                          ),
                        ),
                        PopupMenuItem<String>(
                          value: '3',
                          child: CustomText(
                            title: 'Show Close Shops',
                            color: grayColor,
                          ),
                        ),
                      ];
                    },
                    child: Icon(
                      Icons.filter_list,
                      color: tealColor,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),

            /// This Is Very Important Code Not Remove
            // Expanded(
            //   child: RefreshIndicator(
            //     onRefresh: _refreshData,
            //     child:    AlignedGridView.count(
            //       itemCount:  dataList.length + 1, // Use the length of snapshot.data.data
            //       crossAxisCount: 2,
            //       mainAxisSpacing: 2,
            //       crossAxisSpacing: 2,
            //       itemBuilder: (context, index) {
            //         if (index < dataList.length) {
            //           final item = dataList[index];
            //           // if (item.title!.toLowerCase().contains(searchController.text.toLowerCase())) {
            //             // If the item matches the search query, build the UI
            //             String specialties = item.speciality ?? "";
            //             List<String> specialtyList = specialties.split(',');
            //             List<String> displaySpecialties = specialtyList.length > 3
            //                 ? specialtyList.sublist(0, 3)
            //                 : specialtyList;
            //             List<Widget> specialtyButtons = [];
            //           for (String specialty in displaySpecialties) {
            //             if (specialty.trim().isNotEmpty) {
            //               specialtyButtons.add(
            //                 Container(
            //                   height: 25,
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.circular(10),
            //                     boxShadow: [
            //                       BoxShadow(
            //                         color: Color(0xffD9CDE7).withOpacity(0.3),
            //                         blurRadius: 2,
            //                         spreadRadius: 2,
            //                         offset: Offset(0, 0),
            //                       ),
            //                     ],
            //                   ),
            //                   child: TextButton(
            //                     onPressed: () {
            //                       // Handle button press
            //                     },
            //                     child: Text(
            //                       specialty.trim(),
            //                       style: TextStyle(fontSize: 08, color: Colors.grey),
            //                     ),
            //                   ),
            //                 ),
            //               );
            //               specialtyButtons.add(SizedBox(width: 8)); // Add some spacing between buttons
            //             }
            //           }
            //           // Build your list items here
            //           return InkWell(
            //             onTap: () {
            //               Navigator.push(
            //                 context,
            //                 MaterialPageRoute(
            //                   builder: (context) => StaticBusinessDetailsPage(item.karobarId, item.title),
            //                 ),
            //               );
            //             },
            //             child: Card(
            //               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
            //               elevation: 5,
            //               child: Column(
            //                 // mainAxisAlignment: MainAxisAlignment.start,
            //                 // crossAxisAlignment: CrossAxisAlignment.start,
            //                 children: [
            //                   ClipRRect(
            //                     borderRadius: BorderRadius.only(
            //                       topRight: Radius.circular(12),
            //                       topLeft: Radius.circular(12.r),
            //                       // bottomRight: Radius.circular(25.r),
            //                       // bottomLeft: Radius.circular(25.r),
            //                     ),
            //                     child: Container(
            //                       child: item.images != null &&
            //                           item.images!.isNotEmpty
            //                           ? Image.network(
            //                         // Accessing the first image if available
            //                         item.images![0].imageName != null
            //                             ? "https://businessonline.pk/Images/Gallery/${item.karobarId}/${item.images![0].imageName}"
            //                             : 'assets/newbopkpic/b2.png',
            //                         width: MediaQuery.of(context).size.width,
            //                         height: MediaQuery.of(context).size.height / 5.9,
            //                         fit: BoxFit.fill,
            //                       )
            //                           : Image.asset(
            //                         'assets/newbopkpic/b2.png',
            //                         width: MediaQuery.of(context).size.width,
            //                         height: MediaQuery.of(context).size.height / 5.9,
            //                         fit: BoxFit.fill,
            //                       ),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: EdgeInsets.symmetric(horizontal: 08,vertical: 05),
            //                     child: Column(
            //                       mainAxisAlignment: MainAxisAlignment.start,
            //                       crossAxisAlignment: CrossAxisAlignment.start,
            //                       children: [
            //                         Container(
            //                           constraints: BoxConstraints(
            //                             maxWidth: MediaQuery.of(context).size.width/2, // Adjust this as needed
            //                           ),
            //                           child: CustomText(
            //                             title: item.title,
            //                             color: greenColor2,
            //                             googleFont: "Inter",
            //                             fontWeight: FontWeight.bold,
            //                             fontSize: 10.sp,
            //                             // minFontSize: 5,
            //                             maxLine: 4,
            //                             textOverflow:
            //                             TextOverflow.ellipsis,
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(right: 10),
            //                     child: Row(
            //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                       // crossAxisAlignment: CrossAxisAlignment.end,
            //                       children: [
            //                         Column(
            //                           children: [
            //                             Row(
            //                               children: [
            //                                 SizedBox(width: ScreenUtil().screenWidth /40),
            //                                 Icon(
            //                                   Icons.location_on,
            //                                   color: greenColor2,
            //                                   size: 14,
            //                                 ),
            //                                 CustomText(
            //                                   title:
            //                                   "0.01 KM away",
            //                                   googleFont: "Jost",
            //                                   fontWeight:
            //                                   FontWeight.bold,
            //                                   fontSize: 08.sp,
            //                                   // minFontSize: 5.sp,
            //                                   color: grayColor,
            //                                 ),
            //                               ],
            //                             ),
            //                             Row(
            //                               children: [
            //                                 Icon(Icons.access_time_rounded,
            //                                   color: greenColor2,
            //                                   size: 14,
            //                                 ),
            //                                 CustomText(
            //                                   title: "Open Now",
            //                                   googleFont: "Jost",
            //                                   fontWeight:
            //                                   FontWeight.bold,
            //                                   fontSize: 08.sp,
            //                                   // minFontSize: 5.sp,
            //                                   color: grayColor,
            //                                 ),
            //                               ],
            //                             ),
            //                           ],
            //                         ),
            //                         SizedBox(width: ScreenUtil().setWidth(30.w)),
            //                         item.isVerified == true
            //                             ? Image.asset(
            //                           "assets/images/verified.png",
            //                           scale: 2,
            //                           width: 30,
            //                           height: 30,
            //                           // fit: BoxFit.cover,
            //                         )
            //                             : SizedBox.shrink(),
            //                       ],
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.only(left: 08,right: 08),
            //                     child: SingleChildScrollView(
            //                       scrollDirection: Axis.horizontal,
            //                       child: Row(
            //                         children: [
            //                           ///navigation Picture comment for play store
            //                           CustomContainer(
            //                             height: 30,
            //                             width: 30,
            //                             ontap: () {},
            //                             color: whiteColor,
            //                             rd: 100,
            //                             boxShadow: true,
            //                             child: Image.asset(
            //                               'assets/images/navigation.png',
            //                             ),
            //                           ),
            //                           SizedBox(width: 10.w),
            //                           /// Phone Image Comment felhal comment for play store
            //                           item.contactPhone == null
            //                               ? CustomContainer(
            //                               height: 30,
            //                               width: 30,
            //                               ontap: () {
            //                                 print(item.contactPhone);
            //                                 if (item.contactPhone !=
            //                                     null) {
            //                                   String phoneUrl =
            //                                       'tel:${item.contactPhone?.replaceAll(',', '')}';
            //                                   launchUrl(
            //                                       Uri.parse(
            //                                           phoneUrl));
            //                                 }
            //                               },
            //                               rd: 100,
            //                               color: whiteColor,
            //                               boxShadow: true,
            //                               child: Image.asset(
            //                                   'assets/images/call1.png'))
            //                               : CustomContainer(
            //                               height: 30,
            //                               width: 30,
            //                               ontap: () {
            //                                 print(item.contactPhone);
            //                                 if (item.contactPhone != null) {String phoneUrl =
            //                                     'tel:${item.contactPhone?.replaceAll(',', '')}';
            //                                 launchUrl(Uri.parse(phoneUrl));
            //                                 }
            //                               },
            //                               rd: 100,
            //                               color: whiteColor,
            //                               boxShadow: true,
            //                               child: Image.asset(
            //                                   'assets/images/call.png')),
            //
            //                           SizedBox(width: 10.w),
            //                           /// below WhatsApp Image Comment  comment for play store
            //                           CustomContainer(
            //                             height: 30,
            //                             width: 30,
            //                             ontap: () {
            //                               if (item.contactPhone !=
            //                                   null) {
            //                                 print(
            //                                     "Contact Phone: ${item.contactPhone}");
            //                                 String whatsappUrl =
            //                                     'https://wa.me/+92${item.contactPhone}';
            //                                 launchUrl(Uri.parse(
            //                                     whatsappUrl))
            //                                     .then((value) {
            //                                   print(
            //                                       "WhatsApp URL launched successfully");
            //                                   print(
            //                                       "Contact Phone: ${item.contactPhone}");
            //                                 }).catchError((error) {
            //                                   print(
            //                                       "Error launching WhatsApp URL: $error");
            //                                   // Handle error (e.g., display a message to the user)
            //                                 });
            //                               } else {
            //                                 print(
            //                                     "Contact Phone is null");
            //                                 // Handle case where contact phone is null
            //                               }
            //                             },
            //                             rd: 100,
            //                             color: whiteColor,
            //                             boxShadow: true,
            //                             child: Image.asset(
            //                               item.contactPhone == null
            //                                   ? 'assets/images/whtsapp.png'
            //                                   : 'assets/images/whtsapp.png',
            //                             ),
            //                           ),
            //                           SizedBox(width: 10.w),
            //
            //                           /// comment for play store
            //                           CustomContainer(
            //                               height: 30,
            //                               width: 30,
            //                               ontap: () {},
            //                               rd: 100,
            //                               color: whiteColor,
            //                               boxShadow: true,
            //                               child: Image.asset(
            //                                   'assets/images/sms.png')),
            //                           SizedBox(width: 10.w),
            //
            //                           ///  comment for play store
            //                           CustomContainer(
            //                             height: 30,
            //                             width: 30,
            //                             ontap: () {},
            //                             rd: 100,
            //                             color: whiteColor,
            //                             boxShadow: true,
            //                             child: Image.asset(
            //                                 'assets/images/share.png'),
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ),
            //                   Padding(
            //                     padding: const EdgeInsets.all(8.0),
            //                     child: SingleChildScrollView(
            //                       scrollDirection: Axis.horizontal,
            //                       child: Row(
            //                         children: specialtyButtons,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //           );
            //         } else {
            //           // This is the "View More" button
            //           if (_loading) {
            //             // If loading, show a loading indicator
            //             return Center(child: CircularProgressIndicator());
            //           } else if (!_hasMoreData) {
            //             // If no more data available, show a message
            //             return Center(child: Text("No more data available"));
            //           } else {
            //             // If more data available, show the "View More" button
            //             return Center(
            //               child: TextButton(
            //                 onPressed:(){
            //                   _loadMoreData("no");
            //                 },
            //                 child: Text("View More"),
            //               ),
            //             );
            //           }
            //         }
            //       },
            //     ),
            //   ),
            // ),
            SizedBox(
              height: 8.0,
            ),
            Expanded(
              child: Stack(
                children: [
                  if (dataList.isEmpty && !_loading) // Display message when dataList is empty and not loading
                    Center(
                      child: Text('No businesses available'),
                    )else AlignedGridView.count(
                    itemCount: dataList.length + 1,
                    crossAxisCount: 2,
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                    itemBuilder: (context, index) {
                      if (index < dataList.length) {
                        final item = dataList[index];
                        // Your existing item builder logic here...
                        // (Your existing item builder code)
                        String specialties = item.speciality ?? "";
                        List<String> specialtyList = specialties.split(',');
                        List<String> displaySpecialties =
                            specialtyList.length > 3
                                ? specialtyList.sublist(0, 3)
                                : specialtyList;
                        List<Widget> specialtyButtons = [];
                        for (String specialty in displaySpecialties) {
                          if (specialty.trim().isNotEmpty) {
                            specialtyButtons.add(
                              Container(
                                height: 25,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xffD9CDE7).withOpacity(0.3),
                                      blurRadius: 2,
                                      spreadRadius: 2,
                                      offset: Offset(0, 0),
                                    ),
                                  ],
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    // Handle button press
                                  },
                                  child: Text(
                                    specialty.trim(),
                                    style: TextStyle(
                                        fontSize: 08, color: Colors.grey),
                                  ),
                                ),
                              ),
                            );
                            specialtyButtons.add(SizedBox(
                                width: 8)); // Add some spacing between buttons
                          }
                        }
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => StaticBusinessDetailsPage(
                                    item.karobarId, item.title),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            elevation: 0,
                            child: Stack(
                              alignment: Alignment.topRight,
                              children: [
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(12),
                                        topLeft: Radius.circular(12),
                                      ),
                                      child: Container(
                                        child: item.images != null &&
                                                item.images!.isNotEmpty
                                            ? Image.network(
                                                // Accessing the first image if available
                                                item.images![0].imageName !=
                                                        null
                                                    ? "https://businessonline.pk/Image/Business/Gallery/${item.karobarId}/${item.images![0].imageName}"
                                                    : 'assets/newbopkpic/b2.png',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    8,
                                                // Maintain 2:1 aspect ratio
                                                fit: BoxFit.cover,
                                              )
                                            : Image.asset(
                                                'assets/newbopkpic/b2.png',
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    8,
                                                // Maintain 2:1 aspect ratio
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 5),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: CustomText(
                                                  title: "${ item.title}",
                                                  color: greenColor2,
                                                  googleFont: "Inter",
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10.sp,
                                                  maxLine: 1,
                                                  textOverflow:
                                                  TextOverflow.clip,
                                                ),
                                              ),
                                              // SizedBox(height: 5),
                                              // Row(
                                              //   // Change to Row to display icons inline
                                              //   children: [
                                              //     Icon(
                                              //       Icons.location_on,
                                              //       color: greenColor2,
                                              //       size: 18,
                                              //     ),
                                              //     // Add clock icon
                                              //     SizedBox(width: 5),
                                              //     // Add spacing between icon and text
                                              //     CustomText(
                                              //       title: "${item.distance} KM away",
                                              //       googleFont: "Jost",
                                              //       fontWeight: FontWeight.bold,
                                              //       fontSize: 08.sp,
                                              //       color: grayColor,
                                              //     ),
                                              //
                                              //   ],
                                              // ),
                                              SizedBox(height: 5),
                                              Row(
                                                // Change to Row to display icons inline
                                                children: [
                                                  Icon(
                                                    Icons.access_time_rounded,
                                                    color: greenColor2,
                                                    size: 18,
                                                  ),
                                                  // Add direction icon
                                                  SizedBox(width: 5),
                                                  // Add spacing between icon and text
                                                  CustomText(
                                                    title: "Open Now",
                                                    googleFont: "Jost",
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 08.sp,
                                                    color: grayColor,
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 8, right: 8, top: 12),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: [
                                            /// Navigation Picture comment for play store
                                            CustomContainer(
                                              height: 30,
                                              width: 30,
                                              ontap: () {
                                                // _launchGoogleMaps(item.location!.locLat, item.location!.locLng);
                                                launchNavigation(
                                                    latitude:
                                                        item.lat!.toDouble(),
                                                    longitude:
                                                        item.lng!.toDouble());
                                              },
                                              rd: 100,
                                              color: item.contactPhone == null
                                                  ? Colors.grey
                                                  : Colors.green,
                                              boxShadow: true,
                                              child: Image.asset(
                                                  'assets/images/navigation.png'),
                                            ),

// Function to launch Google Maps

                                            SizedBox(width: 10),

                                            /// Phone Image Comment felhal comment for play store
                                            CustomContainer(
                                              height: 30,
                                              width: 30,
                                              ontap: () {
                                                print(item.contactPhone);
                                                if (item.contactPhone != null) {
                                                  String phoneUrl =
                                                      'tel:${item.contactPhone?.replaceAll(',', '')}';
                                                  launchUrl(
                                                      Uri.parse(phoneUrl));
                                                }
                                              },
                                              rd: 100,
                                              color: item.contactPhone == null
                                                  ? Colors.grey
                                                  : Colors.green,
                                              boxShadow: true,
                                              child: Image.asset(
                                                  'assets/images/${item.contactPhone == null ? "call1" : "call"}.png'),
                                            ),

                                            SizedBox(width: 10),

                                            /// Below WhatsApp Image Comment comment for play store
                                            CustomContainer(
                                              height: 30,
                                              width: 30,
                                              ontap: () {
                                                if (item.contactPhone != null &&
                                                    item.contactPhone!
                                                        .isNotEmpty) {
                                                  String whatsappUrl =
                                                      'https://wa.me/+92${item.contactPhone}';
                                                  launchUrl(Uri.parse(
                                                          whatsappUrl))
                                                      .then((value) {
                                                    if (kDebugMode) {
                                                      print(
                                                        "WhatsApp URL launched successfully");
                                                    }
                                                    if (kDebugMode) {
                                                      print(
                                                        "Contact Phone: ${item.contactPhone}");
                                                    }
                                                  }).catchError((error) {
                                                    if (kDebugMode) {
                                                      print(
                                                        "Error launching WhatsApp URL: $error");
                                                    }
                                                    // Handle error (e.g., display a message to the user)
                                                  });
                                                } else {
                                                  // Handle case where contact phone is null or empty
                                                }
                                              },
                                              rd: 100,
                                              color: item.contactPhone ==
                                                          null ||
                                                      item.contactPhone!.isEmpty
                                                  ? Colors.grey
                                                  : Colors.green,
                                              boxShadow: true,
                                              child: Image.asset(
                                                item.contactPhone == null ||
                                                        item.contactPhone!
                                                            .isEmpty
                                                    ? 'assets/images/whtsapp1.png'
                                                    : 'assets/images/whtsapp.png',
                                              ),
                                            ),

                                            SizedBox(width: 10),

                                            // /// Email Icon Comment for play store
                                            // CustomContainer(
                                            //   height: 30,
                                            //   width: 30,
                                            //   ontap: () {
                                            //     if (item.email != null && item.email!.isNotEmpty) {
                                            //       launchUrl(Uri.parse('mailto:${item.email}'));
                                            //     }
                                            //   },
                                            //   rd: 100,
                                            //   color: item.email != null && item.email!.isEmpty ? Colors.grey : Colors.green,
                                            //   boxShadow: true,
                                            //   child: Image.asset(
                                            //     item.email != null && item.email!.isEmpty
                                            //         ? 'assets/images/sms1.png'
                                            //         : 'assets/images/sms.png',
                                            //   ),
                                            // ),
                                            //
                                            //
                                            // SizedBox(width: 10),

                                            CustomContainer(
                                              height: 30,
                                              width: 30,
                                              ontap: () {
                                                if (item.whatsAppNumber != null && item.whatsAppNumber!.isNotEmpty) {
                                                  // Action to perform when not empty
                                                  _launchWhatsApp("Hi, how can I help you?");
                                                } else {
                                                  // Action when empty
                                                }
                                              },
                                              rd: 100,
                                              color: item.whatsAppNumber != null && item.whatsAppNumber!.isNotEmpty
                                                  ? Colors.green
                                                  : Colors.grey,
                                              boxShadow: true,
                                              child: Image.asset(
                                                item.whatsAppNumber != null && item.whatsAppNumber!.isNotEmpty
                                                    ? 'assets/images/share.png'
                                                    : 'assets/images/share2.png',
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Row(
                                          children: specialtyButtons,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                // Verified icon
                                item.isVerified == true
                                    ? Positioned(
                                        top: 8,
                                        right: 8,
                                        child: Image.asset(
                                          "assets/images/verified.png",
                                          scale: 2,
                                          width: 60,
                                          height: 60,
                                        ),
                                      )
                                    : Positioned(
                                        top: 8,
                                        right: 8,
                                        child: SizedBox(
                                          width: 60,
                                          height: 60,
                                          child: Image.asset(
                                            "assets/images/notverfiedicon.png",
                                            scale: 2,
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        );
                      } else {
                        return SizedBox(); // Return an empty SizedBox to reserve space for the "View More" button
                      }
                    },
                  ),
                  if (_loading) // Display CircularProgressIndicator if loading
                    Center(child: CircularProgressIndicator()),
                ],
              ),
            ),


            if (_hasMoreData) // Display the "View More" button at the bottom
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                    onPressed: () {
                      _loadMoreData("no");
                    },
                    child: Text("View More"),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      // When reaching the end of the list, load more data
      page++;

      searchBusinessModel.categoryId=widget.categoryId!.toInt();
      searchBusinessModel.page=page;
      searchBusinessModel.page=page;
      searchBusinessModel.searchTerm="no";
      searchBusinessModel.lat=widget.lat;
      searchBusinessModel.lng=widget.long;
      searchBusinessModel.miles=20;
      apiController.searchBusiness(searchBusinessModel).then((value) {
        setState(() {
          if (value.statusCode == 200) {
            // Successful API call
            final staticListModel = StaticListModel.fromJson(jsonDecode(value.body));
            if (staticListModel.data.isEmpty) {
              _hasMoreData = false; // No more data available
            } else {
              dataList.addAll(staticListModel.data);
              page++; // Increment page number
            }
          } else if (value.statusCode == 400) {
            // Handle specific error case where page number is invalid
            print("Error 400: ${value.body}");
            // String errorMessage = _extractErrorMessage(value.body);
          } else {
            print('Failed to load data: ${value.statusCode}');
          }
          _loading = false;
        });
      }).catchError((error) {
        print('Error in API call: $error');
        // Handle other errors if needed
        setState(() {
          _loading = false;
        });
      });
    }
  }
  _loadMoreData(String search) {
    if (!_loading && _hasMoreData) {
      setState(() {
        _loading = true;
      });

      searchBusinessModel.categoryId=widget.categoryId!.toInt();
      searchBusinessModel.page=page;
      searchBusinessModel.page=page;
      searchBusinessModel.searchTerm=search;
      searchBusinessModel.lat=widget.lat;
      searchBusinessModel.lng=widget.long;
      searchBusinessModel.miles=20;
      apiController.searchBusiness(searchBusinessModel).then((value) {
        setState(() {
          if (value.statusCode == 200) {
            // Successful API call
            final staticListModel = StaticListModel.fromJson(jsonDecode(value.body));
            if (staticListModel.data.isEmpty) {
              _hasMoreData = false; // No more data available
            } else {
              dataList.addAll(staticListModel.data);
              page++; // Increment page number
            }
          } else if (value.statusCode == 400) {
            // Handle specific error case where page number is invalid
            print("Error 400: ${value.body}");
            // String errorMessage = _extractErrorMessage(value.body);
          } else {
            print('Failed to load data: ${value.statusCode}');
          }
          _loading = false;
        });
      }).catchError((error) {
        print('Error in API call: $error');
        // Handle other errors if needed
        setState(() {
          _loading = false;
        });
      });

      // apiController.searchBusiness(searchBusinessModel).then((value) {
      //   setState(() {
      //     if (value.data!.isEmpty) {
      //       _hasMoreData = false; // No more data available
      //     } else {
      //       dataList.addAll(value.data!);
      //       page++; // Increment page number
      //     }
      //     _loading = false;
      //   });
      // });
    }
  }
  void launchNavigation(
      {required double latitude, required double longitude}) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps navigation';
    }
  }


  void filterData(String query) {
    // Create a new list to hold the filtered items
    List<Datum> filteredList = [];

    // Filter the dataList based on the query
    filteredList.addAll(dataList.where((item) {
      // Modify the condition according to your filtering logic
      return item.title!.toLowerCase().contains(query.toLowerCase());
    }).toList());

    setState(() {
      // Update the UI with the filtered list
      dataList.clear(); // Clear the original dataList
      dataList.addAll(filteredList); // Add the filtered items to dataList
    });
  }


  void sendMessage(String data) {
    final message = 'Your data: $data';

    Share.share(message);
  }
  void _launchWhatsApp(String message) async {
    var whatsappUrl = "whatsapp://send?text=${Uri.encodeComponent(message)}";
    await launch(whatsappUrl).catchError((e) {
      print("Error launching WhatsApp: $e");
    });
  }
}
