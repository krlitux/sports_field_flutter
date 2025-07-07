import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/providers/reserva_provider.dart';

class HistorialReservasPage extends ConsumerWidget {
  const HistorialReservasPage({super.key});

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
            return const Center(child: Text('No tenés reservas registradas.'));
          }

          return ListView.builder(
            itemCount: reservas.length,
            itemBuilder: (context, index) {
              final r = reservas[index];
              return ListTile(
                leading: const Icon(Icons.calendar_today),
                title: Text('${r.canchaNombre}'),
                subtitle: Text('${r.fecha} | ${r.horaInicio} - ${r.horaFin}'),
              );
            },
          );
        },
      ),
    );
  }
}
