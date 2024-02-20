import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../model/DetailStaticBusinessModel.dart';
import '../model/LanguageModelClass.dart';
import '../model/RegisterYourBusinessModel.dart';
import '../model/StaticListModelPage.dart';
import 'package:http/http.dart' as http;
import '../view/customs_widgets/constant_color.dart';
import '../view/customs_widgets/custom_text.dart';


class APIController{
///  ALL Karobar or Business API
  Future<List<StaticListModel>> fetchData(int subCategoryId) async {
    // final response = await http.get(Uri.parse("http://144.91.86.203/bopkapi/Karobar?all=false&count=5${subCategoryId}"));
    // print(response.body);
    // final response = await http.get(Uri.parse("http://144.91.86.203/bopkapi/Karobar?all=false&count=100${subCategoryId}"));
    final response = await http.get(Uri.parse("http://144.91.86.203/bopkapi/Karobar/get/${subCategoryId}"));
    print("http://144.91.86.203/bopkapi/Karobar/get/${subCategoryId}");
    if (response.statusCode == 200) {
      List<dynamic> jsonData = json.decode(response.body);
      List<StaticListModel> data = jsonData
          .map((json) => StaticListModel.fromJson(json))
          .toList();
      return data;
    } else {
      throw Exception('Failed to load data');
    }
    // try {
    //   final response = await http.get(Uri.parse("http://144.91.86.203/bopkapi/Karobar?all=false&count=5${subCategoryId}"));
    //   print(response.body);
    //   print(response.statusCode);
    //
    //   if (response.statusCode == 200) {
    //     List<dynamic> jsonData = json.decode(response.body);
    //
    //     print(jsonData);
    //
    //     List<StaticListModel> data = jsonData.map((json) => StaticListModel.fromJson(json)).toList();
    //     return data;
    //   } else {
    //     print('Failed to load data. Status code: ${response.statusCode}');
    //     throw Exception('Failed to load data');
    //   }
    // } catch (e) {
    //   print('Error fetching data: $e');
    //   throw Exception('Failed to load data');
    // }

  }

/// All Karobar Search Api
//   Future<List<StaticListSearchModel>> fetchDataList(String searchQuery) async {
//
//     final response = await http.get(Uri.parse("http://144.91.86.203/bopkapi/Karobar/Search?search=$searchQuery"));
//     if (response.statusCode == 200) {
//       // Parse the JSON data
//       print(response.body);
//       List<dynamic> jsonList = json.decode(response.body);
//       List<StaticListSearchModel> dataList = jsonList.map((json) => StaticListSearchModel.fromJson(json)).toList();
//
//       return dataList;
//     } else {
//       // If the server did not return a 200 OK response,
//       // throw an exception.
//       throw Exception('Failed to load data');
//     }
//   }

  //
  // static const String apiUrl = "http://77.68.75.133/api.falcon/Countries";
  //
  // Future<List<LanguageModelClass>> fetchCountries() async {
  //   try {
  //     final response = await http.get(Uri.parse(apiUrl));
  //
  //     if (response.statusCode == 200) {
  //       final List<dynamic> jsonData = json.decode(response.body);
  //       return jsonData.map((json) => LanguageModelClass.fromJson(json)).toList();
  //     } else {
  //       throw Exception('Failed to load countries');
  //     }
  //   } catch (error) {
  //     throw Exception('Error: $error');
  //   }
  // }

  /// in Side The Business or Karobar Details Api
  // Future<DetailStaticBusinessModel?> fetchDataDetails(int? karobarId) async {
  //   try {
  //     final response = await http.get(Uri.parse('http://144.91.86.203/apibopk/Karobar/Details/${karobarId}'));
  //
  //     if (response.statusCode == 200) {
  //       // Parse the JSON response
  //       final Map<String, dynamic> jsonData = json.decode(response.body);
  //
  //       // Convert JSON to model object
  //       DetailStaticBusinessModel businessModel = DetailStaticBusinessModel.fromJson(jsonData);
  //
  //       return businessModel;
  //     } else {
  //       // Handle errors
  //       print('Failed to load data. Status code: ${response.statusCode}');
  //       return null;
  //     }
  //   } catch (error) {
  //     // Handle exceptions
  //     print('Error fetching data: $error');
  //     return null;
  //   }
  // }
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

  // Future<void> RegisterBusinessPostData(RegisterYourBusinessModel data) async {
  //
  //
  //   final Uri url = Uri.parse('http://144.91.86.203/bopkapi/Karobar/Register');
  //   final createJson = jsonEncode(data);
  //
  //   print(createJson);
  //   final response = await http.post(url,
  //     headers: <String, String>{
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     },
  //     body: createJson,
  //
  //   );
  //        try{
  //          print(data);
  //          print(response.body);
  //          print(response.statusCode);
  //          if (response.statusCode == 200) {
  //            // If the server returns a 200 OK response, you might parse the response if needed
  //            // final parsedResponse = json.decode(response.body);
  //            // Example: Print the response body
  //            print(response.body);
  //          } else {
  //            // If the server did not return a 200 OK response,
  //            // throw an exception or handle the error accordingly
  //            throw Exception('Failed to post data: ${response.statusCode}');
  //          }
  //        }catch(e){}
  // }
  static Future<RegisterYourBusinessModel> RegisterBusinessPostData(RegisterYourBusinessModel profileScreenModel) async {
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
    }
    if (kDebugMode) {
      print("updateProfileBody${response.body}");
    }
    if (kDebugMode) {
      print("updateStatusProfile${response.statusCode}");
    }

    if (response.statusCode == 200) {
      return registerYourBusinessModelFromJson(response.body);
    } else {
      throw Exception('Failed to create customer');
    }

  }
}
