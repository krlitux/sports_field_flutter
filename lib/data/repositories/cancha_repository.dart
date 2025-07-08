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

  Future<List<CanchaModel>> misCanchas() async {
    final dio = await _authDio.client;
    final resp = await dio.get('/api/canchas/mis-canchas');
    final list = resp.data as List;
    return list.map((e) => CanchaModel.fromJson(e)).toList();
  }

  Future<void> editarCancha(int id, CanchaRequestModel cancha) async {
    final dio = await _authDio.client;
    await dio.put('/api/canchas/$id', data: cancha.toJson());
  }

  Future<void> eliminarCancha(int id) async {
    final dio = await _authDio.client;
    await dio.delete('/api/canchas/$id');
  }

}
