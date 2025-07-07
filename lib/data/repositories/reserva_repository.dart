import 'package:dio/dio.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';


class ReservaRepository {
  final Dio _dio;

  ReservaRepository(this._dio);

  Future<void> crearReserva(ReservaRequestModel reserva) async {
    await _dio.post('/api/reservas', data: reserva.toJson());
  }

  Future<List<ReservaModel>> obtenerMisReservas() async {
    final response = await _dio.get('/api/reservas/mis-reservas');
    final data = response.data as List;
    return data.map((json) => ReservaModel.fromJson(json)).toList();
  }

}
