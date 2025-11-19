import 'package:dio/dio.dart';
import 'package:quran/core/api/api_concumer.dart';
import 'package:quran/core/errors/error_model.dart';
import 'package:quran/core/errors/server_exception.dart';

class DioConcumer extends ApiConcumer {
  
  Dio dio;
  DioConcumer({required this.dio, required String baseUrl}) {
    dio.options.baseUrl = baseUrl;
    dio.interceptors.add(LogInterceptor(responseBody: true));
  }
  @override
  Future get(String path, {Map<String, dynamic>? queryParameter}) async {
    try {
      final response = await dio.get(path);
      return response.data;
    } on DioException catch (e) {
      errorHandelling(e);
    }
  }

  void errorHandelling(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        throw ServerException(
          errorModel: ErrorModel(errorMessage: e.message.toString()),
        );
      case DioExceptionType.sendTimeout:
        throw ServerException(
          errorModel: ErrorModel(errorMessage: e.message.toString()),
        );
      case DioExceptionType.receiveTimeout:
        throw ServerException(
          errorModel: ErrorModel(errorMessage: e.message.toString()),
        );
      case DioExceptionType.badCertificate:
        throw ServerException(
          errorModel: ErrorModel(errorMessage: e.message.toString()),
        );
      case DioExceptionType.badResponse:
        throw ServerException(
          errorModel: ErrorModel(errorMessage: e.message.toString()),
        );
      case DioExceptionType.cancel:
        throw ServerException(
          errorModel: ErrorModel(errorMessage: e.message.toString()),
        );
      case DioExceptionType.connectionError:
        throw ServerException(
          errorModel: ErrorModel(errorMessage: e.message.toString()),
        );
      case DioExceptionType.unknown:
        throw ServerException(
          errorModel: ErrorModel(errorMessage: e.message.toString()),
        );
    }
  }
}
