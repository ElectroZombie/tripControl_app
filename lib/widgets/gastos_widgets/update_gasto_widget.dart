import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';

Widget updateGastoDialog(
    context, GastoModel gasto, gastoDescripcion, gastoCosto) {
  return AlertDialog(
    title: const Text('Actualizar gasto'),
    content: Column(
      children: [
        TextFormField(
          controller: gastoDescripcion,
        ),
        TextFormField(
          controller: gastoCosto,
        ),
      ],
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('Cancelar'),
      ),
      TextButton(
        onPressed: () {
          _actualizarGasto(context, gasto, gastoDescripcion, gastoCosto);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('Confirmar'),
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
  Navigator.pushReplacementNamed(context, '/trip_control');
}
