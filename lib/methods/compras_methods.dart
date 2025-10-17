import 'package:flutter/material.dart';
import 'package:alforja/db/db_general.dart';
import 'package:alforja/models/compra_model.dart';
import 'package:alforja/models/trip_model.dart';
import 'package:alforja/widgets/compra_widgets/add_compra_widget.dart';
import 'package:alforja/widgets/compra_widgets/delete_compra_widget.dart';
import 'package:alforja/widgets/compra_widgets/update_compra_widget.dart';

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
    TripModel trip,
    {required bool singleton}) async {
  nombreCompra.value = TextEditingValue(text: compra.compraNombre);
  cantU.value = TextEditingValue(text: compra.cantU.toString());
  pesoT.value = TextEditingValue(text: compra.pesoT.toStringAsFixed(2));
  costoM2.value =
      TextEditingValue(text: compra.compraPrecio.toStringAsFixed(2));
  ventaM1.value =
      TextEditingValue(text: compra.ventaCUPXUnidad.toStringAsFixed(2));

  await showDialog<String>(
    context: context,
    builder: (context) {
      return updateCompraDialog(
          context, nombreCompra, cantU, pesoT, costoM2, ventaM1, compra, trip,
          singleton: singleton);
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
    TripModel trip,
    {required bool singleton}) async {
  nombreCompra.clear;
  cantU.clear;
  pesoT.clear;
  costoM2.clear;
  ventaM1.clear;

  await showDialog<String>(
    context: context,
    builder: (context) {
      return addCompraDialog(
          context, nombreCompra, cantU, pesoT, costoM2, ventaM1, trip,
          singleton: singleton);
    },
  );
}

Future<void> eliminarCompra(context, CompraModel compra, TripModel trip,
    {required bool singleton}) async {
  await showDialog(
    context: context,
    builder: (context) {
      return deleteCompraDialog(context, compra, trip, singleton: singleton);
    },
  );
}
