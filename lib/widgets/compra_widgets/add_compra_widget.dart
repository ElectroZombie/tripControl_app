import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/compra_model.dart';

_agregarCompra(
  context,
  nombreCompra,
  cantU,
  pesoT,
  costoM2,
  ventaM1,
) async {
  CompraModel compraAct = CompraModel(
      tripID: await DB.getLastIDTrip(),
      id: (await DB.getLastIDCompra()) + 1,
      compraNombre: nombreCompra.value.text,
      cantU: int.parse(cantU.value.text),
      pesoT: double.parse(pesoT.value.text),
      compraPrecio: double.parse(costoM2.value.text),
      ventaCUPXUnidad: double.parse(ventaM1.value.text));
  await DB.insertNewCompra(compraAct);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}

Widget addCompraDialog(context, nombreCompra, cantU, pesoT, costoM2, ventaM1) {
  return AlertDialog(
    title: const Text('AGREGAR COMPRA'),
    backgroundColor: const Color.fromARGB(255, 111, 129, 155),
    content: SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
          controller: nombreCompra,
          decoration: const InputDecoration(
              label: Text("NOMBRE DEL PRODUCTO:"),
              labelStyle: TextStyle(fontSize: 16)),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: cantU,
          decoration: const InputDecoration(
              label: Text("CANTIDAD DE UNIDADES:"),
              labelStyle: TextStyle(fontSize: 16)),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: pesoT,
          decoration: const InputDecoration(
              label: Text("PESO TOTAL (EN KG)"),
              labelStyle: TextStyle(fontSize: 16)),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: costoM2,
          decoration: const InputDecoration(
              label: Text("COSTO TOTAL EN MONEDA EXTRANJERA"),
              labelStyle: TextStyle(fontSize: 16)),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: ventaM1,
          decoration: const InputDecoration(
              label: Text("PRECIO DE VENTA DE CADA PRODUCTO EN CUP"),
              labelStyle: TextStyle(fontSize: 16)),
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
          _agregarCompra(context, nombreCompra, cantU, pesoT, costoM2, ventaM1);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('CONFIRMAR'),
      ),
    ],
  );
}
