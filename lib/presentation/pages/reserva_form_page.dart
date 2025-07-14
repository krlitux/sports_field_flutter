import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';
import 'package:sports_field_app/presentation/providers/auth_provider.dart';
//import 'package:sports_field_app/presentation/providers/reserva_jugador_provider.dart';

class ReservaFormPage extends ConsumerStatefulWidget {
  final CanchaModel cancha;

  const ReservaFormPage({super.key, required this.cancha});

  @override
  ConsumerState<ReservaFormPage> createState() => _ReservaFormPageState();
}

class _ReservaFormPageState extends ConsumerState<ReservaFormPage> {
  DateTime? fecha;
  TimeOfDay? horaInicio;
  TimeOfDay? horaFin;
  String? mensaje;
  bool cargando = false;

  Future<void> seleccionarFecha() async {
    final ahora = DateTime.now();
    final seleccionada = await showDatePicker(
      context: context,
      initialDate: ahora.add(const Duration(days: 1)),
      firstDate: ahora,
      lastDate: ahora.add(const Duration(days: 60)),
    );
    if (seleccionada != null) {
      setState(() => fecha = seleccionada);
    }
  }

  Future<void> seleccionarHoraInicio() async {
    final seleccionada = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (seleccionada != null) {
      setState(() => horaInicio = seleccionada);
    }
  }

  Future<void> seleccionarHoraFin() async {
    final seleccionada = await showTimePicker(
      context: context,
      initialTime: horaInicio ?? TimeOfDay.now(),
    );
    if (seleccionada != null) {
      setState(() => horaFin = seleccionada);
    }
  }

  Future<void> reservar() async {
    setState(() {
      mensaje = null;
      cargando = true;
    });

    if (fecha == null || horaInicio == null || horaFin == null) {
      setState(() {
        mensaje = 'Por favor completá todos los campos.';
        cargando = false;
      });
      return;
    }

    if (horaFin!.hour < horaInicio!.hour ||
        (horaFin!.hour == horaInicio!.hour && horaFin!.minute <= horaInicio!.minute)) {
      setState(() {
        mensaje = 'La hora de fin debe ser posterior a la de inicio.';
        cargando = false;
      });
      return;
    }

    final usuarioId = await ref.read(authRepositoryProvider).getUserId();

    final request = ReservaRequestModel(
      usuario_id: int.parse(usuarioId ?? '0'),
      cancha_id: widget.cancha.id,
      fecha: DateFormat('yyyy-MM-dd').format(fecha!),
      hora_inicio: horaInicio!.format(context),
      hora_fin: horaFin!.format(context),
    );

    try {
      final repo = ref.read(reservaRepositoryProvider);
      await repo.reservar(request);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('✅ Reserva realizada con éxito'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      Navigator.pop(context, true);

    } catch (e) {
      setState(() {
        mensaje = 'Error al crear la reserva';
      });
    } finally {
      setState(() => cargando = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cancha = widget.cancha;

    return Scaffold(
      appBar: AppBar(title: const Text('Reservar cancha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(cancha.nombre, style: Theme.of(context).textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text('Tipo: ${cancha.tipo}'),
                    Text('Dirección: ${cancha.direccion}'),
                    Text('Precio: \$${cancha.precio.toStringAsFixed(2)} por hora'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: seleccionarFecha,
              icon: const Icon(Icons.date_range),
              label: Text(fecha == null
                  ? 'Seleccionar fecha'
                  : DateFormat('dd/MM/yyyy').format(fecha!)),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: seleccionarHoraInicio,
              icon: const Icon(Icons.schedule),
              label: Text(horaInicio == null
                  ? 'Seleccionar hora de inicio'
                  : horaInicio!.format(context)),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: seleccionarHoraFin,
              icon: const Icon(Icons.schedule_outlined),
              label: Text(horaFin == null
                  ? 'Seleccionar hora de fin'
                  : horaFin!.format(context)),
            ),
            if (mensaje != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  mensaje!,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: cargando ? null : reservar,
              icon: const Icon(Icons.check_circle_outline),
              label: cargando
                  ? const SizedBox(
                  height: 18, width: 18, child: CircularProgressIndicator(strokeWidth: 2))
                  : const Text('Confirmar reserva'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                backgroundColor: Colors.green[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
