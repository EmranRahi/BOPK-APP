import 'package:businessonlinepk/view/customs_widgets/constant_color.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}
class _ProductScreenState extends State<ProductScreen> {
  List<String> customList = ['imran','imran','imran','imran','imran'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body:CustomScrollView(
      //   slivers: <Widget>[
      //     SliverAppBar(
      //       expandedHeight: 500, // Height when expanded
      //       floating: false, // Whether it should become a floating app bar when scrolled up
      //       pinned: true, // Whether it should be pinned at the top when scrolled up
      //       backgroundColor: Colors.black, // Set the background color here
      //       flexibleSpace: FlexibleSpaceBar(
      //         background: Image.asset('assets/images/iphone.jpg'),
      //       ),
      //     ),
      //     SliverToBoxAdapter(
      //       child: Container(
      //         height: MediaQuery.of(context).size.height/1.5,
      //         padding: EdgeInsets.symmetric(vertical: 20), // Add padding as needed
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Column(
      //             mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
      //             children: [
      //               CustomText(
      //                 title: 'Iphone',
      //                 color: grayColor,
      //               ),
      //               SizedBox(
      //                 height: 2,
      //               ),
      //               CustomText(
      //                 title: 'Rs.80000',
      //                 color: greenColor2,
      //                 fontWeight: FontWeight.bold,
      //               ),
      //               SizedBox(
      //                 height: 2,
      //               ),
      //               CustomText(
      //                 title: 'Iphone Test',
      //                 color: grayColor,
      //
      //               ),
      //               // Add any other widgets you want within this Container
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     Container(
      //     child: Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           crossAxisAlignment: CrossAxisAlignment.end,
      //           children: [
      //             Custom_Button_Widget(
      //               ontap: () {
      //                 print("Click whatsApp");
      //               },
      //               rd: 4.r,
      //              height: 30.h,
      //               color: greenColor2,
      //               child: CustomText(
      //                 title: "whatsApp",
      //                 color: whiteColor,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 16.sp,
      //               ),
      //             ),
      //             // SizedBox(
      //             //   width: 30.w,
      //             // ),
      //             Custom_Button_Widget(
      //               ontap: () {
      //                 print("Click Call");
      //               },
      //               rd: 4.r,
      //               height: 30.h,
      //
      //               color: greenColor2,
      //               child: CustomText(
      //                 title: "Call",
      //                 color: whiteColor,
      //                 fontWeight: FontWeight.bold,
      //                 fontSize: 16.sp,
      //               ),
      //             ),
      //
      //       ]),
      //     ),
      //     ),
      //   ],
      // ),
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: <Widget>[
                SliverAppBar(
                  expandedHeight: 500,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.black,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.asset('assets/images/iphone.jpg'),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: MediaQuery.of(context).size.height / 1.4,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            title: 'Iphone',
                            color: grayColor,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          CustomText(
                            title: 'Rs . 80000',
                            color: greenColor2,
                            fontWeight: FontWeight.bold,
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          CustomText(
                            title: 'Iphone Test',
                            color: grayColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(08),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Custom_Button_Widget(
                  ontap: () {
                    print("Click WhatsApp");
                  },
                  rd: 4.r,
                  height: 35.h,
                  color: greenColor2,
                  child: CustomText(
                    title: "WhatsApp",
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
                Custom_Button_Widget(
                  ontap: () {
                    print("Click Call");
                  },
                  rd: 4.r,
                  height:35.h,
                  color: greenColor2,
                  child: CustomText(
                    title: "Call",
                    color: whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}