import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/compra_model.dart';

Widget updateCompraDialog(
    context, nombreCompra, cantU, pesoT, costoM2, ventaM1, compra) {
  return AlertDialog(
    title: const Text('Actualizar compra'),
    content: Column(
      children: [
        TextFormField(
          controller: nombreCompra,
        ),
        TextFormField(
          controller: cantU,
        ),
        TextFormField(
          controller: pesoT,
        ),
        TextFormField(
          controller: costoM2,
        ),
        TextFormField(
          controller: ventaM1,
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
          _actualizarCompra(
              context, compra, nombreCompra, cantU, pesoT, costoM2, ventaM1);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('Confirmar'),
      ),
    ],
  );
}

_actualizarCompra(
    context, compra, nombreCompra, cantU, pesoT, costoM2, ventaM1) async {
  CompraModel compraAct = CompraModel(
      tripID: compra.tripID,
      id: compra.id,
      compraNombre: nombreCompra.value.text,
      cantU: int.parse(cantU.value.text),
      pesoT: double.parse(pesoT.value.text),
      compraPrecio: double.parse(costoM2.value.text),
      ventaCUPXUnidad: double.parse(ventaM1.value.text));
  await DB.updateCompra(compraAct);
  Navigator.pushReplacementNamed(context, '/trip_control');
}
