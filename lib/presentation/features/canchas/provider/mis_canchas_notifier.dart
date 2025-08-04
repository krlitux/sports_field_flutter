import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/entities/cancha.dart';
import 'package:sports_field_app/domain/usecases/canchas/get_mis_canchas.dart';
import 'package:sports_field_app/domain/usecases/canchas/crear_cancha.dart';
import 'package:sports_field_app/domain/usecases/canchas/editar_cancha.dart';
import 'package:sports_field_app/presentation/features/canchas/provider/get_mis_canchas_provider.dart';
import 'package:sports_field_app/presentation/features/canchas/provider/crear_cancha_provider.dart';
import 'package:sports_field_app/presentation/features/canchas/provider/editar_cancha_provider.dart';

class MisCanchasNotifier extends AsyncNotifier<List<Cancha>> {
  late final GetMisCanchas _getMisCanchas;
  late final CrearCancha _crearCancha;
  late final EditarCancha _editarCancha;

  @override
  Future<List<Cancha>> build() async {
    _getMisCanchas = ref.read(getMisCanchasProvider);
    _crearCancha = ref.read(crearCanchaUseCaseProvider);
    _editarCancha = ref.read(editarCanchaUseCaseProvider);
    return _getMisCanchas();
  }

  Future<void> crear(Cancha cancha) async {
    await _crearCancha(cancha);
    state = const AsyncValue.loading();
    final actualizadas = await _getMisCanchas();
    state = AsyncValue.data(actualizadas);
  }

  Future<void> editar(int id, Cancha cancha) async {
    await _editarCancha(id, cancha);
    state = const AsyncValue.loading();
    final actualizadas = await _getMisCanchas();
    state = AsyncValue.data(actualizadas);
  }
}

final misCanchasProvider =
AsyncNotifierProvider<MisCanchasNotifier, List<Cancha>>(
        () => MisCanchasNotifier());
