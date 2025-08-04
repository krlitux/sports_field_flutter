import 'package:flutter/material.dart';
import 'package:sports_field_app/presentation/pages/canchas_page.dart';
import 'package:sports_field_app/presentation/features/reservas/pages/mis_reservas_page.dart';
import 'package:sports_field_app/presentation/features/auth/pages/login_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/features/auth/provider/auth_repository_provider.dart';

class JugadorHomePage extends ConsumerWidget {
  const JugadorHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio - Jugador')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenido, jugador 👋', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CanchasPage())),
              child: const Text('Explorar canchas'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MisReservasPage())),
              child: const Text('Ver mis reservas'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authRepositoryProvider).logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                      (_) => false,
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cerrar sesión'),
            ),
          ],
        ),
      ),
    );
  }
}
