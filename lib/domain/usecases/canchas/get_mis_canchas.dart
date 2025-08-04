import 'package:sports_field_app/domain/entities/cancha.dart';
import 'package:sports_field_app/domain/repositories/cancha_repository.dart';

class GetMisCanchas {
  final CanchaRepository repository;

  GetMisCanchas(this.repository);

  Future<List<Cancha>> call() {
    return repository.misCanchas();
  }
}
