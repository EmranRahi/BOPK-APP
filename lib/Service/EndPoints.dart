import 'dart:async';
import 'package:http/http.dart' as http;
class EndPoints{
  static Future getCharacters() {
    return http.get(Uri.parse("http://api2.businessonline.pk/api/images?businessid=48173"));
  }
  static Future getCityname() {
    return http.get(Uri.parse("http://api2.businessonline.pk/api/images?businessid=48173"));
  }

  static Future getHomeCategory() {
    return http.get(Uri.parse("http://144.91.86.203/boukapi/api/Home"));
  }
}