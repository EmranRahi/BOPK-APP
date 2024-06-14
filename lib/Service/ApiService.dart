// ignore_for_file: file_names, non_constant_identifier_names

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'ApiResponse.dart';

class ApiService {
  Future<ApiResponse> PostData(String URL, Map<String, dynamic> Data) async {
    String js = jsonEncode(Data);

    print("sad" + js.toString());
    ApiResponse obj = ApiResponse();
    http.Response response;
    // ignore: duplicate_ignore
    try {
      response = await http.post(
        Uri.parse(URL),
        body: jsonEncode(Data),
        headers: {'Content-Type': 'application/json'},
      );
    } catch (SocketException) {
      obj.StatusCode = 0;
      return obj;
    }
    if (response.statusCode == 200) {
      obj.StatusCode = response.statusCode;
      obj.Response = json.decode(response.body);
    } else if (response.statusCode == 401) {
      // SetNewToken();
      try {
        response = await http.post(
          Uri.parse(URL),
          body: jsonEncode(Data),
        );
      } catch (SocketException) {
        obj.StatusCode = 0;
        return obj;
      }
      if (response.statusCode == 200) {
        obj.StatusCode = response.statusCode;
        obj.Response = json.decode(response.body).toString();
      } else if (response.statusCode == 401) {
        obj.StatusCode = 1;
      } else {
        obj.StatusCode = 0;
      }
    } else {
      obj.StatusCode = 0;
    }
    return obj;
  }

  Future<ApiResponse> GetData(String URL) async {
    ApiResponse obj = new ApiResponse();
    http.Response response;
    try {
      response = await http.get(
        Uri.parse(URL),
      );
    } catch (SocketException) {
      obj.StatusCode = 0;
      return obj;
    }
    if (response.statusCode == 200) {
      obj.StatusCode = response.statusCode;
      obj.Response = json.decode(response.body);
    } else if (response.statusCode == 401) {
      // SetNewToken();

      try {
        response = await http.get(
          Uri.parse(URL),
        );
      } catch (SocketException) {
        obj.StatusCode = 0;
        return obj;
      }
      if (response.statusCode == 200) {
        obj.StatusCode = response.statusCode;
        obj.Response = json.decode(response.body);
      } else if (response.statusCode == 401) {
        obj.StatusCode = 1; //redirect to login screen
      } else {
        obj.StatusCode = 0; //error in connection
      }
    } else {
      obj.StatusCode = 0; //error in connection
    }
    return obj;
  }

  Future<ApiResponse> GetDataAddress(String URL) async {
    ApiResponse obj = new ApiResponse();
    http.Response response;
    try {
      response = await http.get(Uri.parse(URL), headers: {
        "apiKey":
            "ZDljYmY3YWI3MDE2NGZlZDg5NDczOTY4MGU0ZWI4NjY6MzczYjhlNzMtMWUxNC00OGE1LWFmOGUtZjViNmRiNDBkN2Ri"
      });
    } catch (SocketException) {
      obj.StatusCode = 0;
      return obj;
    }
    if (response.statusCode == 200) {
      obj.StatusCode = response.statusCode;
      obj.Response = json.decode(response.body);
    } else if (response.statusCode == 401) {
      // SetNewToken();

      try {
        response = await http.get(
          Uri.parse(URL),
        );
      } catch (SocketException) {
        obj.StatusCode = 0;
        return obj;
      }
      if (response.statusCode == 200) {
        obj.StatusCode = response.statusCode;
        obj.Response = json.decode(response.body);
      } else if (response.statusCode == 401) {
        obj.StatusCode = 1; //redirect to login screen
      } else {
        obj.StatusCode = 0; //error in connection
      }
    } else {
      obj.StatusCode = 0; //error in connection
    }
    return obj;
  }
}
