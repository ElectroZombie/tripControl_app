import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/tuple.dart';

Widget newTripWidget(context) {
  TextEditingController nombreViaje = TextEditingController();
  TextEditingController precioM1 = TextEditingController();
  TextEditingController precioM2 = TextEditingController();

  return SingleChildScrollView(
      child: Column(
    children: [
      ListTile(
          subtitle: TextFormField(
        controller: nombreViaje,
        maxLength: 20,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 14),
      )),
      SizedBox(
          width: 500,
          child: Row(
            children: [
              SizedBox(
                  width: 200,
                  child: ListTile(
                      subtitle: TextFormField(
                    controller: precioM1,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                  ))),
              SizedBox(
                  width: 200,
                  child: ListTile(
                      subtitle: TextFormField(
                    controller: precioM2,
                    maxLength: 6,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                  ))),
            ],
          )),
      TextButton(
          onPressed: () => crearViaje(nombreViaje, precioM1, precioM2, context),
          child: const Text("Crear viaje"))
    ],
  ));
}

void crearViaje(
    TextEditingController nombreViaje,
    TextEditingController precioM1,
    TextEditingController precioM2,
    context) async {
  if (nombreViaje.value.text == "" ||
      precioM1.value.text == "" ||
      precioM2.value.text == "") {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Rellene todos los campos"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Cerrar el diálogo sin guardar los cambios
                },
                child: const Text('Aceptar'),
              ),
            ],
          );
        });
  } else {
    TripModel trip = TripModel(
        tripID: (await DB.getLastIDTrip()) + 1,
        tripName: nombreViaje.value.text,
        activo: 1,
        gananciaComprasReal: 0,
        gananciaComprasXKilo: 0,
        gastoCompras: 0,
        gastoComprasXKilo: 0,
        otrosGastos: 0,
        rentabilidad: 0,
        rentabilidadPorcentual: 0,
        rentabilidadXKilo: 0);
    trip.coin1Price = double.tryParse(precioM1.value.text);
    trip.coin2Price = double.tryParse(precioM2.value.text);
    await DB.insertNewTrip(trip);

    Navigator.pushReplacementNamed(context, '/trip_control',
        arguments: Tuple(T: 1, K: trip));
  }
}
