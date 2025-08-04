import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/pages/crear_cancha_page.dart';
import 'package:sports_field_app/presentation/pages/mis_canchas_pages.dart';
import 'package:sports_field_app/presentation/features/reservas/pages/reservas_recibidas_page.dart';
import 'package:sports_field_app/presentation/features/auth/pages/login_page.dart';
import 'package:sports_field_app/presentation/features/auth/provider/auth_repository_provider.dart';

class ProveedorHomePage extends ConsumerWidget {
  const ProveedorHomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('Screen: Proveedor');
    return Scaffold(
      appBar: AppBar(title: const Text('Inicio - Proveedor')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bienvenido, proveedor 👋', style: TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const CrearCanchaPage())),
              child: const Text('Crear nueva cancha'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const MisCanchasPage())),
              child: const Text('Ver mis canchas'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ReservasProveedorPage())),
              child: const Text('Ver reservas'),
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
