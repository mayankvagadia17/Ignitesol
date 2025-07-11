import 'package:dio/dio.dart';
import 'package:gutenberg/core/error/exceptions.dart';
import 'package:gutenberg/core/utils/constants.dart';

abstract class ApiService {
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, dynamic>? queryParameters});
}

class ApiServiceImpl implements ApiService {
  final Dio dio;

  ApiServiceImpl({required this.dio}) {
    dio.options.baseUrl = AppConstants.baseUrl;
    dio.options.connectTimeout = const Duration(seconds: 5);
    dio.options.receiveTimeout = const Duration(seconds: 3);
    dio.options.headers = {'Content-Type': 'application/json'};
  }

  @override
  Future<Map<String, dynamic>> get(String endpoint, {Map<String, dynamic>? queryParameters}) async {
    try {
      final response = await dio.get(
        endpoint,
        queryParameters: queryParameters,
      );
      return response.data as Map<String, dynamic>;

    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final message = e.message ?? 'An unknown error occurred.';
      throw ServerException(message: 'Server Error ($statusCode): $message');
    } catch (e) {
      throw ServerException(message: 'An unexpected error occurred.');
    }
  }
}
