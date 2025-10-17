import 'package:flutter/material.dart';
import 'package:alforja/db/db_general.dart';
import 'package:alforja/utils/text_form_data_model.dart';
import 'package:alforja/models/trip_model.dart';
import 'package:alforja/widgets/object_widgets/drop_down_search_widget.dart';
import 'package:alforja/widgets/object_widgets/button_widget.dart';
import 'package:alforja/widgets/object_widgets/error_dialog_widget.dart';
import 'package:alforja/widgets/object_widgets/modified_list_tile_widget.dart';

import '../../utils/enum_types.dart';

Widget newTripWidget(
    selectedDate,
    String paisSeleccionado,
    List<String> paises,
    TextEditingController nombreViaje,
    TextEditingController precioM1,
    TextEditingController precioM2,
    TextEditingController paisNombre,
    Map<String, Function> callbacks,
    context,
    colors) {
  return SingleChildScrollView(
      child: Center(
          child: SizedBox(
              width: (MediaQuery.of(context).size.width * 9) / 10,
              child: Column(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                modifiedListTileWidget(
                    Icons.travel_explore_outlined,
                    "NOMBRE DEL VIAJE",
                    modifiedListTileSubtitleWidget([
                      TextFormDataModel(
                          id: 1,
                          text: "NOMBRE DEL VIAJE",
                          readOnly: false,
                          hasTitle: true,
                          inputType: InputTypes.text,
                          controller: nombreViaje,
                          func: () => {})
                    ], context, TripModel.nullTrip(), singleton: false),
                    context),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                modifiedListTileWidget(
                    Icons.monetization_on,
                    "TASA DE CAMBIO",
                    modifiedListTileSubtitleWidget([
                      TextFormDataModel(
                          id: 1,
                          text: "CAMBIO CUP/USD",
                          readOnly: false,
                          inputType: InputTypes.numberDecimal,
                          hasTitle: true,
                          controller: precioM1,
                          func: () => {}),
                      TextFormDataModel(
                          id: 2,
                          text: "CAMBIO M2/USD",
                          readOnly: false,
                          inputType: InputTypes.numberDecimal,
                          hasTitle: true,
                          controller: precioM2,
                          func: () => {})
                    ], context, TripModel.nullTrip(), singleton: false),
                    context),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 100,
                ),
                Stack(children: [
                  Row(children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                        backgroundColor: colors.tertiary,
                        child: Icon(
                          Icons.map_outlined,
                          color: colors.onTertiary,
                        ))
                  ]),
                  Column(children: [
                    const SizedBox(
                      height: 7,
                    ),
                    ListTile(
                        tileColor: colors.primary,
                        title: const Text("PAÍS",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14)),
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: colors.tertiary, width: 1.75),
                            borderRadius: BorderRadius.circular(20)),
                        subtitle: dropDownSearch(paises, paisNombre, context,
                            callbacks, colors, false)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 100,
                    ),
                    Stack(children: [
                      Row(children: [
                        const SizedBox(width: 10),
                        CircleAvatar(
                            backgroundColor: colors.tertiary,
                            child: Icon(
                              Icons.calendar_month_outlined,
                              color: colors.onTertiary,
                            ))
                      ]),
                      Column(children: [
                        const SizedBox(
                          height: 7,
                        ),
                        ListTile(
                          title: const Text("FECHA DE INICIO DEL VIAJE",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14)),
                          tileColor: colors.primary,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: colors.tertiary, width: 1.75),
                              borderRadius: BorderRadius.circular(30)),
                          subtitle: Column(
                            children: [
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(
                                      "SELECCIONAR FECHA:",
                                      style: TextStyle(fontSize: 12),
                                    ),
                                    TextButton(
                                        onPressed: () => _selectDate(
                                            context,
                                            selectedDate,
                                            callbacks["date"],
                                            colors),
                                        child: Icon(
                                          Icons.event_note_rounded,
                                          color: colors.tertiary,
                                        ))
                                  ]),
                              Text(
                                selectedDate.toString().split(" ").first,
                                style: const TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height:
                              MediaQuery.of(context).size.height * 1.5 / 100,
                        ),
                        TextButton(
                            style: buttonStyleWidget(colors),
                            onPressed: () => crearViaje(
                                nombreViaje,
                                precioM1,
                                precioM2,
                                paisSeleccionado,
                                selectedDate,
                                context),
                            child: const Text("CREAR VIAJE")),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 5 / 100,
                        ),
                      ])
                    ])
                  ])
                ])
              ]))));
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
    errorDialogWidget("RELLENE TODOS LOS CAMPOS", context);
  } else {
    TripModel trip = TripModel(
        tripID: (await DB.getLastIDTrip()) + 1,
        tripName: nombreViaje.value.text,
        activo: 1,
        gananciaComprasReal: 0,
        gananciaComprasXKilo: 0,
        gastoCompras: 0,
        gastoComprasXKilo: 0,
        kilosTotales: 0,
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

Future<void> _selectDate(
    context, selectedDate, callbackDate, ColorScheme colors) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    helpText: "SELECCIONE LA FECHA DEL VIAJE",
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != selectedDate) {
    callbackDate(picked);
  }
}
