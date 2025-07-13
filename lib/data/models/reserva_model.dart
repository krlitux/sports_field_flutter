class ReservaModel {
  final int id;
  final String fecha;
  final String horaInicio;
  final String horaFin;
  final CanchaResumenModel cancha;
  final UsuarioResumenModel? usuario;

  ReservaModel({
    required this.id,
    required this.fecha,
    required this.horaInicio,
    required this.horaFin,
    required this.cancha,
    this.usuario,
  });

  factory ReservaModel.fromJson(Map<String, dynamic> json) {
    return ReservaModel(
      id: json['id'] ?? 0,
      fecha: json['fecha'],
      horaInicio: json['hora_inicio'],
      horaFin: json['hora_fin'],
      cancha: json['cancha'] != null
          ? CanchaResumenModel.fromJson(json['cancha'])
          : CanchaResumenModel(nombre: '[Nombre no disponible]', direccion: '-'),
      usuario: (json.containsKey('usuario') && json['usuario'] != null)
          ? UsuarioResumenModel.fromJson(json['usuario'])
          : null,
    );
  }
}

class CanchaResumenModel {
  final String nombre;
  final String direccion;

  CanchaResumenModel({
    required this.nombre,
    required this.direccion,
  });

  factory CanchaResumenModel.fromJson(Map<String, dynamic> json) {
    return CanchaResumenModel(
      nombre: json['nombre'],
      direccion: json['direccion'],
    );
  }
}

class UsuarioResumenModel {
  final String nombre;

  UsuarioResumenModel({required this.nombre});

  factory UsuarioResumenModel.fromJson(Map<String, dynamic> json) {
    return UsuarioResumenModel(nombre: json['nombre']);
  }
}
