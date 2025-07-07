import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/repositories/reserva_repository.dart';
import 'auth_provider.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';

final reservaRepositoryProvider = FutureProvider<ReservaRepository>((ref) async {
  final dio = await ref.watch(dioAuthProvider.future);
  return ReservaRepository(dio);
});

final misReservasProvider = FutureProvider<List<ReservaModel>>((ref) async {
  final repo = await ref.watch(reservaRepositoryProvider.future);
  return repo.obtenerMisReservas();
});
