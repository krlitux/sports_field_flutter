import 'package:flutter/material.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/presentation/pages/reserva_form_page.dart';

class CanchaDetallePage extends StatelessWidget {
  final CanchaModel cancha;

  const CanchaDetallePage({super.key, required this.cancha});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(cancha.nombre)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cancha.nombre,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Dirección: ${cancha.direccion}'),
            Text('Tipo: ${cancha.tipo}'),
            Text('Precio por hora: \$${cancha.precio.toStringAsFixed(2)}'),
            const SizedBox(height: 32),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReservaFormPage(cancha: cancha),
                    ),
                  );
                },
                child: const Text('Reservar cancha'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
