import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sports_field_app/data/clients/auth_dio.dart';

/// Para endpoints que requieren autenticación (token)
final authDioProvider = Provider<AuthDio>((ref) {
  final storage = const FlutterSecureStorage();
  return AuthDio(storage, baseUrl: 'http://10.0.2.2:3000');
});

/// Para endpoints públicos (sin token), por ejemplo: login
final dioProvider = Provider<Dio>((ref) {
  return Dio(BaseOptions(baseUrl: 'http://10.0.2.2:3000'));
});

/// Para el almacenamiento seguro (token, tipo usuario, etc.)
final storageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});
