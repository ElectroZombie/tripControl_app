import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/tuple.dart';

Widget newTripWidget(selectedDate, paisSeleccionado, paises, context,
    callbackDate, callbackPais) {
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
      /*  ListTile(
        subtitle: DropdownButtonFormField<String>(
          value: paisSeleccionado,
          onChanged: (value) {
            callbackPais(value);
          },
          items: paises.map((item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          decoration: const InputDecoration(
            labelText: 'Pais',
            border: InputBorder.none,
          ),
        ),
      ),*/
      ListTile(
        title: Text("Fecha de inicio"),
        subtitle: Text(selectedDate.toString()),
        leading: TextButton(
            onPressed: () => _selectDate(context, selectedDate, callbackDate),
            child: Text("Seleccionar fecha de inicio del viaje")),
      ),
      TextButton(
          onPressed: () => crearViaje(nombreViaje, precioM1, precioM2,
              paisSeleccionado, selectedDate, context),
          child: const Text("Crear viaje"))
    ],
  ));
}

void crearViaje(
    TextEditingController nombreViaje,
    TextEditingController precioM1,
    TextEditingController precioM2,
    String pais,
    selectedDate,
    context) async {
  if (nombreViaje.value.text == "" ||
      precioM1.value.text == "" ||
      precioM2.value.text == "" ||
      pais == "") {
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
        rentabilidadXKilo: 0,
        nombrePais: pais,
        fechaInicioViaje: selectedDate.toString());
    trip.coin1Price = double.tryParse(precioM1.value.text);
    trip.coin2Price = double.tryParse(precioM2.value.text);
    await DB.insertNewTrip(trip);

    Navigator.pushReplacementNamed(context, '/trip_control',
        arguments: Tuple(T: 1, K: trip));
  }
}

Future<void> _selectDate(context, selectedDate, callbackDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != selectedDate) {
    callbackDate(picked);
  }
}
