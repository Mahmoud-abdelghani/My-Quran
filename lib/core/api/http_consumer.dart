import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/errors/error_model.dart';
import 'package:quran/core/errors/server_exception.dart';

class HttpConsumer extends ApiConcumer {
  HttpConsumer({required this.baseUrl});
  final String baseUrl;
  @override
  Future get(String path, {Map<String, dynamic>? queryParameter}) async {
    try {
      var url = Uri.parse('$baseUrl$path');
      final response = await http.get(url);
      return jsonDecode(response.body);
    } on HttpException catch (e) {
      throw ServerException(errorModel: ErrorModel(errorMessage: e.message));
    }
  }
}
