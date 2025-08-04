//Define la lógica para crear una reserva
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/entities/reserva.dart';
import 'package:sports_field_app/domain/repositories/reserva_repository.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';
import 'package:sports_field_app/presentation/providers/reserva_repository_provider.dart';

class CrearReservaUseCase {
  final ReservaRepository _repository;

  CrearReservaUseCase(this._repository);

  Future<void> call(Reserva reserva) {
    final model = ReservaRequestModel(
      usuario_id: reserva.usuarioId,
      cancha_id: reserva.canchaId,
      fecha: reserva.fecha,
      hora_inicio: reserva.horaInicio,
      hora_fin: reserva.horaFin,
    );
    return _repository.crearReserva(model);
  }
}

final crearReservaUseCaseProvider = Provider<CrearReservaUseCase>((ref) {
  final repo = ref.read(reservaRepositoryProvider);
  return CrearReservaUseCase(repo);
});
