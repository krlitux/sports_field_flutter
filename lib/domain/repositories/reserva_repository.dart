//Interfaz para el repositorio de reservas
import 'package:sports_field_app/domain/entities/reserva.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';

abstract class ReservaRepository {
  Future<List<Reserva>> obtenerMisReservas();
  Future<void> cancelarReserva(int id);
  Future<void> crearReserva(ReservaRequestModel reserva);
  Future<List<Reserva>> obtenerReservasProveedor();
}
