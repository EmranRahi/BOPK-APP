import 'dart:convert';
import 'package:businessonlinepk/model/ContactUs_Model.dart';
import 'package:businessonlinepk/model/OpeningAndClosingTimeModel.dart';
import 'package:businessonlinepk/model/RegisterReviewRattingModel.dart';
import 'package:businessonlinepk/view/mobile_shops.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/DetailStaticBusinessModel.dart';
import '../model/DetailsPageProductModel.dart';
import '../model/LanguageModelClass.dart';
import '../model/RegisterYourBusinessModel.dart';
import '../model/StaticListModelPage.dart';
import 'package:http/http.dart' as http;
import '../view/customs_widgets/constant_color.dart';
import '../view/customs_widgets/custom_text.dart';
import 'BopkController.dart';


class APIController{
///  ALL Karobar or Business API
  ///  pagenation Api
  //   int _currentPage = 1;
  //    int _totalPages = 0;
  //    List<Datum> _data = [];
  //   final int pageSize = 20; // Define page size
  //   Future<List<List<Datum>>> fetchData(int subCategoryId) async {
  //     // final String url = "http://144.91.86.203/bopkapi/Karobar/GetData?id=$subCategoryId&page=$_currentPage&pageSize=20";
  //     final String url = "http://144.91.86.203/bopkapi/Karobar/GetData?id=1&page=1&s=no";
  //     try {
  //       final response = await http.get(Uri.parse(url));
  //       print(response.statusCode);
  //       print(response.body);
  //       print(url);
  //       if (response.statusCode == 200) {
  //         final Map<String, dynamic> responseData = json.decode(response.body);
  //         final StaticListModel staticListModel = StaticListModel.fromJson(responseData);
  //         _totalPages = staticListModel.totalPages ?? 0;
  //
  //         if (_currentPage == 1) {
  //           _data = staticListModel.data ?? [];
  //
  //         } else {
  //           _data.addAll(staticListModel.data ?? []);
  //         }
  //         return [_data];
  //       } else {
  //         throw Exception('Failed to load data');
  //       }
  //     } catch (error) {
  //       print('Error: $error');
  //       throw error;
  //     }
  //   }

  Future<DetailStaticBusinessModel?> fetchDataDetails(int? karobarId) async {
    try {
      final response = await http.get(Uri.parse('http://144.91.86.203/bopkapi/Karobar/Details/${karobarId}'));

      if (response.statusCode == 200) {
        // Parse the JSON response
        final Map<String, dynamic> jsonData = json.decode(response.body);

        // Convert JSON to model object
        DetailStaticBusinessModel businessModel = DetailStaticBusinessModel.fromJson(jsonData);
        return businessModel;
      } else {
        // Handle errors
        print('Failed to load data. Status code: ${response.statusCode}');
        return null;
      }
    } catch (error) {
      // Handle exceptions
      print('Error fetching data: $error');
      return null;
    }
  }

  /// Register Your Business Post API Controller
  Future<RegisterYourBusinessModel> registerBusinessPostData(
      RegisterYourBusinessModel profileScreenModel, BuildContext context) async {
    final createJson = jsonEncode(profileScreenModel);
    final response = await http.post(
      Uri.parse('http://144.91.86.203/bopkapi/Karobar/Register'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: createJson,
    );

    if (kDebugMode) {
      print("updateProfile$createJson");
      print("updateProfileBody${response.body}");
      print("updateStatusProfile${response.statusCode}");
    }

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          duration: Duration(seconds: 3),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Registration successful",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ),
      );
      // If the response is successful, navigate to the next screen
      return registerYourBusinessModelFromJson(response.body);
    } else {
      // Show Snackbar with error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          duration: Duration(seconds: 3),
          content: Container(
            width: MediaQuery.of(context).size.width * 0.90,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                "Failed to submit response",
                style: TextStyle(fontSize: 17),
              ),
            ),
          ),
        ),
      );

      // Throw exception
      throw Exception('Failed to create customer');
    }
  }




  /// Post Opening And Closing Hour API in Register your Business class
  static Future<void> openingAndClosingPostData(List<OpeningAndClosingTimeModel> models) async {
    final createJson = jsonEncode(models.map((model) => model.toJson()).toList());
    final response = await http.post(
      Uri.parse('http://144.91.86.203/bopkapi/ClosingOpeningtime/CreateDays'),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: createJson,
    );
    if (kDebugMode) {
      print("updateProfile$createJson");
    }
    if (kDebugMode) {
      print("updateProfileBody${response.body}");
    }
    if (kDebugMode) {
      print("Opening And Closing successfully${response.statusCode}");
    }

    if (response.statusCode == 200) {
      // Handle success if needed
    } else {
      throw Exception('Failed to create customer');
    }
  }


  /// Post Review Rating Api Business Register
   static Future<RegisterReviewModel> registerReviewModel(RegisterReviewModel profileScreenModel,BuildContext context) async {
      final createJson = jsonEncode(profileScreenModel);
      final response = await http.post(Uri.parse('http://144.91.86.203/bopkapi/api/KarobarReview/Create'),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: createJson,
      );

      if (kDebugMode) {
        print("updateProfile$createJson");
      }
      if (kDebugMode) {
        print("updateProfileBody${response.body}");
      }
      if (kDebugMode) {
        print("Data Post successfully${response.statusCode}");
      }
      print(response.statusCode);
      print(response.body);

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: Colors.transparent,

            elevation: 0,
            duration: Duration(seconds: 3),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Submitted Your Review ",
                  style: TextStyle(fontSize: 17,color: greenColor2),
                ),
              ),
            ),
          ),
        );

        return registerReviewModelFromJson(response.body);
      } else {
        // Show Snackbar with error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            duration: Duration(seconds: 3),
            content: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Failed to submit response",
                  style: TextStyle(fontSize: 17),
                ),
              ),
            ),
          ),
        );
        throw Exception('Failed to create customer');
      }

    }




    /// Post Contact us APi
  static Future<ContactUsModel> contactUsPost(ContactUsModel profileScreenModel,BuildContext context) async {
    final createJson = jsonEncode(profileScreenModel);
    final response = await http.post(
      Uri.parse('http://144.91.86.203/apiwebsites/Contacts/Create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Project":"2"
      },
      body: createJson,
    );
    if (kDebugMode) {
      print("updateProfile$createJson");
    }
    if (kDebugMode) {
      print("updateProfileBody${response.body}");
    }
    if (kDebugMode) {
      print("Contact Data Post successfully${response.statusCode}");
    }

    if (response.statusCode == 200) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Success'),
            content: Text('Your response has been submitted successfully.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return contactUsModelFromJson(response.body);
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Error'),
            content: Text('Failed to submit response.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      throw Exception('Failed to create customer');
    }

  }



  /// product OR Item API in Details
    static Future<List<DetailsPageProductModel>> fetchProducts() async {
      final response =
      await http.get(Uri.parse("http://144.91.86.203/bopkapi/KarobarItems"));
      print(response.body);
      print(response.statusCode);
      if (response.statusCode == 200) {
        List<dynamic> jsonList = json.decode(response.body);
        List<DetailsPageProductModel> products = jsonList
            .map((json) => DetailsPageProductModel.fromJson(json))
            .toList();
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    }

}
