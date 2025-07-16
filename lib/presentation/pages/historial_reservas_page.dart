import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/providers/reserva_jugador_provider.dart';

class HistorialReservasPage extends ConsumerWidget {
  const HistorialReservasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservasAsync = ref.watch(misReservasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis reservas'),
      ),
      body: reservasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (reservas) {
          if (reservas.isEmpty) {
            return const Center(child: Text('Aún no hiciste ninguna reserva.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reservas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, i) {
              final r = reservas[i];
              final f = r.fecha.split('T').first.split('-').reversed.join('/');
              final hInicio = r.horaInicio;
              final hFin = r.horaFin;

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(r.cancha.nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text('📅 $f'),
                      Text('🕒 $hInicio - $hFin'),
                      Text('📍 ${r.cancha.direccion}', style: const TextStyle(color: Colors.grey)),
                      const SizedBox(height: 10),
                      ElevatedButton.icon(
                        onPressed: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Cancelar reserva'),
                              content: const Text('¿Estás seguro de cancelar esta reserva?'),
                              actions: [
                                TextButton(onPressed: () => Navigator.pop(ctx, false), child: const Text('No')),
                                TextButton(onPressed: () => Navigator.pop(ctx, true), child: const Text('Sí')),
                              ],
                            ),
                          );

                          if (confirm != true) return;

                          final notifier = ref.read(misReservasProvider.notifier);
                          await notifier.cancelarReserva(r.id);
                        },
                        icon: const Icon(Icons.cancel_outlined),
                        label: const Text('Cancelar'),
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.red[600]),
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
