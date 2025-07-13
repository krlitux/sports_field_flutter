import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sports_field_app/presentation/providers/reserva_proveedor_provider.dart';

class ReservasProveedorPage extends ConsumerWidget {
  const ReservasProveedorPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reservasAsync = ref.watch(reservasProveedorProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Reservas de mis canchas')),
      body: reservasAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (reservas) {
          if (reservas.isEmpty) {
            return const Center(child: Text('No hay reservas aún.'));
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: reservas.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, i) {
              final r = reservas[i];
              final f = DateFormat('dd/MM/yyyy').format(DateTime.parse(r.fecha));
              final hInicio = r.horaInicio.substring(0, 5);
              final hFin = r.horaFin.substring(0, 5);

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
                      Text('👤 ${r.usuario?.nombre ?? 'Jugador desconocido'}', style: const TextStyle(color: Colors.grey)),
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
