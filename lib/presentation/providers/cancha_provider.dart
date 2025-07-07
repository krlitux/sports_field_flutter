import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';

final canchasDisponiblesProvider = FutureProvider<List<CanchaModel>>((ref) async {
  final repo = ref.read(canchaRepositoryProvider);
  return repo.listarCanchas();
});
