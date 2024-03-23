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

  nombreViaje.value = TextEditingValue(text: trip.tripName);

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
      TextFormField(
        controller: precioM1,
        maxLength: 20,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 14),
      ),
      TextFormField(
        controller: precioM2,
        maxLength: 20,
        keyboardType: TextInputType.text,
        style: const TextStyle(fontSize: 14),
      ),
      FutureBuilder(
        future: getCompras(trip.tripID),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Text("Sin compras");
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(snapshot.data[i]['nombre_compra']),
                leading: IconButton(
                    onPressed: () => actualizarCompra(snapshot.data[i]),
                    icon: Icon(Icons.ac_unit)),
                trailing: IconButton(
                  onPressed: () => eliminarCompra(snapshot.data[i]),
                  icon: Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
      TextButton(
          onPressed: () => agregarCompra(), child: Text("Agregar compra")),
      FutureBuilder(
        future: getGastos(trip.tripID),
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text("Sin gastos");
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(snapshot.data![i].gastoDescripcion),
                  leading: IconButton(
                      onPressed: () => actualizarGasto(snapshot.data![i].id),
                      icon: Icon(Icons.ac_unit)),
                  trailing: IconButton(
                    onPressed: () => eliminarGasto(snapshot.data![i].id),
                    icon: Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
      TextButton(onPressed: () => agregarGasto(), child: Text("Agregar gasto")),
      Text(gastoT.toString()),
      Text(gastoCompras.toString()),
      Text(gastoComprasKilo.toString()),
      Text(gastoOtros.toString()),
      Text(gananciaReal.toString()),
      Text(gananciaKilo.toString()),
      Text(rentabilidadR.toString()),
      Text(rentabilidadKilo.toString()),
      Text(rentabilidadPorcentual.toString()),
    ],
  );
}

void actualizarCompra(compra) {}

void agregarCompra() {}

void eliminarCompra(compra) {}

void actualizarGasto(gasto) {}

void agregarGasto() {}

void eliminarGasto(gasto) {}

Future<List<CompraModel>> getCompras(int id) async {
  return DB.getComprasTrip(id);
}

Future<List<GastoModel>> getGastos(int id) async {
  return DB.getGastosTrip(id);
}
