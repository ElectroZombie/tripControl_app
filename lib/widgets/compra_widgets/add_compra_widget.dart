import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/compra_model.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';

_agregarCompra(
    context, nombreCompra, cantU, pesoT, costoM2, ventaM1, TripModel trip,
    {required bool singleton}) async {
  CompraModel compraAct = CompraModel(
      tripID: trip.tripID,
      id: (await DB.getLastIDCompra()) + 1,
      compraNombre: nombreCompra.value.text,
      cantU: int.parse(cantU.value.text),
      pesoT: double.parse(pesoT.value.text),
      compraPrecio: double.parse(costoM2.value.text),
      ventaCUPXUnidad: double.parse(ventaM1.value.text));
  await DB.insertNewCompra(compraAct);
  if (singleton) {
    trip.addCompra(compraAct);
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 1]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control',
        arguments: 1);
  }
}

Widget addCompraDialog(
    context, nombreCompra, cantU, pesoT, costoM2, ventaM1, TripModel trip,
    {required bool singleton}) {
  var colors = Theme.of(context).colorScheme;
  return AlertDialog(
    backgroundColor: colors.surface,
    title: const Text('AGREGAR COMPRA'),
    content: SingleChildScrollView(
        child: Column(
      children: [
        TextFormField(
          decoration: InputDecoration(
              icon: const Icon(Icons.numbers),
              fillColor: colors.surface,
              labelText: "NOMBRE DEL PRODUCTO:",
              labelStyle: const TextStyle(fontSize: 10),
              filled: true,
              constraints: BoxConstraints.loose(const Size.fromHeight(35)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.tertiary, width: 1.75),
                  borderRadius: BorderRadius.circular(10))),
          controller: nombreCompra,
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
            controller: cantU,
            decoration: InputDecoration(
                icon: const Icon(Icons.numbers),
                fillColor: colors.surface,
                labelText: "CANTIDAD DE UNIDADES:",
                labelStyle: const TextStyle(fontSize: 10),
                filled: true,
                constraints: BoxConstraints.loose(const Size.fromHeight(35)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: colors.tertiary, width: 1.75),
                    borderRadius: BorderRadius.circular(10)))),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: pesoT,
          decoration: InputDecoration(
              icon: const Icon(Icons.numbers),
              fillColor: colors.surface,
              labelText: "PESO TOTAL (KG):",
              labelStyle: const TextStyle(fontSize: 10),
              filled: true,
              constraints: BoxConstraints.loose(const Size.fromHeight(35)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.tertiary, width: 1.75),
                  borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: costoM2,
          decoration: InputDecoration(
              icon: const Icon(Icons.numbers),
              fillColor: colors.surface,
              labelText: "COSTO TOTAL EN MONEDA EXTRANJERA:",
              labelStyle: const TextStyle(fontSize: 10),
              filled: true,
              constraints: BoxConstraints.loose(const Size.fromHeight(35)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.tertiary, width: 1.75),
                  borderRadius: BorderRadius.circular(10))),
        ),
        const SizedBox(
          height: 5,
        ),
        TextFormField(
          controller: ventaM1,
          decoration: InputDecoration(
              icon: const Icon(Icons.numbers),
              fillColor: colors.surface,
              labelText: "VENTA DE UNIDAD EN CUP:",
              labelStyle: const TextStyle(fontSize: 10),
              filled: true,
              constraints: BoxConstraints.loose(const Size.fromHeight(35)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.tertiary, width: 1.75),
                  borderRadius: BorderRadius.circular(10))),
        ),
      ],
    )),
    actions: [
      TextButton(
        style: dialogButtonStyleWidget(colors),
        onPressed: () {
          Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
        },
        child: const Text('CANCELAR'),
      ),
      TextButton(
        style: dialogButtonStyleWidget(colors),
        onPressed: () {
          _agregarCompra(
              context, nombreCompra, cantU, pesoT, costoM2, ventaM1, trip,
              singleton: singleton);
          Navigator.pop(
              context); // Cerrar el diálogo y pasar la unidad ingresada
        },
        child: const Text('CONFIRMAR'),
      ),
    ],
  );
}
