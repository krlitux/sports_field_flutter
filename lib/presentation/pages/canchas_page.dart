import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/presentation/pages/reserva_form_page.dart';
import 'package:sports_field_app/presentation/providers/cancha_provider.dart';

class CanchasPage extends ConsumerWidget {
  const CanchasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canchasAsync = ref.watch(canchasDisponiblesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Explorar canchas'),
      ),
      body: canchasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (canchas) {
          if (canchas.isEmpty) {
            return const Center(child: Text('No hay canchas disponibles.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemCount: canchas.length,
            itemBuilder: (context, i) {
              final cancha = canchas[i];
              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(cancha.nombre, style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text('Tipo: ${cancha.tipo}', style: const TextStyle(color: Colors.grey)),
                      Text('Dirección: ${cancha.direccion}', style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text('\$${cancha.precio.toStringAsFixed(2)} por hora',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => ReservaFormPage(cancha: cancha),
                              ),
                            );
                          },
                          icon: const Icon(Icons.calendar_month_outlined),
                          label: const Text('Reservar cancha'),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            backgroundColor: Colors.green[600],
                          ),
                        ),
                      ),
                    ],
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
