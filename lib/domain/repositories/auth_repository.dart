import 'package:sports_field_app/data/models/login_request_model.dart';

abstract class AuthRepository {
  Future<void> login(LoginRequestModel data, String tipoUsuario);
  Future<String?> getUserId();
  Future<String?> getToken();
  Future<String?> getTipoUsuario();
  Future<void> logout();
}
