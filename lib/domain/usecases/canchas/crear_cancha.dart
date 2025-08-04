import 'package:sports_field_app/domain/entities/cancha.dart';
import 'package:sports_field_app/domain/repositories/cancha_repository.dart';

class CrearCancha {
  final CanchaRepository repository;

  CrearCancha(this.repository);

  Future<void> call(Cancha cancha) {
    return repository.crearCancha(cancha);
  }
}
