import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/data/repositories/cancha_repository.dart';
import 'auth_provider.dart';

final canchaRepositoryProvider = FutureProvider<CanchaRepository>((ref) async {
  final dio = await ref.watch(dioAuthProvider.future);
  return CanchaRepository(dio);
});

final canchasDisponiblesProvider = FutureProvider<List<CanchaModel>>((ref) async {
  final repo = await ref.watch(canchaRepositoryProvider.future);
  return repo.obtenerCanchasDisponibles();
});
