import 'package:flutter/material.dart';
import 'package:sports_field_app/presentation/pages/canchas_page.dart';
import 'package:sports_field_app/presentation/pages/login_page.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'crear_cancha_page.dart';
import 'historial_reservas_page.dart';
import 'mis_canchas_pages.dart';

class HomePage extends ConsumerWidget {

  final String tipoUsuario;

  const HomePage({super.key, required this.tipoUsuario});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bienvenido, $tipoUsuario 👋',
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(height: 20),

            if (tipoUsuario == 'jugador') ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CanchasPage()),
                  );
                },
                child: const Text('Explorar canchas'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const HistorialReservasPage()),
                  );
                },
                child: const Text('Ver mis reservas'),
              ),
            ],

            if (tipoUsuario == 'proveedor') ...[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CrearCanchaPage()),
                  );
                },
                child: const Text('Crear nueva cancha'),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MisCanchasPage()),
                  );
                },
                child: const Text('Ver mis canchas'),
              ),
            ],

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () async {
                final authRepo = ref.read(authRepositoryProvider);
                await authRepo.logout();

                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginPage()),
                      (route) => false,
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
