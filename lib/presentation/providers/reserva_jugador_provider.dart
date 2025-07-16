import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/repositories/reserva_repository.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';

class MisReservasNotifier extends AsyncNotifier<List<ReservaModel>> {
  late final ReservaRepository _repo;

  @override
  Future<List<ReservaModel>> build() async {
    _repo = ref.read(reservaRepositoryProvider);
    return _repo.obtenerMisReservas();
  }

  Future<void> cancelarReserva(int id) async {
    await _repo.cancelarReserva(id);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _repo.obtenerMisReservas());
  }

  Future<void> reservar(ReservaRequestModel reserva) async {
    await _repo.reservar(reserva);
    state = const AsyncValue.loading();
    state = AsyncValue.data(await _repo.obtenerMisReservas());
  }
}

final misReservasProvider = AsyncNotifierProvider<MisReservasNotifier, List<ReservaModel>>(
      () => MisReservasNotifier(),
);
