import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/methods/compras_methods.dart';
import 'package:trip_control_app/methods/gastos_methods.dart';
import 'package:trip_control_app/models/trip_model.dart';

Widget currentTripWidget(TripModel trip, List<String> paises, context) {
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
  precioM1.value = TextEditingValue(text: trip.coin1Price!.toStringAsFixed(2));
  precioM2.value = TextEditingValue(text: trip.coin2Price!.toStringAsFixed(2));

  return SingleChildScrollView(
      child: Center(
          child: SizedBox(
              width: (MediaQuery.of(context).size.width * 7) / 10,
              child: Column(children: [
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text(
                    "Nombre del viaje:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  tileColor: Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  subtitle: TextFormField(
                    controller: nombreViaje,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text("Precio de la moneda nacional: (En CUP)",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: TextFormField(
                    controller: precioM1,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text("Precio de la moneda extranjera:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: TextFormField(
                    controller: precioM2,
                    maxLength: 20,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  subtitle: DropdownButtonFormField<String>(
                    items: List.generate(
                        paises.length,
                        (i) => DropdownMenuItem(
                              child: Text(paises[i]),
                              value: paises[i],
                            )),
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.map_outlined,
                        color: Colors.black,
                      ),
                      labelStyle: TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      labelText: 'País de destino:',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    value: trip.nombrePais,
                    onChanged: (value) {
                      _updatePais(value!, trip.tripID, context);
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text("Fecha de inicio del viaje:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: Text(trip.fechaInicioViaje.toString()),
                  leading: TextButton(
                      onPressed: () => _selectDateInicio(
                          context, trip.tripID, trip.fechaInicioViaje),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: Text("Fecha de final del viaje:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: Text(trip.fechaFinalViaje.toString()),
                  leading: TextButton(
                      onPressed: () => _selectDateFinal(
                          context, trip.tripID, trip.fechaFinalViaje),
                      child: Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black,
                      )),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: ButtonStyle(
                        fixedSize:
                            const MaterialStatePropertyAll(Size(150, 50)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) =>
                                const Color.fromARGB(161, 255, 255, 255)),
                        overlayColor: MaterialStateColor.resolveWith((states) =>
                            const Color.fromARGB(99, 104, 58, 183))),
                    onPressed: () {
                      trip.setCoin2Price(double.parse(precioM2.value.text));
                      trip.setCoin1Price(double.parse(precioM1.value.text));
                      trip.tripName = nombreViaje.value.text;
                      DB.updateTrip(trip);
                      Navigator.pushReplacementNamed(context, '/trip_control');
                    },
                    child: Text(
                      "Actualizar Valores",
                      style: TextStyle(fontSize: 16, letterSpacing: -0.9),
                    )),
                SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: getCompras(trip.tripID),
                  initialData: null,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        "Sin compras",
                        style: TextStyle(fontSize: 20, color: Colors.redAccent),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          tileColor: Color.fromARGB(255, 63, 53, 92),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.elliptical(200, 85),
                                  right: Radius.elliptical(200, 85))),
                          title: Text(
                              "Nombre del producto: ${snapshot.data[i].compraNombre}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Costo de la compra en la moneda extranjera: ${snapshot.data[i].compraPrecio.toStringAsFixed(2)}",
                                style: TextStyle(color: Colors.black),
                              ),
                              Text(
                                  "Precio de venta en CUP: ${snapshot.data[i].ventaCUPXUnidad.toStringAsFixed(2)},",
                                  style: TextStyle(color: Colors.black)),
                            ],
                          ),
                          leading: IconButton(
                              onPressed: () => actualizarCompra(
                                  context,
                                  snapshot.data[i],
                                  nombreCompra,
                                  cantU,
                                  pesoT,
                                  costoM2,
                                  ventaM1,
                                  trip),
                              icon: const Icon(Icons.update)),
                          trailing: IconButton(
                            onPressed: () =>
                                eliminarCompra(context, snapshot.data[i], trip),
                            icon: const Icon(Icons.delete),
                          ),
                        );
                      },
                    );
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: ButtonStyle(
                        fixedSize:
                            const MaterialStatePropertyAll(Size(150, 50)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) =>
                                const Color.fromARGB(161, 255, 255, 255)),
                        overlayColor: MaterialStateColor.resolveWith((states) =>
                            const Color.fromARGB(99, 104, 58, 183))),
                    onPressed: () => agregarCompra(context, nombreCompra, cantU,
                        pesoT, costoM2, ventaM1, trip),
                    child: const Text(
                      "Agregar compra",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                FutureBuilder(
                  future: getGastos(trip.tripID),
                  initialData: null,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        "Sin gastos",
                        style: TextStyle(fontSize: 20, color: Colors.redAccent),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            tileColor: Color.fromARGB(255, 63, 53, 92),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.elliptical(200, 85),
                                    right: Radius.elliptical(200, 85))),
                            title: Text(
                              snapshot.data![i].gastoDescripcion,
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              "Costo: ${snapshot.data![i].gastoMoney.toStringAsFixed(2)}",
                              style: TextStyle(color: Colors.black),
                            ),
                            leading: IconButton(
                                onPressed: () => actualizarGasto(
                                    context,
                                    snapshot.data![i],
                                    descripcionGasto,
                                    costoGastoD,
                                    trip),
                                icon: const Icon(Icons.update)),
                            trailing: IconButton(
                              onPressed: () => eliminarGasto(
                                  context, snapshot.data![i], trip),
                              icon: const Icon(Icons.delete),
                            ),
                          );
                        },
                      );
                    }
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: ButtonStyle(
                        fixedSize:
                            const MaterialStatePropertyAll(Size(150, 50)),
                        backgroundColor: MaterialStateColor.resolveWith(
                            (states) =>
                                const Color.fromARGB(161, 255, 255, 255)),
                        overlayColor: MaterialStateColor.resolveWith((states) =>
                            const Color.fromARGB(99, 104, 58, 183))),
                    onPressed: () => agregarGasto(
                        context, descripcionGasto, costoGastoD, trip),
                    child: const Text(
                      "Agregar gasto",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 22 / 100,
                        child: Column(
                          children: [
                            Text(
                              "Gastos",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Times new roman",
                              ),
                            ),
                            ListTile(
                              tileColor: const Color.fromARGB(162, 90, 64, 102),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: const Text(
                                  "Gasto ocupado en compras (En dólares)",
                                  style: TextStyle(fontSize: 14)),
                              subtitle: Text(
                                trip.gastoCompras!.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              tileColor: const Color.fromARGB(162, 90, 64, 102),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: const Text(
                                  "Gasto ocupado en compras, por kilogramo (En dólares)",
                                  style: TextStyle(fontSize: 14)),
                              subtitle: Text(
                                trip.gastoComprasXKilo!.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              tileColor: const Color.fromARGB(162, 90, 64, 102),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: const Text("Otros gastos (En dólares)",
                                  style: TextStyle(fontSize: 14)),
                              subtitle: Text(
                                trip.otrosGastos!.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 22 / 100,
                        child: ListTile(
                          tileColor: const Color.fromARGB(162, 90, 64, 102),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          title: const Text("Gasto total (En dólares)",
                              style: TextStyle(fontSize: 14)),
                          subtitle: Text(
                            trip.gastoTotal.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 2 / 100,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 22 / 100,
                          child: Column(
                            children: [
                              Text(
                                "Ganancia",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontFamily: "Times new roman",
                                ),
                              ),
                              ListTile(
                                tileColor:
                                    const Color.fromARGB(162, 90, 64, 102),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                title: const Text(
                                    "Ganancia real de las compras (En dólares)",
                                    style: TextStyle(fontSize: 14)),
                                subtitle: Text(
                                  trip.gananciaComprasReal!.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                tileColor:
                                    const Color.fromARGB(162, 90, 64, 102),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                title: const Text(
                                    "Ganancia de las compras, por kilogramo (En dólares)",
                                    style: TextStyle(fontSize: 14)),
                                subtitle: Text(
                                  trip.gananciaComprasXKilo!.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Rentabilidad",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Times new roman",
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 22 / 100,
                      child: ListTile(
                        tileColor: const Color.fromARGB(162, 90, 64, 102),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        title: const Text("Rentabilidad (En dólares)",
                            style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          trip.rentabilidad!.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 22 / 100,
                      child: ListTile(
                        tileColor: const Color.fromARGB(162, 90, 64, 102),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        title: const Text(
                            "Rentabilidad por kilogramo (En dólares)",
                            style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          trip.rentabilidadXKilo!.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 2 / 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 22 / 100,
                      child: ListTile(
                        tileColor: const Color.fromARGB(162, 90, 64, 102),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        title: const Text(
                            "Rentabilidad porcentual (En dólares)",
                            style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          trip.rentabilidadPorcentual!.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                )
              ]))));
}

Future<void> _selectDateInicio(context, int idTrip, selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != selectedDate) {
    _updateFechaInicio(picked, idTrip, context);
  }
}

Future<void> _selectDateFinal(context, int idTrip, selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: selectedDate,
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != selectedDate) {
    _updateFechaFinal(picked, idTrip, context);
  }
}

Future<void> _updatePais(String pais, int idTrip, context) async {
  await DB.updatePaisTrip(idTrip, pais);
  Navigator.pushReplacementNamed(context, '/trip_control');
}

Future<void> _updateFechaInicio(DateTime date, int idTrip, context) async {
  await DB.updateFechaInicioTrip(idTrip, date);
  Navigator.pushReplacementNamed(context, '/trip_control');
}

Future<void> _updateFechaFinal(DateTime date, int idTrip, context) async {
  await DB.updateFechaFinalTrip(idTrip, date);
  Navigator.pushReplacementNamed(context, '/trip_control');
}
