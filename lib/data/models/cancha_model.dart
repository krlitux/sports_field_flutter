class CanchaModel {
  final int id;
  final String nombre;
  final String direccion;
  final String tipo;
  final double precio;

  CanchaModel({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.tipo,
    required this.precio,
  });

  factory CanchaModel.fromJson(Map<String, dynamic> json) {
    return CanchaModel(
      id: json['id'],
      nombre: json['nombre'],
      direccion: json['direccion'],
      tipo: json['tipo'],
      precio: double.parse(json['precio'].toString()),
    );
  }
}
