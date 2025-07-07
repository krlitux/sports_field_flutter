import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'auth_provider.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';
import 'package:sports_field_app/data/clients/auth_dio.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';

final misReservasProvider = FutureProvider<List<ReservaModel>>((ref) async {
  final repo = ref.read(reservaRepositoryProvider);
  return repo.obtenerMisReservas();
});

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
}
