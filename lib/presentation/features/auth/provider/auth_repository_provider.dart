import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/clients/providers.dart';
import 'package:sports_field_app/data/repositories/auth_repository_impl.dart';
import 'package:sports_field_app/domain/repositories/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final dio = ref.read(dioProvider); // login no necesita token
  final storage = ref.read(storageProvider);
  return AuthRepositoryImpl(dio, storage);
});
