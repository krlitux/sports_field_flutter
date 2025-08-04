import 'package:sports_field_app/domain/entities/cancha.dart';

abstract class CanchaRepository {
  Future<List<Cancha>> listarCanchas();
  Future<List<Cancha>> misCanchas();
  Future<void> crearCancha(Cancha cancha);
  Future<void> editarCancha(int id, Cancha cancha);
}
