import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/entities/reserva.dart';
import 'package:sports_field_app/domain/repositories/reserva_repository.dart';
import 'package:sports_field_app/presentation/providers/reserva_repository_provider.dart';

class ObtenerMisReservasUseCase {
  final ReservaRepository _repository;

  ObtenerMisReservasUseCase(this._repository);

  Future<List<Reserva>> call() {
    return _repository.obtenerMisReservas();
  }
}

// Este es el provider que debes importar desde el Notifier
final obtenerMisReservasUseCaseProvider = Provider<ObtenerMisReservasUseCase>((ref) {
  final repo = ref.read(reservaRepositoryProvider);
  return ObtenerMisReservasUseCase(repo);
});
