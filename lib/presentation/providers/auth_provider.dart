import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:sports_field_app/data/repositories/auth_repository_impl.dart';

final storageProvider = Provider((ref) => const FlutterSecureStorage());

final dioAuthProvider = FutureProvider<Dio>((ref) async {
  final storage = ref.watch(storageProvider);
  final token = await storage.read(key: 'jwt');

  return Dio(BaseOptions(
    baseUrl: 'http://10.0.2.2:3000', // ⚠️ Para Android Emulator
    headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
  ));
});

final authRepositoryProvider = Provider(
      (ref) => AuthRepository(ref.watch(dioAuthProvider).maybeWhen(
    data: (dio) => dio,
    orElse: () => Dio(), // fallback seguro
  ), ref.watch(storageProvider)),
);
