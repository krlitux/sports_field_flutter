class ReservaModel {
  final int id;
  final String fecha;
  final String horaInicio;
  final String horaFin;
  final String canchaNombre;

  ReservaModel({
    required this.id,
    required this.fecha,
    required this.horaInicio,
    required this.horaFin,
    required this.canchaNombre,
  });

  factory ReservaModel.fromJson(Map<String, dynamic> json) {
    String limpiarHora(String valor) {
      // Si viene como "1970-01-01T18:00:00.000Z", extraer solo la parte "18:00"
      final timeMatch = RegExp(r'T(\d{2}:\d{2})').firstMatch(valor);
      return timeMatch != null ? timeMatch.group(1)! : valor;
    }

    return ReservaModel(
      id: json['id'],
      fecha: json['fecha'],
      horaInicio: limpiarHora(json['hora_inicio']),
      horaFin: limpiarHora(json['hora_fin']),
      canchaNombre: json['cancha']?['nombre'] ?? 'Desconocida',
    );
  }
}
