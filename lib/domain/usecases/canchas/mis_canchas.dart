import 'package:sports_field_app/domain/entities/cancha.dart';
import 'package:sports_field_app/domain/repositories/cancha_repository.dart';

class MisCanchas {
  final CanchaRepository repository;

  MisCanchas(this.repository);

  Future<List<Cancha>> call() {
    return repository.misCanchas();
  }
}
