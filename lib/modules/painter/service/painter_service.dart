import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter_testing/modules/painter/service/painter_list_response.dart';

import '../../../utils/appConst/app_urls.dart';
import 'package:http/http.dart' as http;

abstract class IPainterService {
  Future<bool> sendPainterData(Painter painter);

  Future<PainterListResponse> getPainterList(search, limit, page);
}

class Painter {
  String _name;
  String _contactNumber;

  Painter(this._name, this._contactNumber);

  String get contactNumber => _contactNumber;

  set contactNumber(String value) {
    _contactNumber = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }
}

class PainterService implements IPainterService {
  @override
  Future<bool> sendPainterData(Painter painter) async {
    const url = '${AppUrls.api}/users/painter';
    final Map<String, dynamic> requestData = {
      'name': painter.name,
      'contactNumber': painter.contactNumber
    };
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(requestData),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  @override
  Future<PainterListResponse> getPainterList(search, limit, page) async {
    const url = '${AppUrls.api}/users/painter';
    var queryParam = {
      "limit": limit.toString(),
      "page": page.toString(),
    };
    if (search != "") {
      queryParam['name'] = search;
    }
    try {
      final response = await http.get(
        Uri.parse(url).replace(queryParameters: queryParam),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        PainterListResponse painterListResponse =
            PainterListResponse.fromJson(decodedJson);
        return painterListResponse;
      } else {
        throw Exception('invalid response');
      }
    } catch (error) {
      print(error);
      throw Exception('failed to fetch data');
    }
  }
}
