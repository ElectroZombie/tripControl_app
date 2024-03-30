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

  return SingleChildScrollView(
      child: Column(
    children: [
      ListTile(
        title: Text("nombre del viaje"),
        subtitle: TextFormField(
          controller: nombreViaje,
          maxLength: 20,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      ListTile(
        title: Text("Precio de la moneda nacional"),
        subtitle: TextFormField(
          controller: precioM1,
          maxLength: 20,
          keyboardType: TextInputType.text,
          style: const TextStyle(fontSize: 14),
        ),
      ),
      ListTile(
        title: Text("Precio de la moneda foranea"),
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
                      onPressed: () => actualizarGasto(snapshot.data![i].id),
                      icon: const Icon(Icons.ac_unit)),
                  trailing: IconButton(
                    onPressed: () => eliminarGasto(snapshot.data![i].id),
                    icon: const Icon(Icons.delete),
                  ),
                );
              },
            );
          }
        },
      ),
      TextButton(
          onPressed: () => agregarGasto(), child: const Text("Agregar gasto")),
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

Future<void> actualizarCompra(
    context,
    CompraModel compra,
    TextEditingController nombreCompra,
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController costoM2,
    TextEditingController ventaM1) async {
  nombreCompra.value = TextEditingValue(text: compra.compraNombre);
  cantU.value = TextEditingValue(text: compra.cantU.toString());
  pesoT.value = TextEditingValue(text: compra.pesoT.toString());
  costoM2.value = TextEditingValue(text: compra.compraPrecio.toString());
  ventaM1.value = TextEditingValue(text: compra.ventaCUPXUnidad.toString());

  _actualizarCompra() async {
    CompraModel compraAct = CompraModel(
        tripID: compra.tripID,
        id: compra.id,
        compraNombre: nombreCompra.value.text,
        cantU: int.parse(cantU.value.text),
        pesoT: double.parse(pesoT.value.text),
        compraPrecio: double.parse(costoM2.value.text),
        ventaCUPXUnidad: double.parse(ventaM1.value.text));
    await DB.updateCompra(compraAct);
    Navigator.pushReplacementNamed(context, '/trip_control');
  }

  await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Actualizar compra'),
        content: Column(
          children: [
            TextFormField(
              controller: nombreCompra,
            ),
            TextFormField(
              controller: cantU,
            ),
            TextFormField(
              controller: pesoT,
            ),
            TextFormField(
              controller: costoM2,
            ),
            TextFormField(
              controller: ventaM1,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _actualizarCompra();
              Navigator.pop(
                  context); // Cerrar el diálogo y pasar la unidad ingresada
            },
            child: const Text('Confirmar'),
          ),
        ],
      );
    },
  );
}

Future<void> agregarCompra(
    BuildContext context,
    TextEditingController nombreCompra,
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController costoM2,
    TextEditingController ventaM1) async {
  nombreCompra.clear;
  cantU.clear;
  pesoT.clear;
  costoM2.clear;
  ventaM1.clear;

  _agregarCompra() async {
    CompraModel compraAct = CompraModel(
        tripID: await DB.getLastIDTrip(),
        id: (await DB.getLastIDCompra()) + 1,
        compraNombre: nombreCompra.value.text,
        cantU: int.parse(cantU.value.text),
        pesoT: double.parse(pesoT.value.text),
        compraPrecio: double.parse(costoM2.value.text),
        ventaCUPXUnidad: double.parse(ventaM1.value.text));
    await DB.insertNewCompra(compraAct);
    Navigator.pushReplacementNamed(context, '/trip_control');
  }

  await showDialog<String>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Actualizar compra'),
        content: Column(
          children: [
            Text("Nombre del producto"),
            TextFormField(
              controller: nombreCompra,
            ),
            Text("Cantidad de unidades"),
            TextFormField(
              controller: cantU,
            ),
            Text("Peso total"),
            TextFormField(
              controller: pesoT,
            ),
            Text("Costo en moneda foranea"),
            TextFormField(
              controller: costoM2,
            ),
            Text("Precio de venta en moneda nacional"),
            TextFormField(
              controller: ventaM1,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _agregarCompra();
              Navigator.pop(
                  context); // Cerrar el diálogo y pasar la unidad ingresada
            },
            child: const Text('Confirmar'),
          ),
        ],
      );
    },
  );
}

Future<void> eliminarCompra(context, CompraModel compra) async {
  _eliminarCompra(CompraModel compra) async {
    await DB.deleteCompra(compra.id);
    Navigator.pushReplacementNamed(context, '/trip_control');
  }

  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("Eliminar compra"),
        content: Text("Esta seguro de que desea eliminar la compra?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Cerrar el diálogo sin agregar la unidad
            },
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              _eliminarCompra(compra);
              Navigator.pop(
                  context); // Cerrar el diálogo y pasar la unidad ingresada
            },
            child: const Text('Confirmar'),
          ),
        ],
      );
    },
  );
}

void actualizarGasto(gasto) {}

void agregarGasto() {}

void eliminarGasto(gasto) {}

Future<List<CompraModel>> getCompras(int id) async {
  return DB.getComprasTrip(id);
}

Future<List<GastoModel>> getGastos(int id) async {
  return DB.getGastosTrip(id);
}
