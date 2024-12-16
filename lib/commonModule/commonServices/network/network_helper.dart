import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import '../../../utils/appConst/app_enums.dart';
import '../../../utils/reusableWidgets/reusable_snackbar.dart';
import 'network_exceptions.dart';


class NetworkHelpers {
  static Uri prepareUri(SSL ssl, baseURL, endPoint, param) {
    return (ssl == SSL.http)
        ? Uri.http(Uri.encodeFull(baseURL), Uri.encodeFull(endPoint), param)
        : Uri.https(Uri.encodeFull(baseURL), Uri.encodeFull(endPoint), param);
  }

  static Map<String, String> prepareHeaders(METHOD method, header) {
    Map<String, String> requestHeaders = method == METHOD.multiPart
        ? {'Content-type': 'multipart/form-data', HttpHeaders.acceptHeader: 'application/json'}
        : {'Content-type': 'application/json', 'Accept': 'application/json'};

    if (header != null) {
      requestHeaders.addAll(header);
    }
    return requestHeaders;
  }

  static void logRequestDetails(requestHeaders, body, params, uri, method) {
    Get.log("Header :  $requestHeaders");
    debugPrint("Body :  $body");
    debugPrint("Params :  $params");
    debugPrint("URL :  $uri");
    debugPrint("Method :  $method");
  }

  static Future executeGetRequest(Uri uri, Map<String, String> requestHeaders) async {
    try {
      final response = await http.get(uri, headers: requestHeaders);
      return _returnResponse(response);
    } on SocketException {
      showNetworkErrorSnackBar();
    } catch (error) {
      _handleGeneralError(error);
    }
  }

  static Future executePutRequest(Uri uri, Map<String, String> requestHeaders, body) async {
    try {
      final response = await http.put(uri, headers: requestHeaders, body: body);
      return _returnResponse(response);
    } on SocketException {
      showNetworkErrorSnackBar();
    } catch (error) {
      _handleGeneralError(error);
    }
  }

  static Future executeDeleteRequest(Uri uri, Map<String, String> requestHeaders) async {
    try {
      final response = await http.delete(uri, headers: requestHeaders);
      return _returnResponse(response);
    } on SocketException {
      showNetworkErrorSnackBar();
    } catch (error) {
      _handleGeneralError(error);
    }
  }

  static Future executePatchRequest(Uri uri, Map<String, String> requestHeaders, body) async {
    try {
      final response = await http.patch(uri, headers: requestHeaders, body: body);
      return _returnResponse(response);
    } on SocketException {
      showNetworkErrorSnackBar();
    } catch (error) {
      _handleGeneralError(error);
    }
  }

  static Future executePostRequest(Uri uri, Map<String, String> requestHeaders, body) async {
    try {
      final response = await http.post(uri, headers: requestHeaders, body: body);
      return _returnResponse(response);
    } on SocketException {
      showNetworkErrorSnackBar();
    } on Exception {
      _handleUnknownException();
    } catch (error) {
      _handleGeneralError(error);
    }
  }

  static Future executeMultipartRequest(Uri uri, header, body, filePath, fileKey, attachmentList, nextFileKey) async {
    try {
      var request = http.MultipartRequest('POST', uri);
      if (header != null) {
        request.headers.addAll(header);
      }
      if (body != null) {
        request.fields.addAll(body);
      }
      await _addFilesToRequest(request, filePath, fileKey);
      await _addAttachmentsToRequest(request, attachmentList, nextFileKey);
      final response = await request.send();
      var responseJson = await http.Response.fromStream(response);
      return _returnResponse(responseJson);
    } on SocketException {
      showNetworkErrorSnackBar();
    } catch (error) {
      _handleGeneralError(error);
    }
  }

  static Future<bool> networkCheck() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isEmpty || result[0].rawAddress.isEmpty;
    } on SocketException catch (_) {
      return true;
    }
  }

  // Handle responses and errors
  static dynamic _returnResponse(http.Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        return json.decode(response.body);
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      default:
        throw FetchDataException(
            'Error occurred while communicating with Server: ${response.statusCode}');
    }
  }

  static void showNetworkErrorSnackBar() {
    showCustomSnackBar(
      title: "Network Error",
      message: "Unable to connect to the server. Please check your internet connection.",
      backgroundColor: Colors.red,
    );
  }

  static void _handleGeneralError(error) {
    Get.back();
    if (kDebugMode) {
      print(error);
    }
    showCustomSnackBar(
      title: "Error",
      message: "Something went wrong",
      backgroundColor: Colors.black,
    );
  }

  static void _handleUnknownException() {
    Get.back();
    showCustomSnackBar(
      title: "Error",
      message: "Something went wrong",
      backgroundColor: Colors.black,
    );
  }

  static Future _addFilesToRequest(
      http.MultipartRequest request, filePath, fileKey) async {
    if (filePath != null) {
      final mimeTypeData = lookupMimeType(filePath)!.split('/');
      request.files.add(await http.MultipartFile.fromPath(fileKey, filePath,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
    }
  }

  static Future _addAttachmentsToRequest(
      http.MultipartRequest request, attachmentList, nextFileKey) async {
    if (attachmentList != null && nextFileKey != null) {
      final mimeTypeData = lookupMimeType(attachmentList)!.split('/');
      request.files.add(await http.MultipartFile.fromPath(nextFileKey, attachmentList,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
    }
  }
}
