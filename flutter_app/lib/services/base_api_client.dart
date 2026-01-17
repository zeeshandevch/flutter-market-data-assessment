import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';

class BaseApiClient {
  static const String baseUrl = AppConstants.baseUrl;


  static Future<dynamic> getMethod(String endpoint) async {
    try {
      final uri = Uri.parse('$baseUrl$endpoint');
      final response = await http.get(uri);

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw HttpException(
          'Request failed with status: ${response.statusCode}',
        );
      }
    } on SocketException {
      throw const SocketException("No internet connection");
    } on FormatException {
      throw const FormatException("Bad response format");
    }
  }
}
