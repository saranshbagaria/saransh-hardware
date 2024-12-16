import 'dart:convert';
import 'package:flutter/material.dart';

import '../../../utils/appConst/app_enums.dart';
import '../../../utils/appConst/app_urls.dart';
import 'network_helper.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  NetworkService._internal();
  static getInstance() => _instance;

  Future apiService(
      {GlobalKey? key,
      header,
      body,
      bool multiPart = false,
      params,
      METHOD method = METHOD.post,
      SSL ssl = SSL.https,
      baseURL = AppUrls.baseUrl,
      commonPoint = AppUrls.api,
      endpoint,
      filePath,
      String fileKey = 'document_name',
      attachmentList,
      nextFileKey}) async {
    if (await NetworkHelpers.networkCheck()) {
      NetworkHelpers.showNetworkErrorSnackBar();
    } else {
      var param = multiPart ? {'uploadType': params.toString()} : params;
      var endPoint = commonPoint + endpoint;
      var uri = NetworkHelpers.prepareUri(ssl, baseURL, endPoint, param);

      Map<String, String> requestHeaders =
          NetworkHelpers.prepareHeaders(method, header);

      if (body != null && method != METHOD.multiPart) {
        body = json.encode(body);
      }

      NetworkHelpers.logRequestDetails(
          requestHeaders, body, params, uri, method);

      switch (method) {
        case METHOD.get:
          return await NetworkHelpers.executeGetRequest(uri, requestHeaders);
        case METHOD.put:
          return await NetworkHelpers.executePutRequest(
              uri, requestHeaders, body);
        case METHOD.delete:
          return await NetworkHelpers.executeDeleteRequest(uri, requestHeaders);
        case METHOD.patch:
          return await NetworkHelpers.executePatchRequest(
              uri, requestHeaders, body);
        case METHOD.post:
          return await NetworkHelpers.executePostRequest(
              uri, requestHeaders, body);
        case METHOD.multiPart:
          return await NetworkHelpers.executeMultipartRequest(uri, header, body,
              filePath, fileKey, attachmentList, nextFileKey);
        default:
          return await NetworkHelpers.executePostRequest(
              uri, requestHeaders, body);
      }
    }
  }
}
