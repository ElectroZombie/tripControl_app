import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/gasto_model.dart';

Widget updateGastoDialog(
    context, GastoModel gasto, gastoDescripcion, gastoCosto) {
  return AlertDialog(
    title: const Text('ACTUALIZAR GASTO (USD)'),
    backgroundColor: const Color.fromARGB(255, 111, 129, 155),
    content: SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
          controller: gastoDescripcion,
          decoration: const InputDecoration(
              label: Text("DESCRIPCIÓN DEL GASTO:"),
              labelStyle: TextStyle(fontSize: 16)),
        ),
        TextFormField(
          controller: gastoCosto,
          decoration: const InputDecoration(
              label: Text("GASTO:"), labelStyle: TextStyle(fontSize: 16)),
        ),
      ],
    )),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('CANCELAR'),
      ),
      TextButton(
        onPressed: () {
          _actualizarGasto(context, gasto, gastoDescripcion, gastoCosto);
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
) async {
  GastoModel gastoAct = GastoModel(
      id: gasto.id,
      tripID: gasto.tripID,
      gastoDescripcion: gastoDescripcion.value.text,
      gastoMoney: double.parse(gastoCosto.value.text));
  await DB.updateGasto(gastoAct);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}
