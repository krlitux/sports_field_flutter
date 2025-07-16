import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/data/models/cancha_request_model.dart';
import 'package:sports_field_app/data/repositories/cancha_repository.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';

final canchasDisponiblesProvider = FutureProvider<List<CanchaModel>>((ref) async {
  final repo = ref.read(canchaRepositoryProvider);
  return repo.listarCanchas();
});

class MisCanchasNotifier extends AsyncNotifier<List<CanchaModel>> {
  late final CanchaRepository _repo;

  @override
  Future<List<CanchaModel>> build() async {
    _repo = ref.read(canchaRepositoryProvider);
    return _repo.misCanchas();
  }

  Future<void> crearCancha(CanchaRequestModel cancha) async {
    await _repo.crearCancha(cancha);
    state = AsyncValue.data(await _repo.misCanchas());
  }

  Future<void> editarCancha(int id, CanchaRequestModel cancha) async {
    await _repo.editarCancha(id, cancha);
    state = AsyncValue.data(await _repo.misCanchas());
  }
}

final misCanchasProvider = AsyncNotifierProvider<MisCanchasNotifier, List<CanchaModel>>(
      () => MisCanchasNotifier(),
);
