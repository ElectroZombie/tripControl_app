import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/text_form_data_model.dart';
import 'package:trip_control_app/widgets/object_widgets/drop_down_search_widget.dart';
import 'package:trip_control_app/widgets/object_widgets/modified_list_tile_widget.dart';

import '../../utils/enum_types.dart';

Widget currentTripGeneralDataWidget(
    TripModel trip,
    List<String> paises,
    TextEditingController nombreViaje,
    TextEditingController precioM1,
    TextEditingController precioM2,
    TextEditingController nombrePais,
    context,
    ColorScheme colors,
    {required bool singleton}) {
  nombreViaje.value = TextEditingValue(text: trip.tripName);
  try {
    precioM1.value =
        TextEditingValue(text: trip.coin1Price!.toStringAsFixed(2));
    precioM2.value =
        TextEditingValue(text: trip.coin2Price!.toStringAsFixed(2));
  } catch (e) {
    //
  }

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
                          func: updateNombreViaje)
                    ], context, trip, singleton: singleton),
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
                          hasTitle: true,
                          inputType: InputTypes.numberDecimal,
                          controller: precioM1,
                          func: updatePrecioM1),
                      TextFormDataModel(
                          id: 2,
                          text: "CAMBIO M2/USD",
                          readOnly: false,
                          hasTitle: true,
                          inputType: InputTypes.numberDecimal,
                          controller: precioM2,
                          func: updatePrecioM2)
                    ], context, trip, singleton: singleton),
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
                        subtitle: dropDownSearchCurrent(paises, nombrePais,
                            trip, context, updatePais, colors, singleton)),
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
                            title: const Text("FECHAS DEL VIAJE",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 14)),
                            tileColor: colors.primary,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(
                                    color: colors.tertiary, width: 1.75),
                                borderRadius: BorderRadius.circular(30)),
                            subtitle: Column(children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 100,
                              ),
                              Row(children: [
                                ElevatedButton(
                                    onPressed: () => _selectDateInicio(
                                        context,
                                        trip,
                                        trip.fechaInicioViaje!,
                                        singleton),
                                    style: ButtonStyle(
                                        fixedSize: const WidgetStatePropertyAll(
                                            Size(150, 20)),
                                        backgroundColor: WidgetStatePropertyAll(
                                            colors.secondary),
                                        shadowColor: WidgetStatePropertyAll(
                                            colors.tertiary),
                                        overlayColor: WidgetStatePropertyAll(
                                            colors.onPrimaryFixedVariant),
                                        foregroundColor: WidgetStatePropertyAll(
                                            colors.onSecondary),
                                        textStyle: WidgetStatePropertyAll(
                                            TextStyle(
                                                fontSize: 12,
                                                color: colors.onSecondary,
                                                fontWeight: FontWeight.bold)),
                                        shape: WidgetStatePropertyAll(
                                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5), side: BorderSide(color: colors.tertiary, width: 1.75)))),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.flight_takeoff),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("IDA:")
                                      ],
                                    )),
                                const SizedBox(width: 30),
                                Text(
                                  trip.fechaInicioViaje
                                      .toString()
                                      .split(" ")
                                      .first,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ]),
                              Row(children: [
                                ElevatedButton(
                                    onPressed: () => _selectDateFinal(context,
                                        trip, trip.fechaFinalViaje!, singleton),
                                    style: ButtonStyle(
                                        fixedSize: const WidgetStatePropertyAll(
                                            Size(150, 20)),
                                        backgroundColor: WidgetStatePropertyAll(
                                            colors.secondary),
                                        shadowColor: WidgetStatePropertyAll(
                                            colors.tertiary),
                                        overlayColor: WidgetStatePropertyAll(
                                            colors.onPrimaryFixedVariant),
                                        foregroundColor: WidgetStatePropertyAll(
                                            colors.onSecondary),
                                        textStyle: WidgetStatePropertyAll(TextStyle(
                                            fontSize: 12,
                                            color: colors.onSecondary,
                                            fontWeight: FontWeight.bold)),
                                        shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                            side: BorderSide(color: colors.tertiary, width: 1.75)))),
                                    child: const Row(
                                      children: [
                                        Icon(Icons.flight_land),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("REGRESO:")
                                      ],
                                    )),
                                const SizedBox(width: 30),
                                Text(
                                  trip.fechaFinalViaje
                                      .toString()
                                      .split(" ")
                                      .first,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ]),
                            ]))
                      ])
                    ])
                  ])
                ])
              ]))));
}

Future<void> _selectDateInicio(
    context, TripModel trip, String selectedDate, singleton) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.parse(selectedDate),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  // ignore: unrelated_type_equality_checks
  if (picked != null && picked != selectedDate) {
    _updateFechaInicio(picked, trip, context, singleton);
  }
}

Future<void> _selectDateFinal(
    context, TripModel trip, String selectedDate, bool singleton) async {
  if (selectedDate == "") {
    selectedDate = DateTime.now().toString();
  }
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.parse(selectedDate),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  // ignore: unrelated_type_equality_checks
  if (picked != null && picked != selectedDate) {
    _updateFechaFinal(picked, trip, context, singleton);
  }
}

Future<void> updatePais(
    String name, TripModel trip, context, bool singleton) async {
  trip.nombrePais = name;
  await DB.updatePaisTrip(trip.tripID, trip.nombrePais!);
  if (singleton) {
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 0]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control');
  }
}

Future<void> _updateFechaInicio(
    DateTime date, TripModel trip, context, bool singleton) async {
  await DB.updateFechaInicioTrip(trip.tripID, date);
  trip.fechaInicioViaje = date.toString();
  if (singleton) {
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 0]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control');
  }
}

Future<void> _updateFechaFinal(
    DateTime date, TripModel trip, context, bool singleton) async {
  await DB.updateFechaFinalTrip(trip.tripID, date);
  trip.fechaFinalViaje = date.toString();
  if (singleton) {
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 0]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control');
  }
}

Future<void> updateNombreViaje(
    String nombreViaje, TripModel trip, context, bool singleton) async {
  trip.tripName = nombreViaje;
  DB.updateTrip(trip);
  if (singleton) {
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 0]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control');
  }
}

Future<void> updatePrecioM1(
    String precioM1, TripModel trip, context, bool singleton) async {
  trip.setCoin1Price(double.parse(precioM1));
  DB.updateTrip(trip);
  if (singleton) {
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 0]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control');
  }
}

Future<void> updatePrecioM2(
    String precioM2, TripModel trip, context, bool singleton) async {
  trip.setCoin2Price(double.parse(precioM2));
  DB.updateTrip(trip);
  if (singleton) {
    Navigator.pushReplacementNamed(context, '/update_trip_singleton',
        arguments: [trip, 0]);
  } else {
    Navigator.pushReplacementNamed(context, '/current_trip_control');
  }
}
