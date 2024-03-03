import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db.dart';
import 'package:trip_control_app/models/compra_model.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';

Widget currentTripWidget(TripModel trip, context) {
  TextEditingController nombreViaje = TextEditingController();
  TextEditingController precioM1 = TextEditingController();
  TextEditingController precioM2 = TextEditingController();
  TextEditingController nombreCompra = TextEditingController();
  TextEditingController cantU = TextEditingController();
  TextEditingController pesoT = TextEditingController();
  TextEditingController costoM2 = TextEditingController();
  TextEditingController ventaM1 = TextEditingController();
  TextEditingController descripcionGasto = TextEditingController();
  TextEditingController costoGastoD = TextEditingController();

  double gastoT = 0.0;
  double gastoCompras = 0.0;
  double gastoComprasKilo = 0.0;
  double gastoOtros = 0.0;
  double gananciaReal = 0.0;
  double gananciaKilo = 0.0;
  double rentabilidadR = 0.0;
  double rentabilidadKilo = 0.0;
  double rentabilidadPorcentual = 0.0;

  //List<GastoModel> gastos = getGastos(trip.tripID);

  return Column(
    children: [
      TextFormField(
        controller: nombreViaje,
        maxLength: 20,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 14),
      ),
      FutureBuilder(
        future: getCompras(trip.tripID),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(snapshot.data[i]['nombre_compra']),
              );
            },
          );
        },
      ),
    ],
  );
}

Future<List<CompraModel>> getCompras(int id) async {
  return DB.getComprasTrip(id);
}
