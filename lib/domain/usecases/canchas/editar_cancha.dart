import 'package:sports_field_app/domain/entities/cancha.dart';
import 'package:sports_field_app/domain/repositories/cancha_repository.dart';

class EditarCancha {
  final CanchaRepository repository;

  EditarCancha(this.repository);

  Future<void> call(int id, Cancha cancha) {
    return repository.editarCancha(id, cancha);
  }
}
