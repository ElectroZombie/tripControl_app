import 'package:flutter/material.dart';
import 'package:alforja/db/db_general.dart';
import 'package:alforja/models/gasto_model.dart';
import 'package:alforja/models/trip_model.dart';
import 'package:alforja/widgets/object_widgets/button_widget.dart';

_eliminarGasto(context, GastoModel gasto, TripModel trip,
    {required bool singleton}) async {
  await DB.deleteGasto(gasto.id);
  if (singleton) {
    trip.deleteGasto(gasto.gastoMoney);
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 1]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control',
        arguments: 1);
  }
}

Widget deleteGastoDialog(context, GastoModel gasto, trip,
    {required bool singleton}) {
  ColorScheme colors = Theme.of(context).colorScheme;
  return AlertDialog(
    backgroundColor: colors.surface,
    title: const Text("ELIMINAR GASTO"),
    content: const Text(
      "¿ESTÁ SEGURO DE QUE DESEA ELIMINAR EL GASTO?",
      style: TextStyle(fontSize: 14),
    ),
    actions: [
      TextButton(
        style: dialogButtonStyleWidget(colors),
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('CANCELAR'),
      ),
      TextButton(
        //crear nuevo estilo para Dialogs
        style: dialogButtonStyleWidget(colors),
        onPressed: () {
          _eliminarGasto(context, gasto, trip, singleton: singleton);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('CONFIRMAR'),
      ),
    ],
  );
}
