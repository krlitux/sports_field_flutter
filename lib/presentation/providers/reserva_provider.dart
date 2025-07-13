import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/reserva_repository.dart';
import 'auth_provider.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';

class MisReservasNotifier extends AsyncNotifier<List<ReservaModel>> {
  late final ReservaRepository _repo;

  @override
  Future<List<ReservaModel>> build() async {
    _repo = ref.read(reservaRepositoryProvider);
    return _repo.obtenerMisReservas();
  }

  Future<void> cancelarReserva(int id) async {
    await _repo.cancelarReserva(id);
    state = AsyncValue.loading();
    final nuevas = await _repo.obtenerMisReservas();
    state = AsyncValue.data(nuevas);
  }
}

final misReservasProvider =
AsyncNotifierProvider<MisReservasNotifier, List<ReservaModel>>(() => MisReservasNotifier());

