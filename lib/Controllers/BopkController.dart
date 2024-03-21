import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/HomePageMainCategory.dart';

class BopkController {

  List<HomePageMainCategory> categories = [];
  bool isLoading = false;

  Future<void> fetchHomePageCategories() async {
    try {
      isLoading = true;
      final response = await http.get(Uri.parse("http://144.91.86.203/bopkapi/MainCategory"));
      print(response.body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        // Print jsonResponse before using map
        print('JSON Response: $jsonResponse');

        // Check if jsonResponse is not null and is a List
        if (jsonResponse != null && jsonResponse is List<dynamic>) {
          categories = jsonResponse.map((json) => HomePageMainCategory.fromJson(json)).toList();
        } else {
          // Handle the case where jsonResponse is null or not a List
          throw Exception('Invalid JSON structure or empty response');
        }
      } else {
        // Handle the case where the response status code is not 200
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading = false;
    }
  }
}




