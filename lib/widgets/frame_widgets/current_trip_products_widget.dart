import 'package:flutter/material.dart';
import 'package:trip_control_app/methods/compras_methods.dart';
import 'package:trip_control_app/methods/gastos_methods.dart';
import 'package:trip_control_app/models/compra_model.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';
import 'package:trip_control_app/widgets/object_widgets/rentability_widget.dart';

Widget currentTripProductsWidget(
    TripModel trip,
    TextEditingController nombreCompra,
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController costoM2,
    TextEditingController ventaM1,
    TextEditingController descripcionGasto,
    TextEditingController costoGastoD,
    context,
    ColorScheme colors,
    {required bool singleton}) {
  return SingleChildScrollView(
      child: Center(
          child: SizedBox(
              width: (MediaQuery.of(context).size.width * 9) / 10,
              child: Column(children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.width) / 100,
                ),
                FutureBuilder<List<CompraModel>>(
                  future: getCompras(trip.tripID),
                  initialData: null,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.data.length == 0) {
                      return Card(
                          color: colors.tertiary,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: colors.tertiary, width: 1.75),
                              borderRadius: BorderRadius.circular(5)),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 4 / 10,
                              child: Text("No hay compras",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: colors.onTertiary))));
                    }
                    return tablaCompras(
                        snapshot.data as List<CompraModel>,
                        context,
                        trip,
                        nombreCompra,
                        cantU,
                        pesoT,
                        costoM2,
                        ventaM1,
                        colors,
                        singleton);
                  },
                ),
                const SizedBox(height: 5),
                TextButton(
                    style: buttonStyleWidget(colors),
                    onPressed: () => agregarCompra(context, nombreCompra, cantU,
                        pesoT, costoM2, ventaM1, trip,
                        singleton: singleton),
                    child: const Text(
                      "AGREGAR COMPRA",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )),
                const SizedBox(height: 5),
                FutureBuilder<List<GastoModel>>(
                  future: getGastos(trip.tripID),
                  initialData: null,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.data.length == 0) {
                      return Card(
                          color: colors.tertiary,
                          shape: RoundedRectangleBorder(
                              side: BorderSide(
                                  color: colors.tertiary, width: 1.75),
                              borderRadius: BorderRadius.circular(5)),
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 4 / 10,
                              child: Text("No hay gastos",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: colors.onTertiary))));
                    }
                    return tablaGastos(
                        snapshot.data as List<GastoModel>,
                        context,
                        trip,
                        descripcionGasto,
                        costoGastoD,
                        colors,
                        singleton);
                  },
                ),
                const SizedBox(height: 5),
                TextButton(
                    style: buttonStyleWidget(colors),
                    onPressed: () => agregarGasto(
                        context, descripcionGasto, costoGastoD, trip,
                        singleton: singleton),
                    child: const Text(
                      "AGREGAR GASTO",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Stack(children: [
                  Row(children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                        backgroundColor: colors.tertiary,
                        child: Icon(
                          Icons.calculate_rounded,
                          color: colors.onTertiary,
                        ))
                  ]),
                  Column(children: [
                    const SizedBox(
                      height: 7,
                    ),
                    ListTile(
                        title: Text(
                          "${trip.tripName} - CUENTAS",
                          textAlign: TextAlign.center,
                        ),
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                        tileColor: colors.primary,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: colors.tertiary, width: 1.75),
                            borderRadius: BorderRadius.circular(20)),
                        subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      1 /
                                      100),
                              Text(
                                "GASTO EN COMPRAS:         \$ ${trip.gastoCompras!.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 9),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.5 /
                                      100),
                              Text(
                                "GASTO EN COMPRAS (KG):\$ ${trip.gastoComprasXKilo!.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 9),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.5 /
                                      100),
                              Text(
                                "OTROS GASTOS:                 \$ ${trip.otrosGastos!.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 9),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      2 /
                                      100),
                              Text(
                                "GASTOS TOTALES:         \$ ${trip.gastoTotal.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 12, color: Colors.redAccent),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      2 /
                                      100),
                              Text(
                                "GANANCIAS:            \$ ${trip.gananciaComprasReal!.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 9),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      0.5 /
                                      100),
                              Text(
                                "GANANCIAS (KG):    \$ ${trip.gananciaComprasXKilo!.toStringAsFixed(2)}",
                                style: const TextStyle(fontSize: 9),
                              ),
                              SizedBox(
                                  height: MediaQuery.of(context).size.height *
                                      2 /
                                      100),
                              Text(
                                "GANANCIAS TOTALES:    \$ ${trip.gananciaComprasReal!.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    fontSize: 12,
                                    color: Color.fromARGB(255, 8, 95, 53)),
                              )
                            ]))
                  ])
                ]),
                SizedBox(height: MediaQuery.of(context).size.height * 1 / 100),
                rentabilityWidget(trip.rentabilidad!, trip.rentabilidadXKilo!,
                    trip.rentabilidadPorcentual!, context),
                SizedBox(
                    height: MediaQuery.of(context).size.height * 1.5 / 100),
              ]))));
}

Widget tablaCompras(
    List<CompraModel> lista,
    context,
    TripModel trip,
    TextEditingController nombreCompra,
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController costoM2,
    TextEditingController ventaM1,
    ColorScheme colors,
    singleton) {
  return DataTable(
      columnSpacing: 5,
      border: TableBorder.all(
          width: 1,
          borderRadius: BorderRadius.circular(5),
          style: BorderStyle.solid),
      dataRowColor: WidgetStatePropertyAll(colors.primary),
      dataRowMinHeight: 20,
      dataRowMaxHeight: 30,
      headingRowColor: WidgetStatePropertyAll(colors.tertiary),
      headingRowHeight: 40,
      headingTextStyle: TextStyle(color: colors.onSecondary),
      columns: const [
        DataColumn(
            label: Text("PRODUCTO",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9))),
        DataColumn(
            label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("PESO",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9)),
            Text("TOTAL",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9))
          ],
        )),
        DataColumn(
            label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("CANTIDAD",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9)),
            Text("UNIDADES",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9))
          ],
        )),
        DataColumn(
            label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("COSTO",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9)),
            Text("TOTAL",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9)),
            Text("USD",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9))
          ],
        )),
        DataColumn(
            label: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("GANANCIA",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9)),
            Text("TOTAL",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9)),
            Text("USD",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9))
          ],
        )),
        DataColumn(
            label: Text("ELIMINAR",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9)))
      ],
      rows: lista
          .map((data) => DataRow(cells: [
                DataCell(
                  Text(data.compraNombre,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 9)),
                  showEditIcon: true,
                  onTap: () => actualizarCompra(context, data, nombreCompra,
                      cantU, pesoT, costoM2, ventaM1, trip,
                      singleton: singleton),
                ),
                DataCell(Text(data.pesoT.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 9))),
                DataCell(Text(data.cantU.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 9))),
                DataCell(Text(
                    (data.compraPrecio / trip.coin2Price!).toStringAsFixed(2),
                    textAlign: TextAlign.center,
                    style:
                        const TextStyle(fontSize: 9, color: Colors.redAccent))),
                DataCell(Text(
                    ((data.ventaCUPXUnidad * data.cantU) / trip.coin1Price!)
                        .toStringAsFixed(2),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 9, color: Color.fromARGB(255, 8, 95, 53)))),
                DataCell(IconButton(
                    onPressed: () => eliminarCompra(context, data, trip,
                        singleton: singleton),
                    icon: const Icon(
                      Icons.delete,
                      size: 15,
                    )))
              ]))
          .toList());
}

Widget tablaGastos(
    List<GastoModel> lista,
    context,
    trip,
    TextEditingController descripcionGasto,
    TextEditingController costoGastoD,
    colors,
    singleton) {
  return DataTable(
      columnSpacing: 10,
      border: TableBorder.all(
          width: 1,
          borderRadius: BorderRadius.circular(5),
          style: BorderStyle.solid),
      dataRowColor: WidgetStatePropertyAll(colors.primary),
      dataRowMinHeight: 20,
      dataRowMaxHeight: 30,
      headingRowColor: WidgetStatePropertyAll(colors.tertiary),
      headingRowHeight: 40,
      headingTextStyle: TextStyle(color: colors.onSecondary),
      columns: const [
        DataColumn(
            label: Text("DESCRIPCION",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9))),
        DataColumn(
            label: Text("GASTO",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9))),
        DataColumn(
            label: Text("ELIMINAR",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 9)))
      ],
      rows: lista
          .map((data) => DataRow(cells: [
                DataCell(
                  Text(data.gastoDescripcion,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 9)),
                  showEditIcon: true,
                  onTap: () => actualizarGasto(
                      context, data, descripcionGasto, costoGastoD, trip,
                      singleton: singleton),
                ),
                DataCell(Text(data.gastoMoney.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 9))),
                DataCell(IconButton(
                    onPressed: () => eliminarGasto(context, data, trip,
                        singleton: singleton),
                    icon: const Icon(Icons.delete),
                    iconSize: 15))
              ]))
          .toList());
}
