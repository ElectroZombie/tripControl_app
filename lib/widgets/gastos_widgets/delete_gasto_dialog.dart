import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/gasto_model.dart';

_eliminarGasto(context, GastoModel gasto) async {
  await DB.deleteGasto(gasto.id);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}

Widget deleteGastoDialog(context, GastoModel gasto) {
  return AlertDialog(
    title: const Text("ELIMINAR GASTO"),
    backgroundColor: const Color.fromARGB(255, 111, 129, 155),
    content: const Text("¿ESTÁ SEGURO DE QUE DESEA ELIMINAR EL GASTO?"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('CANCELAR'),
      ),
      TextButton(
        onPressed: () {
          _eliminarGasto(context, gasto);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('CONFIRMAR'),
      ),
    ],
  );
}
