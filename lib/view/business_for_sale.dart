import 'package:businessonlinepk/view/customs_widgets/custom_containers_design.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'HomePage_ofBopk.dart';
import 'add_jobs.dart';
import 'customs_widgets/constant_color.dart';
import 'customs_widgets/custom_appbar.dart';
import 'customs_widgets/custom_button.dart';
import 'customs_widgets/custom_text.dart';
import 'customs_widgets/custom_textfield.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'main_page_bopk.dart';
import 'menu_login.dart';
import 'mobile_shops.dart';

class BusinessForSale extends StatefulWidget {
  const BusinessForSale({super.key});

  @override
  State<BusinessForSale> createState() => _BusinessForSaleState();
}

class _BusinessForSaleState extends State<BusinessForSale> {
  final CarouselController _carouselController = CarouselController();
  int _currentImageIndex = 0;
  List<String> imgList = [
    'assets/images/deal.jpg',
    'assets/images/1.jpg',
    'assets/images/2.jpg',
    'assets/images/3.jpg',
    'assets/images/cmptr.jpg',
  ];

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
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CustomTextFormFieldWidget(
              borderRadius: 10,
              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              prefixIcon: Icon(Icons.search),
              hint: "Search Your Business",
            ),
            Custom_Button_Widget(
              width: MediaQuery.of(context).size.width / 1.0,
              ontap: () {},
              rd: 10,
              color: greenColor2,
              child: CustomText(
                title: "Add Business For Sale",
                color: whiteColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                height: 200.0,
                autoPlay: true,
              ),
              items: imgList.map((item) {
                return Container(
                  margin: EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      height: 147,
                      width: 336,
                      scale: 2,
                      item,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 2,
                      shadowColor: Colors.grey,
                      color: whiteColor,
                      borderOnForeground: true,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/pay.jpg', scale: 4),
                          SizedBox(height: 10.h),
                          Padding(
                            padding:  EdgeInsets.only(left: 10.w),
                            child: CustomText(
                              title: "Rattan furniture",fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Padding(
                            padding:  EdgeInsets.only(left: 10.w),
                            child: CustomText(
                              title: "rattan furniture sofa seat and all eatmes",color: grayColor,
                            ),
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Custom_Button_Widget(
                                ontap: () {},
                                rd: 7.r,
                                width: ScreenUtil().setWidth(110.w),
                                height: 30.h,
                                color: greenColor2,
                                // border: Border.all(),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding:  EdgeInsets.only(left: 3),
                                      child: Image.asset('assets/images/whtsapp.png',scale: 7),
                                    ),
                                    SizedBox(width: 7,),
                                    CustomText(
                                        title: "whatsApp",
                                        color: whiteColor,
                                        fontWeight: FontWeight.bold),
                                  ],
                                ),
                              ),
                              Custom_Button_Widget(
                                ontap: () {},
                                rd: 7.r,
                                border: Border.all(color: grayColor2),
                                color: whiteColor,
                                width: ScreenUtil().setWidth(100.w),
                                height: 30.h,
                                child: CustomText(
                                    title: "Lahore", fontWeight: FontWeight.bold),
                              ),
                              TextButton(onPressed: (){}, child: CustomText(title: "View More>",))
                            ],
                          ),
                          SizedBox(height: 10,),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
