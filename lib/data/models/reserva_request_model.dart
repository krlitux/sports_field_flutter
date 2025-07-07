class ReservaRequestModel {
  final int canchaId;
  final String fecha;
  final String horaInicio;
  final String horaFin;

  ReservaRequestModel({
    required this.canchaId,
    required this.fecha,
    required this.horaInicio,
    required this.horaFin,
  });

  Map<String, dynamic> toJson() => {
    'cancha_id': canchaId,
    'fecha': fecha,
    'hora_inicio': horaInicio,
    'hora_fin': horaFin,
  };
}
