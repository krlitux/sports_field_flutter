import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sports_field_app/presentation/features/reservas/providers/mis_reservas_notifier.dart';

class MisReservasPage extends ConsumerWidget {
  const MisReservasPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservasAsync = ref.watch(misReservasProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis reservas')),
      body: reservasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (reservas) {
          if (reservas.isEmpty) {
            return const Center(child: Text('No tienes reservas aún.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reservas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 12),
            itemBuilder: (context, i) {
              final r = reservas[i];
              final f = DateFormat('dd/MM/yyyy').format(DateTime.parse(r.fecha));

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(
                    r.nombreCancha ?? 'Nombre no disponible',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 4),
                      Text('📍 ${r.direccionCancha}'),
                      Text('📅 $f'),
                      Text('🕒 ${r.horaInicio} - ${r.horaFin}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.cancel, color: Colors.red),
                    onPressed: () {
                      ref.read(misReservasProvider.notifier).cancelar(r.id);
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
