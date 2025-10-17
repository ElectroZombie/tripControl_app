import 'package:flutter/material.dart';
import 'package:alforja/db/db_general.dart';
import 'package:alforja/models/gasto_model.dart';
import 'package:alforja/models/trip_model.dart';
import 'package:alforja/widgets/object_widgets/button_widget.dart';

Widget updateGastoDialog(
    context, GastoModel gasto, gastoDescripcion, gastoCosto, trip, singleton) {
  var colors = Theme.of(context).colorScheme;
  return AlertDialog(
    backgroundColor: colors.surface,
    title: const Text('ACTUALIZAR GASTO (USD)'),
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
          _actualizarGasto(
              context, gasto, gastoDescripcion, gastoCosto, trip, singleton);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('CONFIRMAR'),
      ),
    ],
  );
}

_actualizarGasto(
    context,
    GastoModel gasto,
    TextEditingController gastoDescripcion,
    TextEditingController gastoCosto,
    TripModel trip,
    singleton) async {
  GastoModel gastoAct = GastoModel(
      id: gasto.id,
      tripID: gasto.tripID,
      gastoDescripcion: gastoDescripcion.value.text,
      gastoMoney: double.parse(gastoCosto.value.text));
  await DB.updateGasto(gastoAct);
  if (singleton) {
    trip.deleteGasto(gasto.gastoMoney);
    trip.addGasto(gastoAct.gastoMoney);
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 1]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control',
        arguments: 1);
  }
}
