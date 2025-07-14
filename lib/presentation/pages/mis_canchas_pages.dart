import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/pages/editar_cancha_page.dart';
import 'package:sports_field_app/presentation/providers/cancha_provider.dart';

class MisCanchasPage extends ConsumerWidget {
  const MisCanchasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canchasAsync = ref.watch(misCanchasProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis canchas')),
      body: canchasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (canchas) {
          if (canchas.isEmpty) {
            return const Center(child: Text('Aún no tienes canchas registradas.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: canchas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, i) {
              final c = canchas[i];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(c.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text('📍 ${c.direccion}'),
                      Text('🟢 Tipo: ${c.tipo}'),
                      Text('💰 Precio: S/ ${c.precio.toStringAsFixed(2)}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EditarCanchaPage(cancha: c),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
