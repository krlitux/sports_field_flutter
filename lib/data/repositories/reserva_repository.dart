import 'package:sports_field_app/data/clients/auth_dio.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';

class ReservaRepository {
  final AuthDio _authDio;

  ReservaRepository(this._authDio);

  Future<void> reservar(ReservaRequestModel reserva) async {
    final dio = await _authDio.client;
    await dio.post('/api/reservas', data: reserva.toJson());
  }

  Future<List<ReservaModel>> obtenerMisReservas() async {
    final dio = await _authDio.client;
    final resp = await dio.get('/api/reservas/mis-reservas');
    final list = resp.data as List;
    return list.map((e) => ReservaModel.fromJson(e)).toList();
  }

  Future<void> cancelarReserva(int id) async {
    final dio = await _authDio.client;
    await dio.delete('/api/reservas/$id');
  }

  Future<List<ReservaModel>> obtenerReservasProveedor() async {
    final dio = await _authDio.client;
    final response = await dio.get('/api/reservas/por-proveedor');
    final data = response.data as List;
    return data.map((e) => ReservaModel.fromJson(e)).toList();
  }

}
