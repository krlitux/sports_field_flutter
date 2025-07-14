import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/cancha_request_model.dart';
import 'package:sports_field_app/presentation/providers/cancha_provider.dart';

class CrearCanchaPage extends ConsumerStatefulWidget {
  const CrearCanchaPage({super.key});

  @override
  ConsumerState<CrearCanchaPage> createState() => _CrearCanchaPageState();
}

class _CrearCanchaPageState extends ConsumerState<CrearCanchaPage> {
  final nombreCtrl = TextEditingController();
  final direccionCtrl = TextEditingController();
  final precioCtrl = TextEditingController();
  String tipo = 'natural';
  bool cargando = false;

  void guardar() async {
    setState(() => cargando = true);
    final cancha = CanchaRequestModel(
      nombre: nombreCtrl.text,
      direccion: direccionCtrl.text,
      tipo: tipo,
      precio: double.tryParse(precioCtrl.text) ?? 0,
    );

    await ref.read(misCanchasProvider.notifier).crearCancha(cancha);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Cancha creada exitosamente')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear cancha')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Completa los datos de tu cancha',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            TextField(
              controller: nombreCtrl,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: direccionCtrl,
              decoration: const InputDecoration(
                labelText: 'Dirección',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            DropdownButtonFormField<String>(
              value: tipo,
              items: const [
                DropdownMenuItem(value: 'natural', child: Text('Pasto natural')),
                DropdownMenuItem(value: 'sintetico', child: Text('Pasto sintético')),
              ],
              onChanged: (val) => setState(() => tipo = val!),
              decoration: const InputDecoration(
                labelText: 'Tipo de césped',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: precioCtrl,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Precio por hora (S/.)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: cargando ? null : guardar,
              icon: const Icon(Icons.check),
              label: Text(cargando ? 'Guardando...' : 'Guardar'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
          ],
        ),
      ),
    );
  }
}
