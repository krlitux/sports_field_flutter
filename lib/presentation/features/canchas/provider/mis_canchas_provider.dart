import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/domain/usecases/canchas/mis_canchas.dart';
import 'package:sports_field_app/presentation/providers/cancha_repository_provider.dart';
import 'package:sports_field_app/domain/entities/cancha.dart';

final misCanchasUseCaseProvider = Provider<MisCanchas>((ref) {
  final repo = ref.watch(canchaRepositoryProvider);
  return MisCanchas(repo);
});

class MisCanchasNotifier extends AsyncNotifier<List<Cancha>> {
  late final MisCanchas _useCase;

  @override
  Future<List<Cancha>> build() async {
    _useCase = ref.read(misCanchasUseCaseProvider);
    return _useCase();
  }
}

final misCanchasProvider = AsyncNotifierProvider<MisCanchasNotifier, List<Cancha>>(
      () => MisCanchasNotifier(),
);
