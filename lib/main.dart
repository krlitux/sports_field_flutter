import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/pages/home_page.dart';
import 'package:sports_field_app/presentation/pages/login_page.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepo = ref.read(authRepositoryProvider);

    return FutureBuilder(
      future: authRepo.getToken(),
      builder: (context, snapshot) {
        //print('📦 Snapshot state: ${snapshot.connectionState}');
        //print('📦 Snapshot data: ${snapshot.data}');
        //print('📦 Snapshot error: ${snapshot.error}');

        if (snapshot.connectionState != ConnectionState.done) {
          return const MaterialApp(
            home: Scaffold(body: Center(child: CircularProgressIndicator())),
          );
        }

        final token = snapshot.data as String?;

        if (token != null && token.isNotEmpty && !JwtDecoder.isExpired(token)) {
          final payload = JwtDecoder.decode(token);
          final tipo = payload['rol'] ?? 'desconocido';

          //print('✅ Usuario autenticado como: $tipo');
          return MaterialApp(home: HomePage(tipoUsuario: tipo));
        }

        //print('⚠️ Token no válido, se redirige a login.');
        return const MaterialApp(home: LoginPage());
      },
    );
  }
}
