import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';

Widget addGastoDialog(context, gastoDescripcion, gastoCosto) {
  return AlertDialog(
    title: const Text('Agregar gasto'),
    backgroundColor: Color.fromARGB(255, 111, 129, 155),
    content: SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
          controller: gastoDescripcion,
          decoration: InputDecoration(
              label: Text("Descripción del gasto"),
              labelStyle: TextStyle(fontSize: 16)),
        ),
        TextFormField(
          controller: gastoCosto,
          decoration: InputDecoration(
              label: Text("Costo del gasto"),
              labelStyle: TextStyle(fontSize: 16)),
        ),
      ],
    )),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('Cancelar'),
      ),
      TextButton(
        onPressed: () {
          _agregarGasto(context, gastoDescripcion, gastoCosto);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('Confirmar'),
      ),
    ],
  );
}

_agregarGasto(context, TextEditingController gastoDescripcion,
    TextEditingController gastoCosto) async {
  GastoModel gastoAct = GastoModel(
      id: await DB.getLastIDGasto() + 1,
      tripID: await DB.getLastIDTrip(),
      gastoDescripcion: gastoDescripcion.value.text,
      gastoMoney: double.parse(gastoCosto.value.text));
  await DB.insertNewGasto(gastoAct);
  Navigator.pushReplacementNamed(context, '/trip_control');
}
