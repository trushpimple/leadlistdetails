import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:myknott/Config/string.dart';

import 'api_response.dart';

class APICalling {
  static Future<Object> getData(
    String link, {
    int type = 0,
    Map<String, dynamic> body,
    Map<String, String> headers,
  }) async {
    // ignore: prefer_typing_uninitialized_variables
    var request;
    try {
      //type:- 0--> GET || 1--> POST || 2-->PUT || 3-->DELETE
      if (type == 0) {
        request = await http.get(Uri.parse(link));
      } else if (type == 1) {
        request = await http.post(
          Uri.parse(link),
          body: body,
          headers: headers,
        );
      } else if (type == 2) {
        request = await http.put(
          Uri.parse(link),
          body: jsonEncode(body),
          headers: headers,
        );
      } else {
        request = await http.delete(Uri.parse(link));
      }
      print(request.body);
      if (ALL_OK == request.statusCode) {
        return APISuccess(
            statusCode: request.statusCode, reponse: jsonDecode(request.body));
      } else {
        return APIFailed(statusCode: ERROR, reponse: "Failed");
      }
    } on SocketException {
      return APIFailed(statusCode: NO_INTERNET, reponse: 'No Internet');
    } on FormatException {
      return APIFailed(statusCode: INVALID_FORMAT, reponse: 'Format Exception');
    } on HttpException {
      return APIFailed(statusCode: ERROR, reponse: 'HTTP Exception');
    } on NoSuchMethodError catch (e) {
      return APIFailed(statusCode: UNKNOWN_ERROR, reponse: e.toString());
    } catch (e) {
      return APIFailed(statusCode: UNKNOWN_ERROR, reponse: request.body);
    }
  }
}

class APICallingForFiles {
  static Future<Object> pushFiles({
    String link,
    Map<String, dynamic> files,
    Map<String, String> body,
    Map<String, String> headers,
  }) async {
    try {
      http.MultipartRequest request =
          http.MultipartRequest('POST', Uri.parse(link));
      files.forEach((key, value) async {
        try {
          if (value is List<String>) {
            for (var item in value) {
              request.files.add(await http.MultipartFile.fromPath(key, item));
            }
          } else {
            request.files.add(await http.MultipartFile.fromPath(key, value));
          }
        } on FileSystemException catch (e) {
          debugPrint('error1====>>' + e.message.toString());
        } catch (e) {
          debugPrint('error2====>>' + e.toString());
        }
      });
      request.fields.addAll(body);
      http.StreamedResponse response = await request.send();
      final resBody = await response.stream.bytesToString();
      if (response.statusCode == ALL_OK) {
        return APISuccess(statusCode: ALL_OK, reponse: jsonDecode(resBody));
      } else {
        return APISuccess(statusCode: ERROR, reponse: 'Failed To Upload');
      }
    } on SocketException {
      return APIFailed(statusCode: NO_INTERNET, reponse: 'No Internet');
    } on FormatException {
      return APIFailed(statusCode: INVALID_FORMAT, reponse: 'Format Exception');
    } on HttpException {
      return APIFailed(statusCode: ERROR, reponse: 'HTTP Exception');
    } catch (e) {
      debugPrint('error4====>>' + e.toString());
      return APIFailed(statusCode: UNKNOWN_ERROR, reponse: ERROR_OCCURED);
    }
  }
}

class postApiCall {
  static postrequest(var data, var url) async {
    var response = await http.post(
      Uri.parse(url),
      body: jsonEncode(data),
      headers: {"Content-Type": "application/json"},
    );
    var body = response.body;
    return body;
  }
}
