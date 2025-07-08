import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/data/models/cancha_request_model.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';

class EditarCanchaPage extends ConsumerStatefulWidget {
  final CanchaModel cancha;

  const EditarCanchaPage({super.key, required this.cancha});

  @override
  ConsumerState<EditarCanchaPage> createState() => _EditarCanchaPageState();
}

class _EditarCanchaPageState extends ConsumerState<EditarCanchaPage> {
  late TextEditingController nombreController;
  late TextEditingController direccionController;
  late TextEditingController precioController;
  String tipo = 'sintético';
  bool loading = false;
  String? mensaje;

  @override
  void initState() {
    super.initState();
    nombreController = TextEditingController(text: widget.cancha.nombre);
    direccionController = TextEditingController(text: widget.cancha.direccion);
    precioController = TextEditingController(text: widget.cancha.precio.toStringAsFixed(2));
    tipo = widget.cancha.tipo;
  }

  void guardarCambios() async {
    setState(() {
      loading = true;
      mensaje = null;
    });

    final repo = ref.read(canchaRepositoryProvider);
    final canchaActualizada = CanchaRequestModel(
      nombre: nombreController.text,
      direccion: direccionController.text,
      tipo: tipo,
      precio: double.tryParse(precioController.text) ?? 0,
    );

    try {
      await repo.editarCancha(widget.cancha.id, canchaActualizada);

      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      setState(() {
        mensaje = 'Error al guardar los cambios';
      });
    } finally {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Editar cancha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nombreController, decoration: const InputDecoration(labelText: 'Nombre')),
            TextField(controller: direccionController, decoration: const InputDecoration(labelText: 'Dirección')),
            DropdownButton<String>(
              value: tipo,
              items: const [
                DropdownMenuItem(value: 'sintetico', child: Text('Sintetico')),
                DropdownMenuItem(value: 'natural', child: Text('Natural')),
              ],
              onChanged: (val) => setState(() => tipo = val!),
            ),
            TextField(
              controller: precioController,
              decoration: const InputDecoration(labelText: 'Precio por hora'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            if (mensaje != null) Text(mensaje!, style: const TextStyle(color: Colors.red)),
            ElevatedButton(
              onPressed: loading ? null : guardarCambios,
              child: loading ? const CircularProgressIndicator() : const Text('Guardar cambios'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: loading
                  ? null
                  : () async {
                final confirmacion = await showDialog<bool>(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: const Text('¿Eliminar cancha?'),
                    content: const Text('Esta acción no se puede deshacer.'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('Eliminar', style: TextStyle(color: Colors.red)),
                      ),
                    ],
                  ),
                );

                if (confirmacion != true) return;

                setState(() => loading = true);
                final repo = ref.read(canchaRepositoryProvider);

                try {
                  await repo.eliminarCancha(widget.cancha.id);
                  if (!mounted) return;
                  Navigator.pop(context, true);
                } catch (e) {
                  setState(() {
                    mensaje = 'Error al eliminar la cancha';
                  });
                } finally {
                  setState(() => loading = false);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Eliminar cancha'),
            ),
          ],
        ),
      ),
    );
  }
}
