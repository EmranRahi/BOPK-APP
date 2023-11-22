
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
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
import 'customs_widgets/custom_button.dart';
import 'customs_widgets/custom_containers_design.dart';
import 'customs_widgets/custom_text.dart';
import 'deal_and_discount_screen.dart';
import 'get_your_business_now.dart';
import 'menu_login.dart';
import 'mobile_shops.dart';
class GetDisCountCard extends StatefulWidget {
  const GetDisCountCard({super.key});

  @override
  State<GetDisCountCard> createState() => _GetDisCountCardState();
}

class _GetDisCountCardState extends State<GetDisCountCard> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Align(
              alignment: Alignment.center,
              child: CustomText(
                title: "Contact Business Online",
                color: greenColor2,
                fontWeight: FontWeight.bold,
                fontSize: 20.sp,
              ),
            ),
              SizedBox(height: ScreenUtil().setHeight(20.h),),
            Padding(
              padding:  EdgeInsets.only(left: 8.w),
              child: CustomText(
                title:
                "Please contact us for any sales or\ntechnical queries.",
                fontSize: 17,
              ),
            ),
         SizedBox(height: ScreenUtil().setHeight(20.h),),
            Padding(
              padding:  EdgeInsets.only(left: 8.w),
              child: CustomText(
                title:
                "Name",
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
              CustomTextFormFieldWidget(hint: "your Name Here",borderRadius: 8),
              Padding(
                padding:  EdgeInsets.only(left: 8.w),
                child: CustomText(
                  title:
                  "Phone Number",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextFormFieldWidget(hint: "your Name Here",borderRadius: 8),
              Padding(
                padding:  EdgeInsets.only(left: 8.w),
                child: CustomText(
                  title:
                  "Message",
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              CustomTextFormFieldWidget(hint: "your Name Here",maxLines: 4,borderRadius: 8.r),
              SizedBox(height: ScreenUtil().setHeight(20.h),),
              Custom_Button_Widget(
                  ontap: () {},
                  rd: 8,
                  color: greenColor2,
                  width: ScreenUtil().screenWidth / 1,
                  child: CustomText(
                    title: "Send",
                    fontWeight: FontWeight.bold,
                    color: whiteColor,
                    fontSize: 20.sp,
                  ),),
              SizedBox(height: 10,),
              CustomText(
                title:
                "Social Media Link",
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
             SizedBox(height: 20,),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: greenColor2,width: 2)
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                  CustomContainer(
                    height: 50.h,
                    width: 50,
                    ontap: () {},
                    rd: 100,
                    color: Colors.transparent,
                    // boxShadow: true,
                    child: Image.asset('assets/media/facebook1.png',scale: 3),
                  ),
                  CustomContainer(
                    height: 50,
                    width: 50,
                    ontap: () {},
                    rd: 100,
                    color: Colors.transparent,
                    // boxShadow: true,
                    child: Image.asset('assets/media/instagram.png',scale: 3),),
                  CustomContainer(
                    height: 50,
                    width: 50,
                    ontap: () {},
                    rd: 100,
                    color: Colors.transparent,
                    // boxShadow: true,
                    child:  Image.asset('assets/media/twitter.png',scale: 2.5),),
                  CustomContainer(
                    height: 50,
                    width: 50,
                    ontap: () {},
                    rd: 100,
                    color: Colors.transparent,
                    // boxShadow: true,
                    child:  Image.asset('assets/media/youtube1.png',scale: 2.5,),
                  ),
                  CustomContainer(
                    height: 50,
                    width: 50,
                    ontap: () {},
                    rd: 100,
                    color: Colors.transparent,
                    // boxShadow: true,
                    child:  Image.asset('assets/media/whatsapp.png',scale: 2.5),
                  ),

                ]),
              ),
              SizedBox(height: ScreenUtil().setHeight(15.h),),
          ],),
        ),
      ),
    );
  }
}
