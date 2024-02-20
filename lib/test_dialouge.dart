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

import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TabViewAdd extends StatefulWidget {
  const TabViewAdd({Key? key}) : super(key: key);

  @override
  State<TabViewAdd> createState() => _TabViewAddState();
}

class _TabViewAddState extends State<TabViewAdd>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _handleTabTap(int index) {
    _tabController.animateTo(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Tab bar',
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [

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
                    // Tab(
                    //   child: CustomText(
                    //     title: "SPECIALITIES",
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 14,
                    //     // color: greenColor2,
                    //   ),
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
                        title: "Uer Reviews",
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
                height: MediaQuery.of(context).size.height/1.7,
              child: TabBarView(
                controller: _tabController,
                children:  [
                  Container(
                    alignment: Alignment.center,
                    height: 250.h,
                    margin: EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      // color: Colors.blue,
                        border: Border.all(color: grayColor2),
                        borderRadius: BorderRadius.circular(12)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title:
                            // title: businessModel?.description ??
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
                          // Expanded(
                          //   child: ListView.builder(
                          //     physics: AlwaysScrollableScrollPhysics(),
                          //     itemCount: 10,
                          //
                          //     itemBuilder: (context, index) {
                          //       return Padding(
                          //         padding: const EdgeInsets.symmetric(vertical: 7),
                          //         child: Row(
                          //           children: [
                          //             Image.asset('assets/images/checkicon.png',scale: 30,),
                          //             SizedBox(width: 10,),
                          //             CustomText(
                          //               title: "IPhone",
                          //               color: grayColor,
                          //             ),
                          //           ],
                          //         ),
                          //       );
                          //     },
                          //   ),
                          // ),
                          Expanded(
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              itemCount: 4,
                              // businessModel?.speciality?.split(',').length ?? 0,
                              itemBuilder: (context, index) {
                                // List<String>? specialties = businessModel?.speciality?.split(',');

                                return Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 7),
                                  child: Row(
                                    children: [
                                      Image.asset('assets/images/checkicon.png', scale: 30,),
                                      SizedBox(width: 10,),
                                      CustomText(
                                        title:

                                        // specialties?[index].trim() ??
                                            "ffsgfdgdfg",
                                        color: grayColor,
                                      ),
                                    ],
                                  ),
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
                          Expanded(
                            child: GridView.builder(
                                padding: EdgeInsets.zero,
                                gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 4,
                                  crossAxisCount: 2, // Number of columns
                                ),
                                itemCount: 9, // Number of items in the grid
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      // Navigator.push(context, MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             ProductScreen()));
                                      // print('GridView');
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
                                              child: Image.asset(
                                                'assets/images/producimage1.png',
                                                scale: 7,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            CustomText(
                                              title: 'Iphone',
                                              color: grayColor,
                                            ),
                                            SizedBox(
                                              height: 2,
                                            ),
                                            CustomText(
                                              title: 'Rs.80000',
                                              color: tealColor1,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceAround,
                                              children: [
                                                Custom_Button_Widget(
                                                  ontap: () {
                                                    print("Click whatsApp");
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
                                                    print("Click Call");
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
                                }),
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
                            itemCount:05,
                            // businessModel?.images?.length ?? 0,
                            itemBuilder: (BuildContext context, int index, _) {
                              return
                              // if (businessModel?.images != null &&
                              //     businessModel!.images!.isNotEmpty &&
                              //     index < businessModel!.images!.length &&
                              //     businessModel!.images![index].imageName != null &&
                              //     businessModel!.images![index].imageName!.isNotEmpty) {
                              //   return
                              //   Container(
                              //     width: MediaQuery.of(context).size.width,
                              //     child: Image.network(
                              //       "http://bopk.psea.pk/Images/Gallery/${businessModel!.karobarId}/${businessModel!.images![index].imageName}",
                              //       fit: BoxFit.cover,
                              //     ),
                              //   );
                              // } else {
                              //   return
                                Image.asset(
                                  'assets/images/gallery.jpg',
                                  fit: BoxFit.cover,
                                );
                              }

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
                          top: 10.h,
                          left: 10.w,
                          bottom: 10,
                          right: 10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Row(
                          //   children: [
                          //     Icon(
                          //       Icons.access_time_rounded,
                          //       color: greenColor2,
                          //       size: 30,
                          //     ),
                          //     SizedBox(width: 20),
                          //     CustomText(
                          //       title: "OPENING HOURS",
                          //       fontWeight: FontWeight.bold,
                          //       fontSize: 20,
                          //       color: tealColor1,
                          //     ),
                          //   ],
                          // ),
                          SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: DataTable(
                              columnSpacing: 30,
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
                          // CustomText(
                          //   title: "USER REVIEWS",
                          //   fontWeight: FontWeight.bold,
                          //   fontSize: 20,
                          //   color: greenColor2,
                          // ),
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
                                        title: CustomText(title: "test"),
                                        subtitle: CustomText(
                                          title: "waw3wo3eo",
                                        ),
                                        trailing: CustomText(
                                            title:
                                            "2023-10-10T15:56:40:55"),
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
                Center(
                    child: Text(
                      'Buy Now1',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                Center(
                    child: Text(
                      'Buy Now2',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ],
          ),
        ));
  }
}
