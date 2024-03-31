import 'package:flutter/material.dart';
import 'package:trip_control_app/methods/compras_methods.dart';
import 'package:trip_control_app/methods/gastos_methods.dart';
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

  return SingleChildScrollView(
      child: Column(
    children: [
      ListTile(
        title: const Text("nombre del viaje"),
        subtitle: TextFormField(
          controller: nombreViaje,
          maxLength: 20,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      ListTile(
        title: const Text("Precio de la moneda nacional"),
        subtitle: TextFormField(
          controller: precioM1,
          maxLength: 20,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      ListTile(
        title: const Text("Precio de la moneda foranea"),
        subtitle: TextFormField(
          controller: precioM2,
          maxLength: 20,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      FutureBuilder(
        future: getCompras(trip.tripID),
        initialData: null,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Text("Sin compras");
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int i) {
              return ListTile(
                title: Text(snapshot.data[i].compraNombre),
                leading: IconButton(
                    onPressed: () => actualizarCompra(context, snapshot.data[i],
                        nombreCompra, cantU, pesoT, costoM2, ventaM1),
                    icon: const Icon(Icons.ac_unit)),
                trailing: IconButton(
                  onPressed: () => eliminarCompra(context, snapshot.data[i]),
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          );
        },
      ),
      TextButton(
          onPressed: () => agregarCompra(
              context, nombreCompra, cantU, pesoT, costoM2, ventaM1),
          child: const Text("Agregar compra")),
      const SizedBox(
        height: 30,
      ),
      FutureBuilder(
        future: getGastos(trip.tripID),
        initialData: null,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Text("Sin gastos");
          } else {
            return ListView.builder(
              shrinkWrap: true,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, i) {
                return ListTile(
                  title: Text(snapshot.data![i].gastoDescripcion),
                  leading: IconButton(
                      onPressed: () => actualizarGasto(context,
                          snapshot.data![i], descripcionGasto, costoGastoD),
                      icon: const Icon(Icons.ac_unit)),
                  trailing: IconButton(
                    onPressed: () =>
                        eliminarGasto(context, snapshot.data![i].id),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
      TextButton(
          onPressed: () => agregarGasto(context, descripcionGasto, costoGastoD),
          child: const Text("Agregar gasto")),
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
  ));
}
