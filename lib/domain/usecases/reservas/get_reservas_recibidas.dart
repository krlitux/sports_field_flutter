import 'package:sports_field_app/domain/entities/reserva.dart';
import 'package:sports_field_app/domain/repositories/reserva_repository.dart';

class GetReservasRecibidas {
  final ReservaRepository repository;

  GetReservasRecibidas(this.repository);

  Future<List<Reserva>> call() {
    return repository.obtenerReservasProveedor();
  }
}
