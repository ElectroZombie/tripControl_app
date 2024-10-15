import 'package:flutter/material.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/text_form_data_model.dart';
import 'package:trip_control_app/utils/calculo_rentabilidad.dart';
import 'package:trip_control_app/utils/tuple.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';
import 'package:trip_control_app/widgets/object_widgets/error_dialog_widget.dart';
import 'package:trip_control_app/widgets/object_widgets/list_tile_number_widget.dart';
import 'package:trip_control_app/widgets/object_widgets/rentability_widget.dart';

Widget calculator(cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2,
    double rentR, double rentKg, double rentP, context, callbackCalculate) {
  List<TextFormDataModel> producto = [
    TextFormDataModel(
        id: 1,
        text: "CANTIDAD DE UNIDADES",
        readOnly: false,
        decimal: false,
        hasTitle: false,
        controller: cantU,
        func: () => {}),
    TextFormDataModel(
        id: 2,
        text: "PESO TOTAL EN KG",
        readOnly: false,
        decimal: true,
        hasTitle: false,
        controller: pesoT,
        func: () => {})
  ];
  List<TextFormDataModel> costoProducto = [
    TextFormDataModel(
        id: 3,
        text: "COSTO TOTAL EN M2",
        readOnly: false,
        decimal: true,
        hasTitle: false,
        controller: pagoM2,
        func: () => {}),
    TextFormDataModel(
        id: 4,
        text: "CAMBIO M2/USD",
        readOnly: false,
        decimal: true,
        hasTitle: false,
        controller: cambioM2,
        func: () => {})
  ];
  List<TextFormDataModel> ventaProducto = [
    TextFormDataModel(
        id: 5,
        text: "VENTA DE UNIDAD EN CUP",
        readOnly: false,
        decimal: true,
        hasTitle: false,
        controller: precioM1,
        func: () => {}),
    TextFormDataModel(
        id: 6,
        text: "CAMBIO CUP/USD",
        readOnly: false,
        decimal: true,
        hasTitle: false,
        controller: cambioM1,
        func: () => {})
  ];

  var colors = Theme.of(context).colorScheme;
  return SingleChildScrollView(
    child: SizedBox(
      child: ListView(
        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
        shrinkWrap: true,
        children: [
          SizedBox(
            height: (MediaQuery.of(context).size.width) / 100,
          ),
          listTileMultipleNumberWidget(
              Icons.backpack,
              "PRODUCTO",
              listTileNumberSubtitleWidget(
                  producto, context, TripModel.nullTrip(),
                  singleton: false),
              context),
          SizedBox(
            height: (MediaQuery.of(context).size.width) / 100,
          ),
          listTileMultipleNumberWidget(
              Icons.attach_money,
              "COSTO DEL PRODUCTO",
              listTileNumberSubtitleWidget(
                  costoProducto, context, TripModel.nullTrip(),
                  singleton: false),
              context),
          SizedBox(
            height: (MediaQuery.of(context).size.width) / 100,
          ),
          listTileMultipleNumberWidget(
              Icons.sell,
              "VENTA DEL PRODUCTO",
              listTileNumberSubtitleWidget(
                  ventaProducto, context, TripModel.nullTrip(),
                  singleton: false),
              context),
          SizedBox(
            height: (MediaQuery.of(context).size.width * 1.5) / 100,
          ),
          TextButton(
            style: buttonStyleWidget(colors),
            onPressed: () => save(
                cantU,
                pesoT,
                pagoM2,
                precioM1,
                cambioM1,
                cambioM2,
                rentR,
                rentKg,
                rentP,
                context,
                colors,
                callbackCalculate),
            child: const Text("CONVERTIR"),
          ),
          SizedBox(
            height: (MediaQuery.of(context).size.width * 1.5) / 100,
          ),
          rentabilityWidget([
            Tuple(T: rentR, K: "RENTABILIDAD \n"),
            Tuple(T: rentKg, K: "RENTABILIDAD \n POR KILO"),
            Tuple(T: rentP, K: "RENTABILIDAD \n PORCENTUAL")
          ], context),
          SizedBox(
            height: (MediaQuery.of(context).size.width * 1.5) / 100,
          ),
        ],
      ),
    ),
  );
}

void save(
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController pagoM2,
    TextEditingController precioM1,
    TextEditingController cambioM1,
    TextEditingController cambioM2,
    double rentR,
    double rentKg,
    double rentP,
    context,
    ColorScheme colors,
    callbackCalculate) async {
  if (cantU.text.isEmpty ||
      pesoT.text.isEmpty ||
      pagoM2.text.isEmpty ||
      precioM1.text.isEmpty ||
      cambioM1.text.isEmpty ||
      cambioM2.text.isEmpty) {
    errorDialogWidget("DEBE RELLENAR TODOS LOS CAMPOS", context);
  } else {
    Tuple t = calculoRentabilidad(
        int.parse(cantU.text),
        double.parse(pesoT.text),
        double.parse(pagoM2.text),
        double.parse(precioM1.text),
        double.parse(cambioM1.text),
        double.parse(cambioM2.text));
    callbackCalculate(t.T, t.K.T, t.K.K);
  }
}
