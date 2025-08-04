import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/repositories/reserva_repository.dart';
import 'package:sports_field_app/presentation/providers/reserva_repository_provider.dart';

class CancelarReservaUseCase {
  final ReservaRepository _repository;

  CancelarReservaUseCase(this._repository);

  Future<void> call(int id) {
    return _repository.cancelarReserva(id);
  }
}

// Este es el provider que debes importar desde el Notifier
final cancelarReservaUseCaseProvider = Provider<CancelarReservaUseCase>((ref) {
  final repo = ref.read(reservaRepositoryProvider);
  return CancelarReservaUseCase(repo);
});
