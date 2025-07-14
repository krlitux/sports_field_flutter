import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/data/models/cancha_request_model.dart';
import 'package:sports_field_app/presentation/providers/cancha_provider.dart';

class EditarCanchaPage extends ConsumerStatefulWidget {
  final CanchaModel cancha;

  const EditarCanchaPage({super.key, required this.cancha});

  @override
  ConsumerState<EditarCanchaPage> createState() => _EditarCanchaPageState();
}

class _EditarCanchaPageState extends ConsumerState<EditarCanchaPage> {
  late TextEditingController nombreCtrl;
  late TextEditingController direccionCtrl;
  late TextEditingController precioCtrl;
  late String tipo;
  bool cargando = false;

  @override
  void initState() {
    super.initState();
    nombreCtrl = TextEditingController(text: widget.cancha.nombre);
    direccionCtrl = TextEditingController(text: widget.cancha.direccion);
    precioCtrl = TextEditingController(text: widget.cancha.precio.toString());
    tipo = widget.cancha.tipo;
  }

  void guardar() async {
    setState(() => cargando = true);

    final canchaEditada = CanchaRequestModel(
      nombre: nombreCtrl.text,
      direccion: direccionCtrl.text,
      tipo: tipo,
      precio: double.tryParse(precioCtrl.text) ?? 0,
    );

    await ref
        .read(misCanchasProvider.notifier)
        .editarCancha(widget.cancha.id, canchaEditada);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('✅ Cancha actualizada exitosamente')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar cancha')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text('Actualiza los datos de tu cancha',
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
              icon: const Icon(Icons.save),
              label: Text(cargando ? 'Guardando...' : 'Guardar cambios'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(48)),
            ),
          ],
        ),
      ),
    );
  }
}
