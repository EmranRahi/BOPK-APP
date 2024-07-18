import 'dart:convert';
import 'dart:io';
import 'package:businessonlinepk/model/BannerApiModel.dart';
import 'package:businessonlinepk/model/ContactUs_Model.dart';
import 'package:businessonlinepk/model/LoginModel.dart';
import 'package:businessonlinepk/model/OpeningAndClosingTimeModel.dart';
import 'package:businessonlinepk/model/RegisterReviewRattingModel.dart';
import 'package:businessonlinepk/model/UpdateProfileModel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../Service/ApiResponse.dart';
import '../Service/ApiService.dart';
import '../model/AddProductModel.dart';
import '../model/DetailStaticBusinessModel.dart';
import '../model/DetailsPageProductModel.dart';
import '../model/DisplayReviewModel.dart';
import '../model/HomePageMainCategory.dart';
import '../model/OpenningHour.dart';
import '../model/RegisterYourBusinessModel.dart';
import 'package:http/http.dart' as http;
import '../model/SearchBusinessModel.dart';
import '../model/StaticListModelPage.dart';
import '../view/customs_widgets/constant_color.dart';


class APIController{

  Future<void> deleteKarobar(int karobarId) async {
    final String apiUrl = 'https://bopkapi.businessonline.pk/Karobar/Delete?id=$karobarId';

    try {
      final response = await http.delete(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        print('Karobar deleted successfully');
      } else {
        print('Failed to delete karobar. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error deleting karobar: $error');
    }
  }


  Future<LoginModel?> loginUser(String username, String password) async {
    final url = Uri.parse('https://bopkapi.businessonline.pk/Authentication/Login?email=$username&password=$password');
    https://bopkapi.businessonline.pk/Authentication/Login?email=03129641706&password=6733

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return LoginModel.fromJson(responseData);
      } else {
        // Handle error response
        print('Error: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      // Handle network errors
      print('Network error: $e');
      return null;
    }
  }



  Future<http.Response> searchBusiness(SearchBusinessModel model) async {
    try {
      final createJson = jsonEncode(model.toJson());
      final response = await http.post(
        Uri.parse("https://bopkapi.businessonline.pk/Karobar/GetByLocationSearchingPost"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: createJson,
      );

      print('Request JSON: $createJson');
      print('Response: ${response.statusCode} - ${response.body}');

      return response;
    } catch (e) {
      print('Error in searchBusiness: $e');
      throw Exception('Failed to connect to the server. Please check your internet connection.');
    }
  }

  // String _extractErrorMessage(String responseBody) {
  //   try {
  //     // Check if the response body starts with the status code followed by '- '
  //     if (responseBody.startsWith('400 - ')) {
  //       // Extract the error message after the status code prefix
  //       return responseBody.substring('400 - '.length);
  //     } else {
  //       // If the response body doesn't match the expected format, return a generic message
  //       return 'Failed to process request';
  //     }
  //   } catch (e) {
  //     print('Error parsing error message: $e');
  //     return 'Failed to parse error message';
  //   }
  // }



  Future<List<DisplayReviewModel>> fetchReviews(int id) async {
    final response = await http.get(Uri.parse('https://bopkapi.businessonline.pk/KarobarReview?id=$id'));
    // final response = await http.get(Uri.parse('https://bopkapi.businessonline.pk/KarobarReview?id=$id'));
print(response.statusCode);
print(response.body);
print('https://bopkapi.businessonline.pk/KarobarReview?id=$id');
print('https://bopkapi.businessonline.pk/KarobarReview?id=$id');
    if (response.statusCode == 200) {
      return displayReviewModelFromJson(response.body);
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  static Future<List<BannerApiModel>> getBanners() async {
    List<BannerApiModel> list = [];
    // Assuming ApiResponse and ApiService classes are defined
    ApiResponse res = ApiResponse();
    ApiService apiService = ApiService();
    res = await apiService.GetData("https://bopkapi.businessonline.pk/api/KarobarBanner");
    print(res.StatusCode);
    if (res.StatusCode == 0) {
      // Handle error case
    } else if (res.StatusCode == 200) {
      List data = res.Response;
      print(data.toString());

      // Convert data to List<BannerApiModel>
      list = data.map<BannerApiModel>((json) => BannerApiModel.fromJson(json)).toList();
    } else {
      // Handle error case
    }
    return list;
  }

  // List<HomePageMainCategory> categories = [];
  // bool isLoading = false;
  //
  // Future<void> fetchHomePageCategories() async {
  //   try {
  //     isLoading = true;
  //     // final response = await http.get(Uri.parse("https://bopkapi.businessonline.pk/MainCategory"));
  //     final response = await http.get(Uri.parse("https://bopkapi.businessonline.pk/MainCategory"));
  //     print(response.body);
  //     print(response.statusCode);
  //     print("https://bopkapi.businessonline.pk/MainCategory");
  //
  //     if (response.statusCode == 200) {
  //       dynamic jsonResponse = json.decode(response.body);
  //
  //       // Print jsonResponse before using map
  //       print('JSON Response: $jsonResponse');
  //
  //       // Check if jsonResponse is not null and is a List
  //       if (jsonResponse != null && jsonResponse is List<dynamic>) {
  //         categories = jsonResponse.map((json) => HomePageMainCategory.fromJson(json)).toList();
  //       } else {
  //         // Handle the case where jsonResponse is null or not a List
  //         throw Exception('Invalid JSON structure or empty response');
  //       }
  //     } else {
  //       // Handle the case where the response status code is not 200
  //       throw Exception('Failed to load data. Status code: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //   } finally {
  //     isLoading = false;
  //   }
  // }
  ///  ALL Karobar or Business API
  ///  pagenation Api
  Future<DetailStaticBusinessModel?> fetchDataDetails(int? karobarId) async {
    try {
      final response = await http.get(Uri.parse('https://bopkapi.businessonline.pk/Karobar/Details/$karobarId'));
      print("https://bopkapi.businessonline.pk/Karobar/Details/$karobarId");
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

  Future<ApiResponseReg> registerBusinessPostData(RegisterYourBusinessModel profileScreenModel, BuildContext context) async {
    final createJson = jsonEncode(profileScreenModel);
    final response = await http.post(
      Uri.parse('https://bopkapi.businessonline.pk/RegisterBusinesses/Create'),
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
     print("successfully register the business");
    } else {
      // Show Snackbar with error message
     print("field to register the business");
    }

    // Return ApiResponse object with status code and response body
    return ApiResponseReg(statusCode: response.statusCode, responseBody: response.body);
  }
  Future<ApiResponseReg> updateBasicProfile(UpdateProfileModel updateProfileModel, BuildContext context) async {
    final createJson = jsonEncode(updateProfileModel);
    final response = await http.post(
      Uri.parse('https://bopkapi.businessonline.pk/RegisterBusinesses/UpdateProfile'),
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
      print("successfully register the business");
    } else {
      // Show Snackbar with error message
      print("field to register the business");
    }

    // Return ApiResponse object with status code and response body
    return ApiResponseReg(statusCode: response.statusCode, responseBody: response.body);
  }





  /// Post Opening And Closing Hour API in Register your Business class
  static Future<void> openingAndClosingPostData(List<OpenningHour> models) async {
    final createJson = jsonEncode(models.map((model) => model.toJson()).toList());
    final response = await http.post(
      Uri.parse('https://bopkapi.businessonline.pk/ClosingOpeningtime/CreateDays'),
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
  static Future<RegisterReviewModel> registerReviewModel(RegisterReviewModel profileScreenModel) async {
    final createJson = jsonEncode(profileScreenModel);
    final response = await http.post(
      Uri.parse('https://bopkapi.businessonline.pk/KarobarReview/Create'),
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
      return registerReviewModelFromJson(response.body);
    } else {
      // Throw exception with error message
      throw Exception('Failed to create customer');
    }
  }

  static Future<http.Response> contactUsPost(ContactUsModel profileScreenModel) async {
    final createJson = jsonEncode(profileScreenModel);
    final response = await http.post(
      Uri.parse('https://apipython.highperformancecomputing.co.uk/Contacts/Create'),
      headers: <String, String>{
        'Content-Type': 'application/json',
        "Project":"7"
      },
      body: createJson,
    );

    return response;
  }

  Future<void> uploadImages(int id, List<String> selectedImagePaths,String url) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$url$id'),
    );

    for (var i = 0; i < selectedImagePaths.length; i++) {
      print("hamad ${selectedImagePaths[i]}");
      File imageFile = File(selectedImagePaths[i]);
      request.files.add(await http.MultipartFile.fromPath(
        'files',
        imageFile.path,
        filename: 'image_$i.jpg',
      ));
    }

    try {
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  Future<void> uploadBanners(int id, List<String> selectedImagePaths) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://bopkapi.businessonline.pk/api/KarobarBanner/UploadImage?id=$id'),
    );

    for (var i = 0; i < selectedImagePaths.length; i++) {
      print("hamad ${selectedImagePaths[i]}");
      File imageFile = File(selectedImagePaths[i]);
      request.files.add(await http.MultipartFile.fromPath(
        'files',
        imageFile.path,
        filename: 'image_$i.jpg',
      ));
    }

    try {
      http.StreamedResponse response = await request.send();
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(await response.stream.bytesToString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print('Error uploading images: $e');
    }
  }

  // /// Post Contact us APi
  // static Future<ContactUsModel> contactUsPost(ContactUsModel profileScreenModel,BuildContext context) async {
  //   final createJson = jsonEncode(profileScreenModel);
  //   final response = await http.post(
  //     Uri.parse('https://apipython.highperformancecomputing.co.uk/Contacts/Create'),
  //     headers: <String, String>{
  //       'Content-Type': 'application/json',
  //       "Project":"7"
  //     },
  //     body: createJson,
  //   );
  //   if (kDebugMode) {
  //     print("updateProfile$createJson");
  //   }
  //   if (kDebugMode) {
  //     print("updateProfileBody${response.body}");
  //   }
  //   if (kDebugMode) {
  //     print("Contact Data Post successfully${response.statusCode}");
  //   }
  //
  //   if (response.statusCode == 200) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Success'),
  //           content: Text('Your response has been submitted successfully.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     return contactUsModelFromJson(response.body);
  //   } else {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Error'),
  //           content: Text('Failed to submit response.'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //     throw Exception('Failed to create customer');
  //   }
  //
  // }

  /// product OR Item API in Details
    static Future<List<DetailsPageProductModel>> fetchProducts() async {
      final response =
      await http.get(Uri.parse("https://bopkapi.businessonline.pk/KarobarItems"));
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
class ApiResponseReg {
  int? statusCode;
  dynamic responseBody; // Field to store the response body

  ApiResponseReg({this.statusCode, required this.responseBody});
}
