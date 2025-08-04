import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/usecases/canchas/editar_cancha.dart';
import 'package:sports_field_app/presentation/providers/cancha_repository_provider.dart';

final editarCanchaUseCaseProvider = Provider<EditarCancha>((ref) {
  final repo = ref.read(canchaRepositoryProvider);
  return EditarCancha(repo);
});
