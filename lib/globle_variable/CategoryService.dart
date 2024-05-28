import 'dart:convert';

import '../model/HomePageMainCategory.dart';
import 'package:http/http.dart'as http;


/// this is api call with singleton pattern
/// Advantages of Singleton Pattern:
/// Single Instance: Ensures that there is only one instance of the service managing the data, which helps in maintaining a consistent state across the app.
/// Global Access: Provides a global access point to the data, which simplifies data sharing and access across different parts of the application.
/// Singleton Pattern: CategoryService ensures a single instance managing the categories, allowing easy and consistent access throughout the app.
class CategoryService {
  CategoryService._privateConstructor();
  static final CategoryService _instance = CategoryService._privateConstructor();
  static CategoryService get instance => _instance;

  List<HomePageMainCategory> _categories = [];
  bool isLoading = false;

  List<HomePageMainCategory> get categories => _categories;

  Future<void> fetchCategories() async {
    try {
      isLoading = true;
      final response = await http.get(Uri.parse("https://bopkapi.businessonline.pk/MainCategory"));

      if (response.statusCode == 200) {
        dynamic jsonResponse = json.decode(response.body);

        if (jsonResponse != null && jsonResponse is List<dynamic>) {
          _categories = jsonResponse.map((json) => HomePageMainCategory.fromJson(json)).toList();
        } else {
          throw Exception('Invalid JSON structure or empty response');
        }
      } else {
        throw Exception('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching data: $e');
    } finally {
      isLoading = false;
    }
  }
}
