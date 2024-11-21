import 'dart:convert';
import 'dart:io';
import 'package:ecommapp/domain/apiexceptions.dart';
import 'package:http/http.dart' as httpClient;

class ApiHelper {
  Future<dynamic> getAPI({required String url}) async {
    var uri = Uri.parse(url);

    try {
      var res = await httpClient.get(uri, headers: {
        "Authorization":
            "Re1GK2UhhUzczdBnamK89fRhnWT7m7jrxvI8Fn7IH4bCx1G8ll0b4R4u",
      });
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
