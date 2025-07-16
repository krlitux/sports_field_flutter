import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/reserva_model.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';

final reservasProveedorProvider = FutureProvider<List<ReservaModel>>((ref) async {
  final repo = ref.read(reservaRepositoryProvider);
  return repo.obtenerReservasProveedor();
});
