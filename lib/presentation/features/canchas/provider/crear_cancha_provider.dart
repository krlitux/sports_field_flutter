import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/entities/cancha.dart';
import 'package:sports_field_app/domain/usecases/canchas/crear_cancha.dart';
import 'package:sports_field_app/presentation/providers/cancha_repository_provider.dart';

final crearCanchaUseCaseProvider = Provider<CrearCancha>((ref) {
  final repo = ref.read(canchaRepositoryProvider);
  return CrearCancha(repo);
});
