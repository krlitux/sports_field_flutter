import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/usecases/reservas/cancelar_reserva_usecase.dart';
import 'package:sports_field_app/domain/usecases/reservas/obtener_mis_reservas_usecase.dart';
import 'package:sports_field_app/domain/entities/reserva.dart';

class MisReservasNotifier extends AsyncNotifier<List<Reserva>> {
  late final ObtenerMisReservasUseCase _obtenerMisReservas;
  late final CancelarReservaUseCase _cancelarReserva;

  @override
  Future<List<Reserva>> build() async {
    _obtenerMisReservas = ref.read(obtenerMisReservasUseCaseProvider);
    _cancelarReserva = ref.read(cancelarReservaUseCaseProvider);
    return _obtenerMisReservas();
  }

  Future<void> cancelar(int id) async {
    await _cancelarReserva(id);
    state = const AsyncValue.loading();
    final actualizadas = await _obtenerMisReservas();
    state = AsyncValue.data(actualizadas);
  }
}

final misReservasProvider =
AsyncNotifierProvider<MisReservasNotifier, List<Reserva>>(
        () => MisReservasNotifier());
