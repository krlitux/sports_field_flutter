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
  final _formKey = GlobalKey<FormState>();
  final _nombreCtrl = TextEditingController();
  final _direccionCtrl = TextEditingController();
  final _tipoCtrl = TextEditingController();
  final _precioCtrl = TextEditingController();
  String? mensaje;

  void guardar() async {
    if (!_formKey.currentState!.validate()) return;

    final repo = await ref.read(canchaRepositoryProvider.future);
    final cancha = CanchaRequestModel(
      nombre: _nombreCtrl.text,
      direccion: _direccionCtrl.text,
      tipo: _tipoCtrl.text,
      precio: double.parse(_precioCtrl.text),
    );

    try {
      await repo.crearCancha(cancha);
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Éxito'),
          content: const Text('La cancha fue creada correctamente.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, (r) => r.isFirst),
              child: const Text('Aceptar'),
            )
          ],
        ),
      );
    } catch (e) {
      setState(() => mensaje = '❌ Error al crear cancha: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Crear nueva cancha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
              ),
              TextFormField(
                controller: _direccionCtrl,
                decoration: const InputDecoration(labelText: 'Dirección'),
                validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
              ),
              TextFormField(
                controller: _tipoCtrl,
                decoration: const InputDecoration(labelText: 'Tipo (césped, sintética, etc)'),
                validator: (v) => v!.isEmpty ? 'Obligatorio' : null,
              ),
              TextFormField(
                controller: _precioCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Precio por hora'),
                validator: (v) => v!.isEmpty || double.tryParse(v) == null
                    ? 'Debe ser un número válido'
                    : null,
              ),
              const SizedBox(height: 20),
              ElevatedButton(onPressed: guardar, child: const Text('Guardar cancha')),
              const SizedBox(height: 10),
              if (mensaje != null) Text(mensaje!, style: const TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
