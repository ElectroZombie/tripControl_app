import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/compra_model.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/compra_widgets/add_compra_widget.dart';
import 'package:trip_control_app/widgets/compra_widgets/delete_compra_widget.dart';
import 'package:trip_control_app/widgets/compra_widgets/update_compra_widget.dart';

Future<List<CompraModel>> getCompras(int id) async {
  return DB.getComprasTrip(id);
}

Future<void> actualizarCompra(
    context,
    CompraModel compra,
    TextEditingController nombreCompra,
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController costoM2,
    TextEditingController ventaM1,
    TripModel trip) async {
  nombreCompra.value = TextEditingValue(text: compra.compraNombre);
  cantU.value = TextEditingValue(text: compra.cantU.toString());
  pesoT.value = TextEditingValue(text: compra.pesoT.toString());
  costoM2.value = TextEditingValue(text: compra.compraPrecio.toString());
  ventaM1.value = TextEditingValue(text: compra.ventaCUPXUnidad.toString());

  await showDialog<String>(
    context: context,
    builder: (context) {
      return updateCompraDialog(
          context, nombreCompra, cantU, pesoT, costoM2, ventaM1, compra);
    },
  );
}

Future<void> agregarCompra(
    BuildContext context,
    TextEditingController nombreCompra,
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController costoM2,
    TextEditingController ventaM1,
    TripModel trip) async {
  nombreCompra.clear;
  cantU.clear;
  pesoT.clear;
  costoM2.clear;
  ventaM1.clear;

  await showDialog<String>(
    context: context,
    builder: (context) {
      return addCompraDialog(
          context, nombreCompra, cantU, pesoT, costoM2, ventaM1);
    },
  );
}

Future<void> eliminarCompra(context, CompraModel compra, TripModel trip) async {
  await showDialog(
    context: context,
    builder: (context) {
      return deleteCompraDialog(context, compra);
    },
  );
}
