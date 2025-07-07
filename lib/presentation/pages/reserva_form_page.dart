import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:sports_field_app/data/models/reserva_request_model.dart';
import 'package:sports_field_app/data/models/cancha_model.dart';
import 'package:sports_field_app/presentation/providers/reserva_provider.dart';

class ReservaFormPage extends ConsumerStatefulWidget {
  final CanchaModel cancha;

  const ReservaFormPage({super.key, required this.cancha});

  @override
  ConsumerState<ReservaFormPage> createState() => _ReservaFormPageState();
}

class _ReservaFormPageState extends ConsumerState<ReservaFormPage> {
  DateTime? fecha;
  final _inicioCtrl = TextEditingController();
  final _finCtrl = TextEditingController();
  String? mensaje;

  void reservar() async {
    final horaInicio = _inicioCtrl.text;
    final horaFin = _finCtrl.text;

    // Validaciones básicas
    if (fecha == null || horaInicio.isEmpty || horaFin.isEmpty) {
      setState(() => mensaje = 'Completá todos los campos');
      return;
    }

    // Validar formato HH:mm
    final regex = RegExp(r'^\d{2}:\d{2}$');
    if (!regex.hasMatch(horaInicio) || !regex.hasMatch(horaFin)) {
      setState(() => mensaje = 'Formato de hora inválido. Ej: 18:00');
      return;
    }

    // Validar lógica de horario
    final inicio = TimeOfDay(
      hour: int.parse(horaInicio.split(':')[0]),
      minute: int.parse(horaInicio.split(':')[1]),
    );
    final fin = TimeOfDay(
      hour: int.parse(horaFin.split(':')[0]),
      minute: int.parse(horaFin.split(':')[1]),
    );

    final inicioMinutos = inicio.hour * 60 + inicio.minute;
    final finMinutos = fin.hour * 60 + fin.minute;

    if (inicioMinutos >= finMinutos) {
      setState(() => mensaje = 'La hora de inicio debe ser menor a la hora de fin');
      return;
    }

    // Enviar reserva
    final repo = await ref.read(reservaRepositoryProvider.future);
    final reserva = ReservaRequestModel(
      canchaId: widget.cancha.id,
      fecha: DateFormat('yyyy-MM-dd').format(fecha!),
      horaInicio: horaInicio,
      horaFin: horaFin,
    );

    try {
      await repo.crearReserva(reserva);

      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Reserva confirmada'),
          content: const Text('¡Tu turno quedó reservado!'),
          actions: [
            TextButton(
              onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
              child: const Text('Aceptar'),
            )
          ],
        ),
      );
    } catch (e) {
      setState(() => mensaje = '❌ Error al reservar: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Reservar cancha')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ListTile(
              title: Text(fecha == null
                  ? 'Seleccionar fecha'
                  : DateFormat('dd/MM/yyyy').format(fecha!)),
              trailing: const Icon(Icons.calendar_today),
              onTap: () async {
                final seleccion = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime.now().add(const Duration(days: 30)),
                );
                if (seleccion != null) {
                  setState(() => fecha = seleccion);
                }
              },
            ),
            ListTile(
              title: Text(
                _inicioCtrl.text.isEmpty ? 'Seleccionar hora de inicio' : 'Inicio: ${_inicioCtrl.text}',
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  final formatted = picked.format(context);
                  final parsed = TimeOfDay(
                    hour: picked.hour,
                    minute: picked.minute,
                  );
                  setState(() {
                    _inicioCtrl.text = parsed.hour.toString().padLeft(2, '0') +
                        ':' +
                        parsed.minute.toString().padLeft(2, '0');
                  });
                }
              },
            ),
            ListTile(
              title: Text(
                _finCtrl.text.isEmpty ? 'Seleccionar hora de fin' : 'Fin: ${_finCtrl.text}',
              ),
              trailing: const Icon(Icons.access_time),
              onTap: () async {
                final picked = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (picked != null) {
                  setState(() {
                    _finCtrl.text = picked.hour.toString().padLeft(2, '0') +
                        ':' +
                        picked.minute.toString().padLeft(2, '0');
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: reservar, child: const Text('Confirmar reserva')),
            const SizedBox(height: 12),
            if (mensaje != null) Text(mensaje!, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
