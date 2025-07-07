import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthDio {
  final FlutterSecureStorage _storage;
  final String baseUrl;
  AuthDio(this._storage, {this.baseUrl = 'http://10.0.2.2:3000'});

  Future<Dio> get client async {
    final token = await _storage.read(key: 'jwt');
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    if (token != null && token.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return dio;
  }
}
