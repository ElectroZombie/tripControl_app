import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/compra_model.dart';

_agregarCompra(context, nombreCompra, cantU, pesoT, costoM2, ventaM1) async {
  CompraModel compraAct = CompraModel(
      tripID: await DB.getLastIDTrip(),
      id: (await DB.getLastIDCompra()) + 1,
      compraNombre: nombreCompra.value.text,
      cantU: int.parse(cantU.value.text),
      pesoT: double.parse(pesoT.value.text),
      compraPrecio: double.parse(costoM2.value.text),
      ventaCUPXUnidad: double.parse(ventaM1.value.text));
  await DB.insertNewCompra(compraAct);
  Navigator.pushReplacementNamed(context, '/trip_control');
}

Widget addCompraDialog(context, nombreCompra, cantU, pesoT, costoM2, ventaM1) {
  return AlertDialog(
    title: const Text('Actualizar compra'),
    content: Column(
      children: [
        Text("Nombre del producto"),
        TextFormField(
          controller: nombreCompra,
        ),
        Text("Cantidad de unidades"),
        TextFormField(
          controller: cantU,
        ),
        Text("Peso total"),
        TextFormField(
          controller: pesoT,
        ),
        Text("Costo en moneda foranea"),
        TextFormField(
          controller: costoM2,
        ),
        Text("Precio de venta en moneda nacional"),
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
          _agregarCompra(context, nombreCompra, cantU, pesoT, costoM2, ventaM1);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('Confirmar'),
      ),
    ],
  );
}
