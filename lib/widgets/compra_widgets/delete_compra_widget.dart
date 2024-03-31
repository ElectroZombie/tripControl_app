import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/compra_model.dart';

_eliminarCompra(context, CompraModel compra) async {
  await DB.deleteCompra(compra.id);
  Navigator.pushReplacementNamed(context, '/trip_control');
}

Widget deleteCompraDialog(context, compra) {
  return AlertDialog(
    title: Text("Eliminar compra"),
    content: Text("Esta seguro de que desea eliminar la compra?"),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('Cancelar'),
      ),
      TextButton(
        onPressed: () {
          _eliminarCompra(context, compra);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('Confirmar'),
      ),
    ],
  );
}
