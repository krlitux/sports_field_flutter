import 'package:dio/dio.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/data/models/cancha_request_model.dart';

class CanchaRepository {
  final Dio _dio;

  CanchaRepository(this._dio);

  Future<List<CanchaModel>> obtenerCanchasDisponibles() async {
    final response = await _dio.get('/api/canchas/disponibles');
    final data = response.data as List;

    return data.map((json) => CanchaModel.fromJson(json)).toList();
  }

  Future<void> crearCancha(CanchaRequestModel cancha) async {
    await _dio.post('/api/canchas', data: cancha.toJson());
  }

}
