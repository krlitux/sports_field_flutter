import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/clients/providers.dart';
import 'package:sports_field_app/data/repositories/reserva_repository.dart';
import 'package:sports_field_app/domain/repositories/reserva_repository.dart';

final reservaRepositoryProvider = Provider<ReservaRepository>((ref) {
  final authDio = ref.read(authDioProvider); // este SÍ necesita token
  return ReservaRepositoryImpl(authDio);
});
