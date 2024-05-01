import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/tuple.dart';

Widget newTripWidget(selectedDate, String paisSeleccionado, List<String> paises,
    context, callbackDate, callbackPais) {
  TextEditingController nombreViaje = TextEditingController();
  TextEditingController precioM1 = TextEditingController();
  TextEditingController precioM2 = TextEditingController();

  return SingleChildScrollView(
      child: Center(
          child: SizedBox(
              width: (MediaQuery.of(context).size.width * 7) / 10,
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: const Text(
                      "Nombre del viaje:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    subtitle: TextFormField(
                      controller: nombreViaje,
                      maxLength: 20,
                      keyboardType: TextInputType.text,
                      style: const TextStyle(fontSize: 14),
                    ),
                    tileColor: Color.fromARGB(255, 160, 121, 177),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * 4) / 10,
                      child: Row(
                        children: [
                          SizedBox(
                              width: (MediaQuery.of(context).size.width * 1.6) /
                                  10,
                              child: ListTile(
                                  tileColor: Color.fromARGB(255, 160, 121, 177),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text("Precio de la moneda nacional:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                  subtitle: TextFormField(
                                    controller: precioM1,
                                    maxLength: 6,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 14),
                                  ))),
                          SizedBox(
                            width:
                                (MediaQuery.of(context).size.width * 0.5) / 10,
                          ),
                          SizedBox(
                              width: (MediaQuery.of(context).size.width * 1.6) /
                                  10,
                              child: ListTile(
                                  tileColor: Color.fromARGB(255, 160, 121, 177),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: Text("Precio de la moneda extranjera:",
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255))),
                                  subtitle: TextFormField(
                                    controller: precioM2,
                                    maxLength: 6,
                                    keyboardType: TextInputType.number,
                                    style: const TextStyle(fontSize: 14),
                                  ))),
                        ],
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    tileColor: Color.fromARGB(255, 160, 121, 177),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    subtitle: DropdownButtonFormField<String>(
                      items: List.generate(
                          paises.length,
                          (i) => DropdownMenuItem(
                                child: Text(paises[i]),
                                value: paises[i],
                              )),
                      decoration: InputDecoration(
                        labelStyle: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 255, 255, 255)),
                        labelText: 'País de destino:',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(40)),
                      ),
                      value: paisSeleccionado,
                      onChanged: (value) {
                        callbackPais(value);
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: Text(
                      "Fecha de inicio del viaje:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    tileColor: Color.fromARGB(255, 160, 121, 177),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    subtitle: Text(
                      selectedDate.toString(),
                      style: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(200, 200, 200, 200)),
                    ),
                    leading: TextButton(
                        onPressed: () =>
                            _selectDate(context, selectedDate, callbackDate),
                        child: Icon(
                          Icons.event_note_rounded,
                          color: Color.fromRGBO(2, 0, 102, 0.878),
                        )),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      style: ButtonStyle(
                          fixedSize:
                              const MaterialStatePropertyAll(Size(150, 50)),
                          backgroundColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(161, 255, 255, 255)),
                          overlayColor: MaterialStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(99, 104, 58, 183))),
                      onPressed: () => crearViaje(nombreViaje, precioM1,
                          precioM2, paisSeleccionado, selectedDate, context),
                      child: const Text(
                        "Crear viaje",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ))
                ],
              ))));
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
