import 'package:sports_field_app/data/clients/auth_dio.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/data/models/cancha_request_model.dart';

class CanchaRepository {
  final AuthDio _authDio;

  CanchaRepository(this._authDio);

  Future<List<CanchaModel>> listarCanchas() async {
    final dio = await _authDio.client;
    final resp = await dio.get('/api/canchas/disponibles');
    final list = resp.data as List;
    return list.map((e) => CanchaModel.fromJson(e)).toList();
  }

  Future<void> crearCancha(CanchaRequestModel cancha) async {
    final dio = await _authDio.client;
    await dio.post('/api/canchas', data: cancha.toJson());
  }
}
