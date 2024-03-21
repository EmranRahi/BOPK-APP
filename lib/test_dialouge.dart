// import 'package:flutter/material.dart';
//
// class MyHomePage extends StatefulWidget {
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   void _showAlertDialog(BuildContext context) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: Text("Alert Dialog"),
//           content: Text("This is a simple alert dialog."),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close the dialog
//               },
//               child: Text("OK"),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Alert Dialog Example"),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             _showAlertDialog(context); // Call the function to show the alert dialog
//           },
//           child: Text("Show Alert Dialog"),
//         ),
//       ),
//     );
//   }
// }


import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'model/DetailsPageProductModel.dart';
import 'package:http/http.dart' as http;

/// Tab Bar View
// import 'package:flutter/material.dart';
//
// class TabViewAdd extends StatefulWidget {
//   const TabViewAdd({Key? key}) : super(key: key);
//
//   @override
//   State<TabViewAdd> createState() => _TabViewAddState();
// }
//
// class _TabViewAddState extends State<TabViewAdd> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 4, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Tab bar',
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Column(
//           children: [
//             TabBar(
//               controller: _tabController,
//               indicator: BoxDecoration(
//                 borderRadius: BorderRadius.circular(
//                   25.0,
//                 ),
//                 color: Colors.green,
//               ),
//               labelColor: Colors.white,
//               unselectedLabelColor: Colors.black,
//               tabs: [
//                 Tab(
//                   text: 'Place Bid',
//                 ),
//                 Tab(
//                   text: 'Buy Now',
//                 ),
//                 Tab(
//                   text: 'Place Bid',
//                 ),
//                 Tab(
//                   text: 'Buy Now',
//                 ),
//               ],
//             ),
//             // Expanded(
//             //   child: TabBarView(
//             //     controller: _tabController,
//             //     children: [
//             //       Center(
//             //         child: Text(
//             //           'Place Bid',
//             //           style: TextStyle(
//             //             fontSize: 25,
//             //             fontWeight: FontWeight.w600,
//             //           ),
//             //         ),
//             //       ),
//             //       Center(
//             //         child: Text(
//             //           'Buy Now',
//             //           style: TextStyle(
//             //             fontSize: 25,
//             //             fontWeight: FontWeight.w600,
//             //           ),
//             //         ),
//             //       ),
//             //     ],
//             //   ),
//             // ),
//           ],
//         ),
//       ),
//     );
//   }
// }

/// Tab Bar View  Code

// import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
// import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
// import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class TabViewAdd extends StatefulWidget {
//   const TabViewAdd({Key? key}) : super(key: key);
//
//   @override
//   State<TabViewAdd> createState() => _TabViewAddState();
// }
//
// class _TabViewAddState extends State<TabViewAdd>
//     with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 7, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     super.dispose();
//   }
//
//   void _handleTabTap(int index) {
//     _tabController.animateTo(index);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text(
//             'Tab bar',
//           ),
//         ),
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//
//               Container(
//                 height: 30, // Adjust the height of the tab container
//                 decoration: BoxDecoration(
//                   // color: Colors.grey[300],
//                   borderRadius: BorderRadius.circular(
//                     25.0,
//                   ),
//                 ),
//                 child: TabBar(
//                   controller: _tabController,
//                   isScrollable: true,
//                   indicator: BoxDecoration(
//                     borderRadius: BorderRadius.circular(
//                       25.0,
//                     ),
//                     color: greenColor2,
//                   ),
//                   labelColor: Colors.white,
//                   unselectedLabelColor: greenColor2,
//                   tabs: [
//                     Tab(
//                       child: CustomText(title:
//                       'Overview',
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         // color: greenColor2,
//                       ),
//                     ),
//                     // Tab(
//                     //   child: CustomText(
//                     //     title: "SPECIALITIES",
//                     //     fontWeight: FontWeight.bold,
//                     //     fontSize: 14,
//                     //     // color: greenColor2,
//                     //   ),
//                     Tab(
//                       child: CustomText(
//                         title: "Products",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         // color: greenColor2,
//                       ),
//                     ),
//                     Tab(
//                       child: CustomText(
//                         title: "Gallery",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         // color: greenColor2,
//                       ),
//                     ),
//                     Tab(
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.access_time_rounded,
//                             // color: greenColor2,
//                             size: 20,
//                           ),
//                           SizedBox(width: 10,),
//                           CustomText(
//                             title: "Opening Hours",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14.sp,
//                             // color: greenColor2,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Tab(
//                       child: CustomText(
//                         title: "Uer Reviews",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14.sp,
//                         // color: greenColor2,
//                       ),
//                     ),
//                     Tab(
//                       child: CustomText(
//                         title: "Contact us",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14.sp,
//                         // color: greenColor2,
//                       ),
//                     ),
//                     Tab(
//                       child: CustomText(
//                         title: "About",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 14,
//                         // color: greenColor2,
//                       ),
//                     ),
//                   ],
//                   onTap: _handleTabTap,
//                 ),
//               ),
//
//               Container(
//                 height: MediaQuery.of(context).size.height/1.7,
//               child: TabBarView(
//                 controller: _tabController,
//                 children:  [
//                   Container(
//                     alignment: Alignment.center,
//                     height: 250.h,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     decoration: BoxDecoration(
//                       // color: Colors.blue,
//                         border: Border.all(color: grayColor2),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomText(
//                             title:
//                             // title: businessModel?.description ??
//                                 'we deal in Samsung and Iphone Only',
//                             fontSize: 14,
//                             googleFont: "Jost",
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           CustomText(
//                             title: "SPECIALITIES",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                             color: greenColor2,
//                           ),
//                           Divider(
//                             color: greenColor2,
//                             thickness: 2,
//                             indent: 1,
//                             endIndent: 250,
//                           ),
//                           // Expanded(
//                           //   child: ListView.builder(
//                           //     physics: AlwaysScrollableScrollPhysics(),
//                           //     itemCount: 10,
//                           //
//                           //     itemBuilder: (context, index) {
//                           //       return Padding(
//                           //         padding: const EdgeInsets.symmetric(vertical: 7),
//                           //         child: Row(
//                           //           children: [
//                           //             Image.asset('assets/images/checkicon.png',scale: 30,),
//                           //             SizedBox(width: 10,),
//                           //             CustomText(
//                           //               title: "IPhone",
//                           //               color: grayColor,
//                           //             ),
//                           //           ],
//                           //         ),
//                           //       );
//                           //     },
//                           //   ),
//                           // ),
//                           Expanded(
//                             child: ListView.builder(
//                               physics: AlwaysScrollableScrollPhysics(),
//                               itemCount: 4,
//                               // businessModel?.speciality?.split(',').length ?? 0,
//                               itemBuilder: (context, index) {
//                                 // List<String>? specialties = businessModel?.speciality?.split(',');
//
//                                 return Padding(
//                                   padding: const EdgeInsets.symmetric(vertical: 7),
//                                   child: Row(
//                                     children: [
//                                       Image.asset('assets/images/checkicon.png', scale: 30,),
//                                       SizedBox(width: 10,),
//                                       CustomText(
//                                         title:
//
//                                         // specialties?[index].trim() ??
//                                             "ffsgfdgdfg",
//                                         color: grayColor,
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     height: 200.h,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     decoration: BoxDecoration(
//                       // color: Colors.blue,
//                         border: Border.all(color: grayColor2),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           top: 10.h, left: 10.w, bottom: 10, right: 10.w),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomText(
//                             title: "PRODUCT",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                             color: greenColor2,
//                           ),
//                           Divider(
//                             color: greenColor2,
//                             thickness: 2,
//                             indent: 1,
//                             endIndent: 250,
//                           ),
//                           Expanded(
//                             child: GridView.builder(
//                                 padding: EdgeInsets.zero,
//                                 gridDelegate:
//                                 SliverGridDelegateWithFixedCrossAxisCount(
//                                   crossAxisSpacing: 3,
//                                   mainAxisSpacing: 4,
//                                   crossAxisCount: 2, // Number of columns
//                                 ),
//                                 itemCount: 9, // Number of items in the grid
//                                 itemBuilder: (context, index) {
//                                   return InkWell(
//                                     onTap: () {
//                                       // Navigator.push(context, MaterialPageRoute(
//                                       //         builder: (context) =>
//                                       //             ProductScreen()));
//                                       // print('GridView');
//                                     },
//                                     child: Padding(
//                                       padding: const EdgeInsets.all(8.0),
//                                       child: Container(
//                                         decoration: BoxDecoration(
//                                             color: whiteColor,
//                                             borderRadius:
//                                             BorderRadius.circular(10.r),
//                                             boxShadow: [
//                                               BoxShadow(
//                                                 color: grayColor2,
//                                                 blurRadius: 1.r,
//                                                 spreadRadius: 1.r,
//                                                 offset: Offset(0, 0),
//                                               ),
//                                             ]),
//                                         child: Column(
//                                           mainAxisAlignment: MainAxisAlignment.start,
//                                           crossAxisAlignment: CrossAxisAlignment.start,
//                                           children: [
//                                             Center(
//                                               child: Image.asset(
//                                                 'assets/images/producimage1.png',
//                                                 scale: 7,
//                                               ),
//                                             ),
//                                             SizedBox(
//                                               height: 2,
//                                             ),
//                                             CustomText(
//                                               title: 'Iphone',
//                                               color: grayColor,
//                                             ),
//                                             SizedBox(
//                                               height: 2,
//                                             ),
//                                             CustomText(
//                                               title: 'Rs.80000',
//                                               color: tealColor1,
//                                               fontWeight: FontWeight.bold,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment
//                                                   .spaceAround,
//                                               children: [
//                                                 Custom_Button_Widget(
//                                                   ontap: () {
//                                                     print("Click whatsApp");
//                                                   },
//                                                   rd: 4.r,
//                                                   height: 20.h,
//                                                   width: 50.h,
//                                                   color: greenColor,
//                                                   child: CustomText(
//                                                     title: "whatsApp",
//                                                     color: whiteColor,
//                                                     fontWeight:
//                                                     FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                                 // SizedBox(
//                                                 //   width: 30.w,
//                                                 // ),
//                                                 Custom_Button_Widget(
//                                                   ontap: () {
//                                                     print("Click Call");
//                                                   },
//                                                   rd: 4.r,
//                                                   height: 20.h,
//                                                   width: 50.h,
//                                                   color: greenColor,
//                                                   child: CustomText(
//                                                     title: "Call",
//                                                     color: whiteColor,
//                                                     fontWeight:
//                                                     FontWeight.bold,
//                                                     fontSize: 10,
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                 }),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: grayColor2),
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Padding(
//                       padding: EdgeInsets.symmetric(horizontal: 10),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           CustomText(
//                             title: "GALLERY",
//                             fontWeight: FontWeight.bold,
//                             fontSize: 14,
//                             color: greenColor2,
//                           ),
//                           Divider(
//                             color: greenColor2,
//                             thickness: 2,
//                             indent: 1,
//                             endIndent: 250,
//                           ),
//                           CarouselSlider.builder(
//                             options: CarouselOptions(
//                               viewportFraction: 1.0,
//                               enlargeCenterPage: false,
//                               autoPlay: true,
//                             ),
//                             itemCount:05,
//                             // businessModel?.images?.length ?? 0,
//                             itemBuilder: (BuildContext context, int index, _) {
//                               return
//                               // if (businessModel?.images != null &&
//                               //     businessModel!.images!.isNotEmpty &&
//                               //     index < businessModel!.images!.length &&
//                               //     businessModel!.images![index].imageName != null &&
//                               //     businessModel!.images![index].imageName!.isNotEmpty) {
//                               //   return
//                               //   Container(
//                               //     width: MediaQuery.of(context).size.width,
//                               //     child: Image.network(
//                               //       "http://bopk.psea.pk/Images/Gallery/${businessModel!.karobarId}/${businessModel!.images![index].imageName}",
//                               //       fit: BoxFit.cover,
//                               //     ),
//                               //   );
//                               // } else {
//                               //   return
//                                 Image.asset(
//                                   'assets/images/gallery.jpg',
//                                   fit: BoxFit.cover,
//                                 );
//                               }
//
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     // height: ScreenUtil().screenHeight / 2.4,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     decoration: BoxDecoration(
//                       // color: Colors.blue,
//                         border: Border.all(color: grayColor2),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           top: 10.h,
//                           left: 10.w,
//                           bottom: 10,
//                           right: 10.w),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // Row(
//                           //   children: [
//                           //     Icon(
//                           //       Icons.access_time_rounded,
//                           //       color: greenColor2,
//                           //       size: 30,
//                           //     ),
//                           //     SizedBox(width: 20),
//                           //     CustomText(
//                           //       title: "OPENING HOURS",
//                           //       fontWeight: FontWeight.bold,
//                           //       fontSize: 20,
//                           //       color: tealColor1,
//                           //     ),
//                           //   ],
//                           // ),
//                           SingleChildScrollView(
//                             scrollDirection: Axis.vertical,
//                             child: DataTable(
//                               columnSpacing: 30,
//                               columns: const [
//                                 DataColumn(label: Text('Day')),
//                                 DataColumn(label: Text('12:00AM')),
//                                 DataColumn(label: Text('12:00PM')),
//                               ],
//                               rows: const [
//                                 DataRow(
//                                   selected: true,
//                                   cells: <DataCell>[
//                                     DataCell(Text('Monday')),
//                                     DataCell(Text('10:00AM')),
//                                     DataCell(Text('10:00PM')),
//                                   ],
//                                 ),
//                                 DataRow(
//                                   selected: true,
//                                   cells: <DataCell>[
//                                     DataCell(Text('Tuesday')),
//                                     DataCell(Text('10:00AM')),
//                                     DataCell(Text('10:00PM')),
//                                   ],
//                                 ),
//                                 DataRow(
//                                   selected: true,
//                                   cells: <DataCell>[
//                                     DataCell(
//                                       Text('Wednesday'),
//                                     ),
//                                     DataCell(
//                                       Text('10:00AM'),
//                                     ),
//                                     DataCell(
//                                       Text('10:00PM'),
//                                     ),
//                                   ],
//                                 ),
//                                 DataRow(
//                                   selected: true,
//                                   cells: <DataCell>[
//                                     DataCell(
//                                       Text('Thursday'),
//                                     ),
//                                     DataCell(
//                                       Text('10:00AM'),
//                                     ),
//                                     DataCell(
//                                       Text('10:00PM'),
//                                     ),
//                                   ],
//                                 ),
//                                 DataRow(
//                                   selected: true,
//                                   cells: <DataCell>[
//                                     DataCell(Text('Friday')),
//                                     DataCell(Text('10:00AM')),
//                                     DataCell(Text('10:00PM')),
//                                   ],
//                                 ),
//                                 DataRow(
//                                   selected: true,
//                                   cells: <DataCell>[
//                                     DataCell(Text('Saturday')),
//                                     DataCell(Text('10:00AM')),
//                                     DataCell(Text('10:00PM')),
//                                   ],
//                                 ),
//                                 DataRow(
//                                   selected: true,
//                                   cells: <DataCell>[
//                                     DataCell(Text('Sunday')),
//                                     DataCell(Text('10:00AM')),
//                                     DataCell(Text('10:00PM')),
//                                   ],
//                                 ),
//
//                                 // Add more rows as needed
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     alignment: Alignment.center,
//                     height: ScreenUtil().screenHeight / 2.4,
//                     margin: EdgeInsets.symmetric(vertical: 8),
//                     decoration: BoxDecoration(
//                       // color: Colors.blue,
//                         border: Border.all(color: grayColor2),
//                         borderRadius: BorderRadius.circular(12)),
//                     child: Padding(
//                       padding: EdgeInsets.only(
//                           top: 10.h, left: 10.w, bottom: 10, right: 10.w),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           // CustomText(
//                           //   title: "USER REVIEWS",
//                           //   fontWeight: FontWeight.bold,
//                           //   fontSize: 20,
//                           //   color: greenColor2,
//                           // ),
//                           Expanded(
//                             child: ListView.builder(
//                               itemCount: 10,
//                               itemBuilder: (context, index) {
//                                 return Column(
//                                   children: [
//                                     Container(
//                                       alignment: Alignment.center,
//                                       height:
//                                       ScreenUtil().screenHeight / 8.0,
//                                       margin:
//                                       EdgeInsets.symmetric(vertical: 8),
//                                       decoration: BoxDecoration(
//                                         // color: Colors.blue,
//                                         border:
//                                         Border.all(color: grayColor2),
//                                         // borderRadius: BorderRadius.circular(12)
//                                       ),
//                                       child: ListTile(
//                                         title: CustomText(title: "test"),
//                                         subtitle: CustomText(
//                                           title: "waw3wo3eo",
//                                         ),
//                                         trailing: CustomText(
//                                             title:
//                                             "2023-10-10T15:56:40:55"),
//                                       ),
//                                     )
//                                   ],
//                                 );
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 Center(
//                     child: Text(
//                       'Buy Now1',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 Center(
//                     child: Text(
//                       'Buy Now2',
//                       style: TextStyle(
//                         fontSize: 25,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             ],
//           ),
//         ));
//   }
// }



/// this Below Code  Opening and Closing hour with Of Api DropDown
//
// class MyDateAndTimeClass extends StatefulWidget {
//   const MyDateAndTimeClass({super.key});
//
//   @override
//   State<MyDateAndTimeClass> createState() => _MyDateAndTimeClassState();
// }
//
// class _MyDateAndTimeClassState extends State<MyDateAndTimeClass> {
//
//   // bool val = true; // Initial state of the checkbox
//   // bool val1 = false;
//   // bool val2 = false;
//   // bool val3 = false;
//   // bool val4 = false;
//   // bool val5 = false;
//   // bool val6 = false;
//
//
//   OpeningAndClosingTimeModel openingAndClosingTimeModel = OpeningAndClosingTimeModel();
//   final List<String> timeList = const [
//     '09:00AM',
//     '10:00AM',
//     '11:00AM',
//     '12:00PM',
//     '01:00PM',
//     '02:00PM',
//     '03:00PM',
//     '04:00PM',
//     '05:00PM',
//     '06:00PM',
//     '07:00PM',
//     '08:00PM',
//     '09:00PM',
//     '10:00PM',
//     '11:00PM',
//     '12:00PM',
//   ].toSet().toList(); // Remove duplicates and convert to a list
//
//
//   // void updateAllCheckboxes(bool value) {
//   //   setState(() {
//   //     val = value;
//   //     val1 = value;
//   //     val2 = value;
//   //     val3 = value;
//   //     val4 = value;
//   //     val5 = value;
//   //     val6 = value;
//   //   });
//   // }
//
//
// // Define variables to hold selected values
//   String? selectedOpeningTime;
//   String? selectedClosingTime;
//   Map<String, String?> selectedOpeningTimes = {}; // Map to store selected opening times for each day
//   Map<String, String?> selectedClosingTimes = {}; // Map to store selected closing times for each day
//   Map<String, bool> checkBoxValues = {}; // Map to store checkbox values for each day
//
// // Update onChanged callback for both DropdownButtons
//   onOpeningTimeChanged(String? value) {
//     setState(() {
//       selectedOpeningTime = value ?? "select";
//     });
//   }
//
//   onClosingTimeChanged(String? value) {
//     setState(() {
//       selectedClosingTime = value;
//     });
//   }
//
//   void sendDataToServer(List<OpeningAndClosingTimeModel> models) {
//     if (models.isNotEmpty) {
//       // Call the controller function to send data to the server
//       APIController.openingAndClosingPostData(models).then((response) {
//         // Handle the response from the server
//         // For example, show a success message or update UI accordingly
//       }).catchError((error) {
//         // Handle error
//         print('Error: $error');
//       });
//     } else {
//       // Handle case when the list is empty
//       print('No data to send.');
//     }
//   }
//
//   List<OpeningAndClosingTimeModel> modelsForAllDays = [];
//   DateFormat formatter = DateFormat('HH:mm'); // Format for hours and minutes
//
//
//   ///jhjhkjhkjhkjh
//   @override
//   Widget build(BuildContext context) {
//     // String defaultValue = '10:00AM';
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("AppBar "),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   CustomText(
//                       title: "Set to All",
//                       fontWeight: FontWeight.bold,
//                       fontSize: 20.sp,
//                       color: greenColor2
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
//                         // Iterate through each day and set its checkbox value to true
//                         for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday']) {
//                           checkBoxValues[day] = checkBoxValues[day] == null ? false : !checkBoxValues[day]!;
//                           // selectedOpeningTimes[day] = selectedOpeningTimes['Monday']; // Set opening time
//                           // selectedClosingTimes[day] = selectedClosingTimes['Monday']; // Set closing time
//
//                         }
//                       });
//                     },
//                     child: CustomText(
//                         title: "Set to All",
//                         fontWeight: FontWeight.bold,
//                         fontSize: 20.sp,
//                         color: greenColor2
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(
//                 height: ScreenUtil().setHeight(20.h),
//               ),
//               for (var day in ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'])
//                 Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
//                   child: Column(
//                     children: [
//                       OpenHoursContainer(
//                         isChecked: true,
//                         customCheckbox: Checkbox(
//                           onChanged: (value) {
//                             setState(() {
//                               checkBoxValues[day] = value!;
//                               print('Checkbox value changed: $value');
//                             });
//                           },
//                           value: checkBoxValues[day] ?? false,
//                           activeColor: greenColor2,
//                         ),
//                         child:  CustomText(title: day),
//                       ),
//                       // Text(day),
//                        SizedBox(height: 08,),
//                       Visibility(
//                         visible: checkBoxValues[day] ?? false,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceAround,
//                           children: [
//                             Container(
//                               width: MediaQuery.of(context).size.width/3.5,
//                               decoration: BoxDecoration(
//                                   color: whiteColor,
//                                   borderRadius: BorderRadius.circular(10),
//                                 boxShadow: const [
//                                   BoxShadow(
//                                     color: grayColor,
//                                     blurRadius: 7,
//                                     spreadRadius: 1,
//                                     offset: Offset(0,0),
//                                   )
//                                 ]
//                               ),
//                               child: Center(
//                                 child: DropdownButton<String>(
//                                   borderRadius: BorderRadius.circular(10),
//                                   underline: Text(""),
//                                   value: selectedOpeningTimes[day] ?? timeList.first,
//                                   items: timeList.map((String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                   onChanged: (String? value) {
//                                     setState(() {
//                                       selectedOpeningTimes[day] = value;
//                                     });
//                                   },
//                                 ),
//
//                               ),
//                             ),
//                             Container(
//                               width: MediaQuery.of(context).size.width/3.5,
//                               decoration: BoxDecoration(
//                                   color: whiteColor,
//                                   borderRadius: BorderRadius.circular(10),
//                                   boxShadow:const [
//                                     BoxShadow(
//                                       color: grayColor,
//                                       blurRadius: 7,
//                                       spreadRadius: 1,
//                                       offset: Offset(0,0),
//                                     )
//                                   ]
//                               ),
//                               child: Center(
//                                 child: DropdownButton<String>(
//                                   borderRadius: BorderRadius.circular(10),
//                                   underline: Text(""),
//                                   value: selectedClosingTimes[day] ?? timeList.first,
//                                   items: timeList.map((String value) {
//                                     return DropdownMenuItem<String>(
//                                       value: value,
//                                       child: Text(value),
//                                     );
//                                   }).toList(),
//                                   onChanged: (String? value) {
//                                     setState(() {
//                                       selectedClosingTimes[day] = value;
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ElevatedButton(
//                 onPressed: () {
//                   sendDataForAllDays();
//                 },
//                 child: Text('Send Data to server'),
//               ),
//             ],
//           ),
//          ),
//         ),
//       );
//     }
//
//   void sendDataForAllDays() {
//      List<String> daysOfWeek =
//      ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday", "Sunday",];
//     List<OpeningAndClosingTimeModel> modelsForAllDays = [];
//     for (String day in daysOfWeek) {
//       OpeningAndClosingTimeModel model = OpeningAndClosingTimeModel(
//         id: 0, // You may need to adjust this according to your model
//         dayOfWeek: day,
//         openingTime: selectedOpeningTimes[day] ?? "default open time", // Replace "" with default value if needed
//         closingTime: selectedClosingTimes[day] ?? "default close time", // Replace "" with default value if needed
//         isOpen:   false, // _getIsOpenForDay(day), // Checkbox value for each day
//         fkKarobarId: 0, // You may need to adjust this according to your model
//         is24Hour: false, // You may need to adjust this according to your model
//       );
//       modelsForAllDays.add(model);
//     }
//
//     // Send data to the server
//     sendDataToServer(modelsForAllDays);
//   }
//
//   // bool _getIsOpenForDay(String day) {
//   //   switch (day) {
//   //     case "Monday":
//   //       return val;
//   //     case "Tuesday":
//   //       return val1;
//   //     case "Wednesday":
//   //       return val2;
//   //     case "Thursday":
//   //       return val3;
//   //     case "Friday":
//   //       return val4;
//   //     case "Saturday":
//   //       return val5;
//   //     case "Sunday":
//   //       return val6;
//   //     default:
//   //       return false;
//   //   }
//   // }
// }
//


/// product ya Item API
class YourWidgetName extends StatefulWidget {
  @override
  _YourWidgetNameState createState() => _YourWidgetNameState();
}

class _YourWidgetNameState extends State<YourWidgetName> {
  late Future<List<DetailsPageProductModel>> _futureProducts;

  @override
  void initState() {
    super.initState();
    _futureProducts = fetchProducts();
  }

  Future<List<DetailsPageProductModel>> fetchProducts() async {
    final response =
    await http.get(Uri.parse("http://144.91.86.203/bopkapi/KarobarItems"));
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      List<DetailsPageProductModel> products =
      jsonList.map((json) => DetailsPageProductModel.fromJson(json)).toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.symmetric(vertical: 8),
        child: FutureBuilder<List<DetailsPageProductModel>>(
          future: _futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Show loading indicator while fetching data
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              List<DetailsPageProductModel> products = snapshot.data!;
              return Padding(
                padding: EdgeInsets.all(8.0),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    print(products.length);
                    final product = products[index];
                    return InkWell(
                      onTap: () {
                        // Handle onTap event
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Image.network(
                            //   product.images![0], // Assuming images are URLs
                            //   height: 100,
                            //   width: double.infinity,
                            //   fit: BoxFit.cover,
                            // ),
                            Image.asset(
                              product.images != null && product.images!.isNotEmpty ? product.images![0] : 'assets/images/producimage1.png',
                              scale: 7,
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.itemName!,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16.0,
                                    ),
                                  ),
                                  SizedBox(height: 4.0),
                                  Text(
                                    'Rs.${product.price}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              );
            }
          },
        ),
      ),
    );
  }
}