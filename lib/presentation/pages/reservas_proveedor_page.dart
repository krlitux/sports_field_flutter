import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sports_field_app/presentation/providers/reserva_proveedor_provider.dart';

class ReservasProveedorPage extends ConsumerWidget {
  const ReservasProveedorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservasAsync = ref.watch(reservasProveedorProvider);
    //final reservasNotifier = ref.read(reservasProveedorProvider.notifier); //Uso posterior

    return Scaffold(
      appBar: AppBar(title: const Text('Reservas recibidas')),
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
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, i) {
              final r = reservas[i];
              final f = DateFormat('dd/MM/yyyy').format(DateTime.parse(r.fecha));
              final hInicio = r.horaInicio.split(':').take(2).join(':');
              final hFin = r.horaFin.split(':').take(2).join(':');

              return Card(
                elevation: 3,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(16),
                  title: Text(r.usuario?.nombre ?? 'Usuario', style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 6),
                      Text('📅 $f'),
                      Text('🕒 $hInicio - $hFin'),
                      Text('📍 ${r.cancha?.nombre ?? '-'} (${r.cancha?.direccion ?? ''})'),
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
