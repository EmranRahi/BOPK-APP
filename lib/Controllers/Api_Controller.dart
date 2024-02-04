
import 'dart:convert';

import '../model/DetailStaticBusinessModel.dart';
import '../model/LanguageModelClass.dart';
import '../model/StaticListModelPage.dart';
import 'package:http/http.dart' as http;


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
}
