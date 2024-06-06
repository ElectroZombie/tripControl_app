import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/compra_model.dart';

_eliminarCompra(context, CompraModel compra) async {
  await DB.deleteCompra(compra.id);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}

Widget deleteCompraDialog(context, compra) {
  return AlertDialog(
    backgroundColor: const Color.fromARGB(255, 111, 129, 155),
    title: const Text("ELIMINAR COMPRA"),
    content: const Text("¿ESTÁ SEGURO DE ELIMINAR LA COMPRA?"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('CANCELAR'),
      ),
      TextButton(
        onPressed: () {
          _eliminarCompra(context, compra);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('CONFIRMAR'),
      ),
    ],
  );
}
