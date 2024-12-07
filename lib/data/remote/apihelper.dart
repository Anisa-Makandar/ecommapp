import 'dart:convert';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

import 'apiexceptions.dart';
import 'package:http/http.dart' as httpClient;

class ApiHelper {
  Future<dynamic> getAPI(
      {required String url, bool isHeaderRequired = true}) async {
    var uri = Uri.parse(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    try {
      var res = await httpClient.get(
        uri,
        headers: isHeaderRequired
            ? {
                "Authorization": " Bearer $token",
              }
            : {},
      );
      return returnJsonResponse(res);
    } on SocketException catch (e) {
      throw (FetchDataExceptions(errorMsg: "No Internet!!"));
    }
  }

  // post api
  Future<dynamic> postAPI({
    required String url,
    bool isHeaderRequired = true,
    Map<String, dynamic>? mBodyParams,
  }) async {
    var uri = Uri.parse(url);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString("token") ?? "";

    try {
      var res = await httpClient.post(
        uri,
        headers: isHeaderRequired
            ? {
                "Authorization": " Bearer $token",
              }
            : {},
        body: mBodyParams != null ? jsonEncode(mBodyParams) : null,
      );
      return returnJsonResponse(res);
    } on SocketException catch (e) {
      throw (FetchDataExceptions(errorMsg: "No Internet!!"));
    }
  }

  dynamic returnJsonResponse(httpClient.Response response) {
    switch (response.statusCode) {
      case 200:
        {
          var mData = jsonDecode(response.body);
          return mData;
        }
      case 400:
        throw BadRequestExceptions(errorMsg: response.body.toString());
      case 401:
      case 403:
        throw UnauthorizedExceptions(errorMsg: response.body.toString());
      case 500:
      case 502:
      default:
        throw FetchDataExceptions(
            errorMsg:
                'Error  Occured while communication with server with statusCode:${response.statusCode} ');
    }
  }
}
