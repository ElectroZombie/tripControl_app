import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';

_eliminarGasto(context, gastoid) async {
  await DB.deleteGasto(gastoid);
  Navigator.pushReplacementNamed(context, '/trip_control');
}

Widget deleteGastoDialog(context, gastoid) {
  return AlertDialog(
    title: Text("Eliminar compra"),
    content: Text("Esta seguro de que desea eliminar el gasto?"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('Cancelar'),
      ),
      TextButton(
        onPressed: () {
          _eliminarGasto(context, gastoid);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('Confirmar'),
      ),
    ],
  );
}
