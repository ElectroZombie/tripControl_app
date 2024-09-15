import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/compra_model.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';

_eliminarCompra(context, CompraModel compra, TripModel trip,
    {required bool singleton}) async {
  await DB.deleteCompra(compra.id);
  if (singleton) {
    trip.deleteCompra(compra);
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 1]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control',
        arguments: 1);
  }
}

Widget deleteCompraDialog(context, compra, trip, {required bool singleton}) {
  var colors = Theme.of(context).colorScheme;
  return AlertDialog(
    backgroundColor: colors.surface,
    title: const Text("ELIMINAR COMPRA"),
    content: const Text(
      "¿ESTÁ SEGURO DE ELIMINAR LA COMPRA?",
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
        style: dialogButtonStyleWidget(colors),
        onPressed: () {
          _eliminarCompra(context, compra, trip, singleton: singleton);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('CONFIRMAR'),
      ),
    ],
  );
}
