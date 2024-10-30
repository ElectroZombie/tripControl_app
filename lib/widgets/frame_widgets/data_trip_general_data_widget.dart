import 'package:flutter/material.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/text_form_data_model.dart';
import 'package:trip_control_app/widgets/object_widgets/drop_down_search_widget.dart';
import 'package:trip_control_app/widgets/object_widgets/modified_list_tile_widget.dart';

import '../../utils/enum_types.dart';

Widget dataTripGeneralDataWidget(TripModel trip, context, ColorScheme colors) {
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
                        readOnly: true,
                        hasTitle: true,
                        inputType: InputTypes.text,
                        controller: TextEditingController.fromValue(
                            TextEditingValue(text: trip.tripName)),
                        func: () => {})
                  ], context, trip, singleton: false),
                  context,
                ),
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
                          readOnly: true,
                          hasTitle: true,
                          inputType: InputTypes.numberDecimal,
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: trip.coin1Price!.toStringAsFixed(2))),
                          func: () => {}),
                      TextFormDataModel(
                          id: 2,
                          text: "CAMBIO M2/USD",
                          readOnly: true,
                          hasTitle: true,
                          inputType: InputTypes.numberDecimal,
                          controller: TextEditingController.fromValue(
                              TextEditingValue(
                                  text: trip.coin2Price!.toStringAsFixed(2))),
                          func: () => {})
                    ], context, trip, singleton: false),
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
                        subtitle: dropDownSearchCurrent(
                            [trip.nombrePais!],
                            TextEditingController.fromValue(
                                TextEditingValue(text: trip.nombrePais!)),
                            trip,
                            context,
                            () => {},
                            colors,
                            false)),
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
                                    onPressed: () => {},
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
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                side: BorderSide(color: colors.tertiary, width: 1.75)))),
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
                                    onPressed: () => {},
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
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5),
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
