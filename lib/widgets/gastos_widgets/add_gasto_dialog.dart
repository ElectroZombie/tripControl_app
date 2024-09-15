import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';

Widget addGastoDialog(context, gastoDescripcion, gastoCosto, trip,
    {required bool singleton}) {
  var colors = Theme.of(context).colorScheme;
  return AlertDialog(
    backgroundColor: colors.surface,
    title: const Text('AGREGAR GASTO (USD)'),
    content: SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
          controller: gastoDescripcion,
          decoration: InputDecoration(
              icon: const Icon(Icons.numbers),
              fillColor: colors.surface,
              labelText: "DESCRIPCIÓN DEL GASTO:",
              labelStyle: const TextStyle(fontSize: 10),
              filled: true,
              constraints: BoxConstraints.loose(const Size.fromHeight(35)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.tertiary, width: 1.75),
                  borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: gastoCosto,
          decoration: InputDecoration(
              icon: const Icon(Icons.numbers),
              fillColor: colors.surface,
              labelText: "GASTO EN USD:",
              labelStyle: const TextStyle(fontSize: 10),
              filled: true,
              constraints: BoxConstraints.loose(const Size.fromHeight(35)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.tertiary, width: 1.75),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ],
    )),
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
          _agregarGasto(context, gastoDescripcion, gastoCosto, trip,
              singleton: singleton);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('CONFIRMAR'),
      ),
    ],
  );
}

_agregarGasto(context, TextEditingController gastoDescripcion,
    TextEditingController gastoCosto, TripModel trip,
    {required bool singleton}) async {
  GastoModel gastoAct = GastoModel(
      id: await DB.getLastIDGasto() + 1,
      tripID: trip.tripID,
      gastoDescripcion: gastoDescripcion.value.text,
      gastoMoney: double.parse(gastoCosto.value.text));
  await DB.insertNewGasto(gastoAct);
  if (singleton) {
    trip.addGasto(gastoAct.gastoMoney);
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 1]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control',
        arguments: 1);
  }
}
