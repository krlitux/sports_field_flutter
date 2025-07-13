import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';
import 'auth_provider.dart';

final reservasProveedorProvider = FutureProvider<List<ReservaModel>>((ref) async {
  final authDio = ref.read(authDioProvider);
  final dio = await authDio.client;

  final response = await dio.get('/api/reservas/por-proveedor');
  final data = response.data as List;

  return data.map((e) => ReservaModel.fromJson(e)).toList();
});
