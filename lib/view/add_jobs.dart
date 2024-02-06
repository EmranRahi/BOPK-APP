
import 'package:businessonlinepk/view/customs_widgets/custom_button.dart';
import 'package:businessonlinepk/view/customs_widgets/custom_textfield.dart';
import 'package:businessonlinepk/view/pay_now_screen.dart';
import 'package:businessonlinepk/view/register_your_business.dart';
import 'package:businessonlinepk/view/verify_download.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'HomePage_ofBopk.dart';
import 'business_for_sale.dart';
import 'customs_widgets/constant_color.dart';
import 'customs_widgets/custom_appbar.dart';
import 'customs_widgets/custom_text.dart';
import 'customs_widgets/date_time_picker.dart';
import 'deal_and_discount_screen.dart';
import 'get_discount_card_screeen.dart';
import 'get_your_business_now.dart';
import 'main_page_bopk.dart';
import 'menu_login.dart';
import 'mobile_shops.dart';
class AddJobs extends StatefulWidget {
  const AddJobs({super.key});

  @override
  State<AddJobs> createState() => _AddJobsState();
}

class _AddJobsState extends State<AddJobs> {
  final TextEditingController _dateOfBirthController = TextEditingController();
  String selectedValue = 'Select job';
  List<String> itemsList = ['Select job', 'Internee', 'Entry Level','Intermediate','Experienced'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar1(
         elevation: 0,
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
      body: ListView(
        children: [
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 10,vertical: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              CustomText(title: "Job Title",fontWeight: FontWeight.bold,fontSize: 16.sp,),
              CustomTextFormFieldWidget(hint: "Job Title",borderRadius: 08,),
              CustomText(title: "Company Name ",fontWeight: FontWeight.bold,fontSize: 16.sp,),
              CustomTextFormFieldWidget(hint: "Company Name",borderRadius: 08,),
              CustomText(title: "Job Description",fontWeight: FontWeight.bold,fontSize: 16.sp,),
              CustomTextFormFieldWidget(hint: "Job Description...",borderRadius: 08,maxLines: 4),
              CustomText(title: "Job Start Date",fontWeight: FontWeight.bold,fontSize: 16.sp,),
                DateTimePicker(
                  onDateSelected: (DateTime) {
                    _dateOfBirthController.text.toString();
                  },
                ),
            CustomText(title: "Address",fontWeight: FontWeight.bold,fontSize: 16.sp,),
            CustomTextFormFieldWidget(hint: "address",borderRadius: 08,contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
            Image.asset('assets/images/map.jpg'),
            SizedBox(height: 10),
            CustomText(title: "Email",fontWeight: FontWeight.bold,fontSize: 16.sp,),
            CustomTextFormFieldWidget(hint: "Job Title",borderRadius: 08,),
            SizedBox(height: 10),
            CustomText(title: "whatsApp",fontWeight: FontWeight.bold,fontSize: 16.sp,),
            CustomTextFormFieldWidget(hint: "whatsApp",borderRadius: 08,),
                // Adding DropdownButtonFormField
                SizedBox(height: 10.h,),
                CustomText(title: "Select Career Option" , fontWeight: FontWeight.bold,fontSize: 16.sp,),
                DropdownButtonFormField<String>(
                  value: selectedValue,
                  items: itemsList.map((String item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedValue = value!;
                    });
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 10.h,),
                CustomText(title: "Salary",fontWeight: FontWeight.bold,fontSize: 16.sp,),
                CustomTextFormFieldWidget(hint: "From",borderRadius: 08, contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10)),
                CustomTextFormFieldWidget(hint: "TO",borderRadius: 08,
                contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),),
                SizedBox(height: 20.h),
                Custom_Button_Widget(
                    ontap: (){}, rd: 10,
                    width: MediaQuery.of(context).size.width,
                   color: greenColor2,
                    child: CustomText(title: "Add Jobs",fontSize: 16.sp,color: whiteColor,fontWeight: FontWeight.bold,)),
                SizedBox(height: 10.h),
            ],
           ),
          ),
        ],
      ),
    );
  }
}
