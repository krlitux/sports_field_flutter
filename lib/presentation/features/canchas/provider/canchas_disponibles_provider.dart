import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/usecases/canchas/listar_canchas.dart';
import 'package:sports_field_app/presentation/providers/cancha_repository_provider.dart';
import 'package:sports_field_app/domain/entities/cancha.dart';

final listarCanchasUseCaseProvider = Provider<ListarCanchas>((ref) {
  final repo = ref.read(canchaRepositoryProvider);
  return ListarCanchas(repo);
});

final canchasDisponiblesProvider = FutureProvider<List<Cancha>>((ref) {
  final useCase = ref.watch(listarCanchasUseCaseProvider);
  return useCase();
});
