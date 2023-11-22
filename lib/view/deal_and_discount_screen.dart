import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'HomePage_ofBopk.dart';
import 'add_jobs.dart';
import 'business_for_sale.dart';
import 'customs_widgets/constant_color.dart';
import 'customs_widgets/custom_appbar.dart';
import 'customs_widgets/custom_text.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'menu_login.dart';
import 'mobile_shops.dart';

class DealAndDisCount extends StatefulWidget {
  const DealAndDisCount({super.key});

  @override
  State<DealAndDisCount> createState() => _DealAndDisCountState();
}

class _DealAndDisCountState extends State<DealAndDisCount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar1(
        centerTitle: false,
        title: CustomText(
          title: 'Mobile Shops',
          color: grayColor,
        ),
        leading: Icon(
          Icons.arrow_back,
          color: tealColor,
          size: 30,
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
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> MobileShops()));
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
        body: ListView.builder(
            itemCount: 10,
            padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
            itemBuilder: (context, index) {
              return Container(
                height: ScreenUtil().screenHeight / 2.2,
                child: Padding(
                  padding:  EdgeInsets.symmetric(vertical: 8.h),
                  child: Card(
                    elevation: 2,
                      shadowColor: Colors.grey,
                       color: Colors.green,
                       borderOnForeground: true,
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:   [
                      Container(
                        height: 50.h,
                        width: double.infinity,
                        color: Colors.greenAccent,
                        child: Column(children: [
                          SizedBox(height: 10.h),
                          CustomText(title: "Javid Stamp Chambers",fontSize: 14,fontWeight: FontWeight.bold,fontStyle: FontStyle.italic,),
                          SizedBox(height: 6.h,),
                          Align(
                            alignment: Alignment.topRight,
                              child: CustomText(title: "Contact Number: +923333889823", fontStyle: FontStyle.italic,)),
                        ],),
                      ),
                      Image.asset('assets/images/deal.jpg',scale: 4),
                      Align(
                        alignment: Alignment.topRight,
                        child: Container(
                     width: ScreenUtil().screenWidth/3.6,
                          height: 33.h,
                          color: Colors.greenAccent,
                            child: Align(
                              alignment: Alignment.center,
                                child: CustomText(title: "6.51KM AWAY",color: blackColor,fontSize: 14,fontWeight: FontWeight.bold,)),),
                      ),

                    ],
                  ),),
                ),
              );
            }),
    );
  }
}
