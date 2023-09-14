import 'package:dio/dio.dart';

String ipAddress = 'https://petropal.sandbox.co.ke:8040';

class ApiClient {
  final Dio _dio;

  ApiClient() : _dio = Dio();

  Future<dynamic> post(String path, dynamic data,
      {Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.post('$ipAddress$path',
          data: data, options: Options(headers: headers));
      return response.data;
    } on DioException catch (error) {
      return error.response?.data;
    }
  }

  Future<dynamic> get(String path,
      {Map<String, dynamic>? queryParameters,
      Map<String, dynamic>? headers}) async {
    try {
      final response = await _dio.get('$ipAddress$path',
          queryParameters: queryParameters, options: Options(headers: headers));
      return response.data;
    } on DioException catch (error) {
      return error.response;
    }
  }
}
