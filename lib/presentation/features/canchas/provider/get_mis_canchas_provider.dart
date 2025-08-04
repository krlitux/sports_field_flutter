import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/usecases/canchas/get_mis_canchas.dart';
import 'package:sports_field_app/presentation/providers/cancha_repository_provider.dart';

final getMisCanchasProvider = Provider<GetMisCanchas>((ref) {
  final repo = ref.read(canchaRepositoryProvider);
  return GetMisCanchas(repo);
});
