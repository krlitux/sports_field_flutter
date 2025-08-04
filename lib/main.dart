import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sports_field_app/presentation/features/auth/pages/login_page.dart';
import 'package:sports_field_app/presentation/pages/jugador_home_page.dart';
import 'package:sports_field_app/presentation/pages/proveedor_home_page.dart';
import 'package:sports_field_app/presentation/features/auth/provider/auth_repository_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);

    return FutureBuilder<String?>(
      future: authRepo.getToken(),
      builder: (context, snapshot) {
        // Mientras carga el token
        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }

        final token = snapshot.data;
        final homeWidget = _determineHomeFromToken(token);

        return MaterialApp( home: homeWidget );
      },
    );
  }

  Widget _determineHomeFromToken(String? token) {
    if (token == null || token.isEmpty || JwtDecoder.isExpired(token)) {
      return const LoginPage();
    }

    final payload = JwtDecoder.decode(token);
    final rol = payload['rol'];

    switch (rol) {
      case 'jugador':
        return const JugadorHomePage();
      case 'proveedor':
        return const ProveedorHomePage();
      default:
        return const LoginPage();
    }
  }
}
