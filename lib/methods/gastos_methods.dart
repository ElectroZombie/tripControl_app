import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/gastos_widgets/add_gasto_dialog.dart';
import 'package:trip_control_app/widgets/gastos_widgets/delete_gasto_dialog.dart';
import 'package:trip_control_app/widgets/gastos_widgets/update_gasto_widget.dart';

Future<void> actualizarGasto(
    BuildContext context,
    GastoModel gasto,
    TextEditingController gastoDescripcion,
    TextEditingController gastoCosto,
    TripModel trip,
    {required bool singleton}) async {
  gastoDescripcion.value = TextEditingValue(text: gasto.gastoDescripcion);
  gastoCosto.value =
      TextEditingValue(text: gasto.gastoMoney.toStringAsFixed(2));
  await showDialog(
    context: context,
    builder: (context) {
      return updateGastoDialog(
          context, gasto, gastoDescripcion, gastoCosto, trip, singleton);
    },
  );
}

Future<void> agregarGasto(
    BuildContext context,
    TextEditingController gastoDescripcion,
    TextEditingController gastoCosto,
    TripModel trip,
    {required bool singleton}) async {
  gastoDescripcion.clear();
  gastoCosto.clear();
  await showDialog(
    context: context,
    builder: (context) {
      return addGastoDialog(context, gastoDescripcion, gastoCosto, trip,
          singleton: singleton);
    },
  );
}

Future<void> eliminarGasto(
    BuildContext context, GastoModel gasto, TripModel trip,
    {required bool singleton}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return deleteGastoDialog(context, gasto, trip, singleton: singleton);
    },
  );
}

Future<List<GastoModel>> getGastos(int id) async {
  return DB.getGastosTrip(id);
}
