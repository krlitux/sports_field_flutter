//Entidad principal de reserva
class Reserva {
  final int id;
  final int usuarioId;
  final int canchaId;
  final String fecha;
  final String horaInicio;
  final String horaFin;
  final String? nombreUsuario;
  final String? nombreCancha;
  final String? direccionCancha;

  Reserva({
    required this.id,
    required this.usuarioId,
    required this.canchaId,
    required this.fecha,
    required this.horaInicio,
    required this.horaFin,
    this.nombreUsuario,
    this.nombreCancha,
    this.direccionCancha,
  });
}
