import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/methods/compras_methods.dart';
import 'package:trip_control_app/methods/gastos_methods.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/calculo_rentabilidad.dart';
import 'package:trip_control_app/widgets/drop_down_search_widget.dart';

Widget currentTripWidget(
    TripModel trip,
    List<String> paises,
    TextEditingController nombreViaje,
    TextEditingController precioM1,
    TextEditingController precioM2,
    TextEditingController nombreCompra,
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController costoM2,
    TextEditingController ventaM1,
    TextEditingController descripcionGasto,
    TextEditingController costoGastoD,
    TextEditingController nombrePais,
    context) {
  nombreViaje.value = TextEditingValue(text: trip.tripName);
  precioM1.value = TextEditingValue(text: trip.coin1Price!.toStringAsFixed(2));
  precioM2.value = TextEditingValue(text: trip.coin2Price!.toStringAsFixed(2));

  return SingleChildScrollView(
      child: Center(
          child: SizedBox(
              width: (MediaQuery.of(context).size.width * 9.2) / 10,
              child: Column(children: [
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  title: const Text(
                    "NOMBRE DEL VIAJE:",
                    style: TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(255, 255, 255, 255)),
                  ),
                  tileColor: const Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  subtitle: TextFormField(
                    controller: nombreViaje,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(fontSize: 14),
                    onFieldSubmitted: (value) =>
                        _updateNombreViaje(trip, value, context),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: const Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text("PRECIO DEL USD EN CUP:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: TextFormField(
                    controller: precioM1,
                    maxLength: 20,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                    onFieldSubmitted: (value) =>
                        _updatePrecioM1(trip, value, context),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: const Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text("PRECIO DEL USD EN MONEDA EXTRANJERA:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: TextFormField(
                    controller: precioM2,
                    maxLength: 20,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(fontSize: 14),
                    onFieldSubmitted: (value) =>
                        _updatePrecioM2(trip, value, context),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: const Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  subtitle: dropDownSearchCurrent(
                      paises, nombrePais, trip, context, updatePais),
                  /* DropdownButtonFormField<String>(
                    items: List.generate(
                        paises.length,
                        (i) => DropdownMenuItem(
                              value: paises[i],
                              child: Text(paises[i]),
                            )),
                    decoration: InputDecoration(
                      icon: const Icon(
                        Icons.map_outlined,
                        color: Colors.black,
                      ),
                      labelStyle: const TextStyle(
                          fontSize: 20,
                          color: Color.fromARGB(255, 255, 255, 255)),
                      labelText: 'PAÍS DE DESTINO:',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(40)),
                    ),
                    value: trip.nombrePais,
                    onChanged: (value) {
                      _updatePais(value!, trip.tripID, context);
                    },
                  ),*/
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: const Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text("FECHA DE INICIO DEL VIAJE:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: Text(trip.fechaInicioViaje!.split(" ").first),
                  leading: TextButton(
                      onPressed: () => _selectDateInicio(
                          context, trip.tripID, trip.fechaInicioViaje!),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: const Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  title: const Text("FECHA DE FINAL DEL VIAJE:",
                      style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 255, 255, 255))),
                  subtitle: Text(trip.fechaFinalViaje!.split(" ").first),
                  leading: TextButton(
                      onPressed: () => _selectDateFinal(
                          context, trip.tripID, trip.fechaFinalViaje!),
                      child: const Icon(
                        Icons.calendar_month_rounded,
                        color: Colors.black,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "COMPRAS:",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Times new roman",
                  ),
                ),
                FutureBuilder(
                  future: getCompras(trip.tripID),
                  initialData: null,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        "SIN COMPRAS",
                        style: TextStyle(fontSize: 20, color: Colors.redAccent),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int i) {
                        return ListTile(
                          tileColor: const Color.fromARGB(255, 63, 53, 92),
                          shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.horizontal(
                                  left: Radius.elliptical(200, 85),
                                  right: Radius.elliptical(200, 85))),
                          title: Text(
                              "PRODUCTO: ${snapshot.data[i].compraNombre}"),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "RENTABILIDAD DEL PRODUCTO: ${calculoRentabilidad(snapshot.data[i].cantU, snapshot.data[i].pesoT, snapshot.data[i].compraPrecio, snapshot.data[i].ventaCUPXUnidad, double.parse(precioM1.value.text), double.parse(precioM2.value.text)).T.toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.black, letterSpacing: -1.5),
                              )
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
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: ButtonStyle(
                        fixedSize: const WidgetStatePropertyAll(Size(150, 50)),
                        backgroundColor: WidgetStateColor.resolveWith(
                            (states) =>
                                const Color.fromARGB(161, 255, 255, 255)),
                        overlayColor: WidgetStateColor.resolveWith((states) =>
                            const Color.fromARGB(99, 104, 58, 183))),
                    onPressed: () => agregarCompra(context, nombreCompra, cantU,
                        pesoT, costoM2, ventaM1, trip),
                    child: const Text(
                      "AGREGAR COMPRA",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "GASTOS:",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Times new roman",
                  ),
                ),
                FutureBuilder(
                  future: getGastos(trip.tripID),
                  initialData: null,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        "SIN GASTOS",
                        style: TextStyle(fontSize: 20, color: Colors.redAccent),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            tileColor: const Color.fromARGB(255, 63, 53, 92),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.elliptical(200, 85),
                                    right: Radius.elliptical(200, 85))),
                            title: Text(
                              snapshot.data![i].gastoDescripcion,
                              style: const TextStyle(
                                  color: Colors.black, letterSpacing: -1.5),
                            ),
                            subtitle: Text(
                              "GASTO: ${snapshot.data![i].gastoMoney.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Colors.black, letterSpacing: -1.5),
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
                const SizedBox(
                  height: 20,
                ),
                TextButton(
                    style: ButtonStyle(
                        fixedSize: const WidgetStatePropertyAll(Size(150, 50)),
                        backgroundColor: WidgetStateColor.resolveWith(
                            (states) =>
                                const Color.fromARGB(161, 255, 255, 255)),
                        overlayColor: WidgetStateColor.resolveWith((states) =>
                            const Color.fromARGB(99, 104, 58, 183))),
                    onPressed: () => agregarGasto(
                        context, descripcionGasto, costoGastoD, trip),
                    child: const Text(
                      "AGREGAR GASTO",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 30 / 100,
                        child: Column(
                          children: [
                            const Text(
                              "GASTOS (USD)",
                              style: TextStyle(
                                fontSize: 24,
                                fontFamily: "Times new roman",
                              ),
                            ),
                            ListTile(
                              tileColor: const Color.fromARGB(162, 90, 64, 102),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: const Text("GASTO OCUPADO EN COMPRAS",
                                  style: TextStyle(
                                      fontSize: 14, letterSpacing: -1.5)),
                              subtitle: Text(
                                trip.gastoCompras!.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              tileColor: const Color.fromARGB(162, 90, 64, 102),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: const Text("GASTO OCUPADO EN COMPRAS (KG)",
                                  style: TextStyle(
                                      fontSize: 14, letterSpacing: -1.5)),
                              subtitle: Text(
                                trip.gastoComprasXKilo!.toStringAsFixed(2),
                                style: const TextStyle(
                                    fontSize: 16, color: Colors.black),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ListTile(
                              tileColor: const Color.fromARGB(162, 90, 64, 102),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30)),
                              title: const Text("OTROS GASTOS",
                                  style: TextStyle(
                                      fontSize: 14, letterSpacing: -1.5)),
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
                        width: MediaQuery.of(context).size.width * 0.5 / 100,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 30 / 100,
                        child: ListTile(
                          tileColor: const Color.fromARGB(162, 90, 64, 102),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          title: const Text("GASTO TOTAL",
                              style:
                                  TextStyle(fontSize: 14, letterSpacing: -1.5)),
                          subtitle: Text(
                            trip.gastoTotal.toStringAsFixed(2),
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 / 100,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width * 30 / 100,
                          child: Column(
                            children: [
                              const Text(
                                "GANANCIA (USD)",
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
                                title: const Text("GANANCIA DE COMPRAS",
                                    style: TextStyle(
                                        fontSize: 14, letterSpacing: -1.5)),
                                subtitle: Text(
                                  trip.gananciaComprasReal!.toStringAsFixed(2),
                                  style: const TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              ListTile(
                                tileColor:
                                    const Color.fromARGB(162, 90, 64, 102),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                title: const Text("GANANCIA DE COMPRAS (KG)",
                                    style: TextStyle(
                                        fontSize: 14, letterSpacing: -1.5)),
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
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "RENTABILIDAD (USD)",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Times new roman",
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 30 / 100,
                      child: ListTile(
                        tileColor: const Color.fromARGB(162, 90, 64, 102),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        title: const Text("RENTABILIDAD",
                            style:
                                TextStyle(fontSize: 14, letterSpacing: -1.5)),
                        subtitle: Text(
                          trip.rentabilidad!.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5 / 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 30 / 100,
                      child: ListTile(
                        tileColor: const Color.fromARGB(162, 90, 64, 102),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        title: const Text("RENTABILIDAD (KG)",
                            style:
                                TextStyle(fontSize: 14, letterSpacing: -1.5)),
                        subtitle: Text(
                          trip.rentabilidadXKilo!.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5 / 100,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 30 / 100,
                      child: ListTile(
                        tileColor: const Color.fromARGB(162, 90, 64, 102),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        title: const Text("RENTABILIDAD (%)",
                            style:
                                TextStyle(fontSize: 14, letterSpacing: -1.5)),
                        subtitle: Text(
                          trip.rentabilidadPorcentual!.toStringAsFixed(2),
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ]))));
}

Future<void> _selectDateInicio(context, int idTrip, String selectedDate) async {
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.parse(selectedDate),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != selectedDate) {
    _updateFechaInicio(picked, idTrip, context);
  }
}

Future<void> _selectDateFinal(context, int idTrip, String selectedDate) async {
  if (selectedDate == "") {
    selectedDate = DateTime.now().toString();
  }
  final DateTime? picked = await showDatePicker(
    context: context,
    initialDate: DateTime.parse(selectedDate),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );
  if (picked != null && picked != selectedDate) {
    _updateFechaFinal(picked, idTrip, context);
  }
}

Future<void> updatePais(String pais, int idTrip, context) async {
  await DB.updatePaisTrip(idTrip, pais);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}

Future<void> _updateFechaInicio(DateTime date, int idTrip, context) async {
  await DB.updateFechaInicioTrip(idTrip, date);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}

Future<void> _updateFechaFinal(DateTime date, int idTrip, context) async {
  await DB.updateFechaFinalTrip(idTrip, date);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}

Future<void> _updateNombreViaje(
    TripModel trip, String nombreViaje, context) async {
  trip.tripName = nombreViaje;
  DB.updateTrip(trip);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}

Future<void> _updatePrecioM1(TripModel trip, String precioM1, context) async {
  trip.setCoin1Price(double.parse(precioM1));
  DB.updateTrip(trip);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}

Future<void> _updatePrecioM2(TripModel trip, String precioM2, context) async {
  trip.setCoin2Price(double.parse(precioM2));
  DB.updateTrip(trip);
  Navigator.pushReplacementNamed(context, '/current_trip_control');
}
