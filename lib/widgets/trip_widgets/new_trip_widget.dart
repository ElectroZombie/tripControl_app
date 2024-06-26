import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/drop_down_search_widget.dart';

Widget newTripWidget(
    selectedDate,
    String paisSeleccionado,
    List<String> paises,
    TextEditingController nombreViaje,
    TextEditingController precioM1,
    TextEditingController precioM2,
    TextEditingController paisNombre,
    Map<String, Function> callbacks,
    context) {
  return SingleChildScrollView(
      child: Center(
          child: SizedBox(
              width: (MediaQuery.of(context).size.width * 9) / 10,
              child: Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  ListTile(
                    title: const Text(
                      "NOMBRE DEL VIAJE:",
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
                    tileColor: const Color.fromARGB(255, 160, 121, 177),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width * 7) / 10,
                      child: Row(
                        children: [
                          SizedBox(
                              width:
                                  (MediaQuery.of(context).size.width * 3.25) /
                                      10,
                              child: ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 160, 121, 177),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: const Text("PRECIO DEL USD EN CUP:",
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
                              width:
                                  (MediaQuery.of(context).size.width * 3.25) /
                                      10,
                              child: ListTile(
                                  tileColor:
                                      const Color.fromARGB(255, 160, 121, 177),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  title: const Text(
                                      "PRECIO DEL USD EN MONEDA EXTRANJERA:",
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
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                      tileColor: const Color.fromARGB(255, 160, 121, 177),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      subtitle: dropDownSearch(
                          paises, paisNombre, context, callbacks)),
                  const SizedBox(
                    height: 20,
                  ),
                  ListTile(
                    title: const Text(
                      "FECHA DE INICIO DEL VIAJE:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255)),
                    ),
                    tileColor: const Color.fromARGB(255, 160, 121, 177),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    subtitle: Text(
                      selectedDate.toString().split(" ").first,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(200, 200, 200, 200)),
                    ),
                    leading: TextButton(
                        onPressed: () => _selectDate(
                            context, selectedDate, callbacks["date"]),
                        child: const Icon(
                          Icons.event_note_rounded,
                          color: Color.fromRGBO(2, 0, 102, 0.878),
                        )),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                      style: ButtonStyle(
                          fixedSize:
                              const WidgetStatePropertyAll(Size(150, 50)),
                          backgroundColor: WidgetStateColor.resolveWith(
                              (states) =>
                                  const Color.fromARGB(161, 255, 255, 255)),
                          overlayColor: WidgetStateColor.resolveWith((states) =>
                              const Color.fromARGB(99, 104, 58, 183))),
                      onPressed: () => crearViaje(nombreViaje, precioM1,
                          precioM2, paisSeleccionado, selectedDate, context),
                      child: const Text(
                        "CREAR VIAJE",
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      )),
                  const SizedBox(
                    height: 20,
                  ),
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
            title: const Text("RELLENE TODOS LOS CAMPOS"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(); // Cerrar el diálogo sin guardar los cambios
                },
                child: const Text('ACEPTAR'),
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

    Navigator.pushReplacementNamed(context, '/current_trip_control');
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
