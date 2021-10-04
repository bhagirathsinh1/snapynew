import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:photos_by_snappy/ApiManager/save_data.dart';
import 'package:photos_by_snappy/pages/login_page.dart';
import 'package:photos_by_snappy/pages/register_page.dart';
import 'package:photos_by_snappy/routes.dart';

class HttpConfig {
  static const String API_BASE_URL = "http://192.168.1.22:3000/api/";
  static const String IMAGE_BASE_URL = "http://192.168.1.22:3000/uploads/";

  static Map<String, String> requestHeaders = {
    HttpHeaders.contentTypeHeader: 'application/json',
    HttpHeaders.acceptHeader: 'application/json',
  };

  // static schedualEvent(Map data, BuildContext context) async {
  //   try {
  //     final response =
  //         await http.post(Uri.parse(API_BASE_URL + "events"), body: data);
  //     print(response.body);
  //     if (response.statusCode == 200 || response.statusCode == 201) {
  //       Navigator.pushNamed(context, Routes.eventCreatedSuccess);
  //     }
  //     if (response.statusCode == 400) {
  //       final snackbar = SnackBar(content: Text("Please Enter vaild Data"));
  //       ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //     }
  //   } catch (e) {
  //     final snackbar = SnackBar(content: Text(e.toString()));
  //     ScaffoldMessenger.of(context).showSnackBar(snackbar);
  //     print(e.toString());
  //   }
  // }

//   static loginUser(Map data, BuildContext context) async {
//     try {
//       final response = await http
//           .post(Uri.parse(API_BASE_URL + "auth/user/login"), body: data);
//       print(response.body);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         Map<String, dynamic> map = jsonDecode(response.body);
//         // SaveData.saveUserData(map['email'], map['firstName'], map['lastName'],
//         //     map['access_token'], map['id']);
//         // isLoading = false;
//         // Navigator.pushNamed(context, Routes.startevent);
// //        isLoading = false;

//       } else if (response.statusCode == 401) {
//         final snackbar = SnackBar(content: Text('Enter Right Credential'));
//         ScaffoldMessenger.of(context).showSnackBar(snackbar);
//       }
//     } catch (e) {
//       final snackbar = SnackBar(content: Text(e.toString()));
//       ScaffoldMessenger.of(context).showSnackBar(snackbar);
//       print(e.toString());
//     }
//   }

  static Future<String> uploadProfilePic(dynamic imageFile) async {
    try {
      var request3 =
          http.MultipartRequest('POST', Uri.parse(API_BASE_URL + "uploads"));

      request3.files.add(await http.MultipartFile.fromPath(
        "file",
        "${imageFile.path}",
        contentType: MediaType('image', 'jpg'),
      ));

      StreamedResponse res3 = await request3.send();
      var response = await http.Response.fromStream(res3);
      var map = json.decode(response.body);
      print(map.toString());
      var profilepic = map['filename'];

      return profilepic.toString();
    } catch (e) {
      print(e.toString());

      return "";
    }
  }

  static Future<Response> httpGet(String url) async {
    // debugPrint("URL : ${Uri.parse(API_BASE_URL + url)}");
    // var token = await SharedPrefService.getDriverToken();
    // print("token $token");
    return http.get(
      Uri.parse(API_BASE_URL + url),
      // headers: {
      //   HttpHeaders.authorizationHeader: 'Bearer $token',
      // },
    );
  }

  static Future<Response> httpPost(String url, dynamic data) async {
    var dataEncoded = jsonEncode(data);
    return http.post(
      Uri.parse(API_BASE_URL + url),
      body: dataEncoded,
      headers: requestHeaders,
    );
  }
}
