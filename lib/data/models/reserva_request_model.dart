class ReservaRequestModel {
  final int usuario_id;
  final int cancha_id;
  final String fecha;
  final String hora_inicio;
  final String hora_fin;

  ReservaRequestModel({
    required this.usuario_id,
    required this.cancha_id,
    required this.fecha,
    required this.hora_inicio,
    required this.hora_fin,
  });

  Map<String, dynamic> toJson() => {
    'usuario_id': usuario_id,
    'cancha_id': cancha_id,
    'fecha': fecha,
    'hora_inicio': hora_inicio,
    'hora_fin': hora_fin,
  };
}
