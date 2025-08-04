import 'package:sports_field_app/data/clients/auth_dio.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';
import 'package:sports_field_app/domain/entities/reserva.dart';
import 'package:sports_field_app/domain/repositories/reserva_repository.dart';

class ReservaRepositoryImpl implements ReservaRepository {
  final AuthDio _authDio;

  ReservaRepositoryImpl(this._authDio);

  @override
  Future<void> crearReserva(ReservaRequestModel reserva) async {
    final dio = await _authDio.client;
    await dio.post('/api/reservas', data: reserva.toJson());
  }

  @override
  Future<List<Reserva>> obtenerMisReservas() async {
    final dio = await _authDio.client;
    final resp = await dio.get('/api/reservas/mis-reservas');
    final list = resp.data as List;

    return list.map((json) {
      final model = ReservaModel.fromJson(json);
      return Reserva(
        id: model.id,
        usuarioId: model.usuarioId,
        canchaId: model.canchaId,
        fecha: model.fecha,
        horaInicio: model.horaInicio,
        horaFin: model.horaFin,
        nombreUsuario: model.usuario?.nombre,
        nombreCancha: model.cancha.nombre,
        direccionCancha: model.cancha.direccion,
      );
    }).toList();
  }

  @override
  Future<void> cancelarReserva(int id) async {
    final dio = await _authDio.client;
    await dio.delete('/api/reservas/$id');
  }

  @override
  Future<List<Reserva>> obtenerReservasProveedor() async {
    final dio = await _authDio.client;
    final resp = await dio.get('/api/reservas/por-proveedor');
    final list = resp.data as List;

    return list.map((json) {
      final model = ReservaModel.fromJson(json);
      return Reserva(
        id: model.id,
        usuarioId: model.usuarioId,
        canchaId: model.canchaId,
        fecha: model.fecha,
        horaInicio: model.horaInicio,
        horaFin: model.horaFin,
        nombreCancha: model.cancha.nombre,
        direccionCancha: model.cancha.direccion,
        nombreUsuario: model.usuario?.nombre,
      );
    }).toList();
  }

}
