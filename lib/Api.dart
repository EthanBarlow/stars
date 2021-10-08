import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import 'package:picture_of_the_day/StarPicture.dart';

class ApiHelper {
  final String _baseUrl = 'http://192.168.1.144:5000/v1/apod';

  Future<StarPicture> get(DateTime date) async {
    String urlDate = date.year.toString() +
        '-' +
        date.month.toString().padLeft(2, '0') +
        '-' +
        date.day.toString().padLeft(2, '0');
    String requestUrl = _baseUrl + '?date=' + urlDate;
    print('Api get, url $requestUrl');
    final response = await http.get(requestUrl);
    return _returnResponse(response);
  }

  StarPicture _returnResponse(http.Response response) {
    if (response.statusCode < 400) {
      return StarPicture.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to find the stars');
    }
  }
}
