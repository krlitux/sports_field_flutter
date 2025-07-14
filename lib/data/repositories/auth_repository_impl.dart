import 'package:dio/dio.dart';
import 'package:sports_field_app/data/models/login_request_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AuthRepository {
  final Dio _dio;
  final FlutterSecureStorage _storage;

  AuthRepository(this._dio, this._storage);

  Future<void> login(LoginRequestModel data, String tipoUsuario) async {
    final endpoint = tipoUsuario == 'jugador'
        ? '/api/usuarios/login'
        : '/api/proveedores/login';

    final response = await _dio.post(endpoint, data: data.toJson());
    final token = response.data['token'];

    // Detección automática según endpoint
    final tipo = endpoint.contains('proveedores') ? 'proveedor' : 'jugador';

    await _storage.write(key: 'jwt', value: token);
    //await _storage.write(key: 'tipo_usuario', value: tipoUsuario); // 👈 nuevo
    await _storage.write(key: 'tipo_usuario', value: tipo);
  }

  Future<String?> getUserId() async {
    final token = await getToken();
    if (token == null || JwtDecoder.isExpired(token)) return null;

    final payload = JwtDecoder.decode(token);
    return payload['id']?.toString();
  }

  Future<String?> getToken() => _storage.read(key: 'jwt');
  Future<String?> getTipoUsuario() => _storage.read(key: 'tipo_usuario');
  Future<void> logout() async {
    await _storage.deleteAll();
  }

}
