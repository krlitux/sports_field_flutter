class CanchaRequestModel {
  final String nombre;
  final String direccion;
  final String tipo;
  final double precio;

  CanchaRequestModel({
    required this.nombre,
    required this.direccion,
    required this.tipo,
    required this.precio,
  });

  Map<String, dynamic> toJson() => {
    'nombre': nombre,
    'direccion': direccion,
    'tipo': tipo,
    'precio': precio,
  };
}
