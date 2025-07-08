import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/presentation/providers/cancha_provider.dart';
import 'package:sports_field_app/presentation/pages/editar_cancha_page.dart';

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
            return const Center(child: Text('No tenés canchas registradas.'));
          }
          return ListView.builder(
            itemCount: canchas.length,
            itemBuilder: (context, i) {
              final c = canchas[i];
              return ListTile(
                title: Text(c.nombre),
                subtitle: Text('${c.tipo} | ${c.direccion}'),
                trailing: Text('\$${c.precio.toStringAsFixed(2)}'),
                onTap: () async {
                  final actualizado = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EditarCanchaPage(cancha: c)),
                  );

                  if (actualizado == true) {
                    ref.invalidate(misCanchasProvider); // recargar
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
