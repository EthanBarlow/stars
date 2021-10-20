import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:picture_of_the_day/constants.dart';
import 'dart:convert';
import 'dart:async';

import 'package:picture_of_the_day/infrastructure/models/Star.dart';
import 'package:picture_of_the_day/star_exception.dart';

class ApiHelper {
  static Future<Star> getStar(DateTime date) async {
    String apiKey = dotenv.env['API_KEY']!;
    String _baseUrl = 'https://api.nasa.gov/planetary/apod?api_key=$apiKey';
    String urlDate = date.year.toString() +
        '-' +
        date.month.toString().padLeft(2, '0') +
        '-' +
        date.day.toString().padLeft(2, '0');
    String requestUrl = _baseUrl + '&date=' + urlDate;
    final response = await http.get(Uri.parse(requestUrl));
    if (response.statusCode == 403) {
      throw StarException(
        code: StarExceptionCode.forbidden,
        message: 'Failed to find the stars',
      );
    }
    int rateLimitRemaining =
        int.parse(response.headers['x-ratelimit-remaining'] ?? '0');
    if (rateLimitRemaining == 0) {
      throw StarException(
        code: StarExceptionCode.rateLimitReached,
        message: rateLimitMessage,
      );
    }
    return _returnResponse(response);
  }

  static Star _returnResponse(http.Response response) {
    if (response.statusCode < 400) {
      return Star.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to find the stars');
    }
  }

  static String deriveApodLink(DateTime date) {
    const basePrefix = 'https://apod.nasa.gov/apod/ap';
    const baseSuffix = '.html';

    // year % 100 should leave the last 2 digits of the year
    String year = (date.year % 100).toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    // return '$basePrefix$year$month$day$baseSuffix';
    return basePrefix + year + month + day + baseSuffix;
  }
}
