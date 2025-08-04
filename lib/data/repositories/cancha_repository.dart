import 'package:sports_field_app/data/clients/auth_dio.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/data/models/cancha_request_model.dart';
import 'package:sports_field_app/domain/entities/cancha.dart';
import 'package:sports_field_app/domain/repositories/cancha_repository.dart';

class CanchaRepositoryImpl implements CanchaRepository {
  final AuthDio _authDio;

  CanchaRepositoryImpl(this._authDio);

  @override
  Future<List<Cancha>> listarCanchas() async {
    final dio = await _authDio.client;
    final resp = await dio.get('/api/canchas/disponibles');
    final data = resp.data as List;

    return data.map((e) {
      final model = CanchaModel.fromJson(e);
      return Cancha(
        id: model.id,
        nombre: model.nombre,
        direccion: model.direccion,
        precio: model.precio,
        tipo: model.tipo,
      );
    }).toList();
  }

  @override
  Future<List<Cancha>> misCanchas() async {
    final dio = await _authDio.client;
    final resp = await dio.get('/api/canchas/mis-canchas');
    final data = resp.data as List;

    return data.map((e) {
      final model = CanchaModel.fromJson(e);
      return Cancha(
        id: model.id,
        nombre: model.nombre,
        direccion: model.direccion,
        precio: model.precio,
        tipo: model.tipo,
      );
    }).toList();
  }

  @override
  Future<void> crearCancha(Cancha cancha) async {
    final dio = await _authDio.client;
    final data = CanchaRequestModel(
      nombre: cancha.nombre,
      direccion: cancha.direccion,
      tipo: cancha.tipo,
      precio: cancha.precio,
    );
    await dio.post('/api/canchas', data: data.toJson());
  }

  @override
  Future<void> editarCancha(int id, Cancha cancha) async {
    final dio = await _authDio.client;
    final data = CanchaRequestModel(
      nombre: cancha.nombre,
      direccion: cancha.direccion,
      tipo: cancha.tipo,
      precio: cancha.precio,
    );
    await dio.put('/api/canchas/$id', data: data.toJson());
  }
}
