import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/providers/cancha_provider.dart';
import 'cancha_detalle_page.dart';

class CanchasPage extends ConsumerWidget {
  const CanchasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canchasAsync = ref.watch(canchasDisponiblesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Canchas disponibles')),
      body: canchasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning_amber_rounded, size: 64, color: Colors.red),
              const SizedBox(height: 12),
              Text(
                'No se pudo cargar la lista de canchas.\n¿Estás conectado a internet?',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => ref.refresh(canchasDisponiblesProvider),
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
        data: (canchas) => ListView.builder(
          itemCount: canchas.length,
          itemBuilder: (context, index) {
            final cancha = canchas[index];
            return Card(
              margin: const EdgeInsets.all(8),
              child: ListTile(
                title: Text(cancha.nombre),
                subtitle: Text('${cancha.tipo} - \$${cancha.precio.toStringAsFixed(2)}'),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => CanchaDetallePage(cancha: cancha),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
