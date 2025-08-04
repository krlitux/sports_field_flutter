import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/usecases/reservas/get_reservas_recibidas.dart';
import 'package:sports_field_app/presentation/providers/reserva_repository_provider.dart';

final getReservasRecibidasProvider = Provider<GetReservasRecibidas>((ref) {
  final repo = ref.read(reservaRepositoryProvider);
  return GetReservasRecibidas(repo);
});

