import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/clients/providers.dart';
import 'package:sports_field_app/data/repositories/cancha_repository.dart';
import 'package:sports_field_app/domain/repositories/cancha_repository.dart';

final canchaRepositoryProvider = Provider<CanchaRepository>((ref) {
  final authDio = ref.read(authDioProvider);
  return CanchaRepositoryImpl(authDio);
});
