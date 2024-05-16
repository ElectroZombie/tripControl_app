import 'package:flutter/material.dart';
import 'package:trip_control_app/methods/compras_methods.dart';
import 'package:trip_control_app/methods/gastos_methods.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';

Widget dataTripWidget(TripModel data, context) {
  return SingleChildScrollView(
      child: Center(
          child: SizedBox(
              width: (MediaQuery.of(context).size.width * 9.2) / 10,
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
                  subtitle: Text(
                    data.tripName,
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
                  subtitle: Text(
                    data.coin1Price!.toStringAsFixed(2),
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
                  subtitle: Text(
                    data.coin2Price!.toStringAsFixed(2),
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
                    items: [
                      DropdownMenuItem(
                        child: Text(data.nombrePais!),
                        value: data.nombrePais,
                      )
                    ],
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
                    value: data.nombrePais!,
                    onChanged: (value) {},
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
                  subtitle: Text(data.fechaInicioViaje.toString()),
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
                  subtitle: fechaFinalWidget(data.fechaFinalViaje!),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Compras",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Times new roman",
                  ),
                ),
                FutureBuilder(
                  future: getCompras(data.tripID),
                  initialData: Text("Sin compras",
                      style: TextStyle(fontSize: 20, color: Colors.redAccent)),
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
                          leading: SizedBox(
                            width: 20,
                          ),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  "Gastos",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Times new roman",
                  ),
                ),
                FutureBuilder(
                  future: getGastos(data.tripID),
                  initialData: Text("Sin gastos",
                      style: TextStyle(fontSize: 20, color: Colors.redAccent)),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        "Sin gastos",
                        style: TextStyle(fontSize: 20, color: Colors.redAccent),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as List<GastoModel>).length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            tileColor: Color.fromARGB(255, 63, 53, 92),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.elliptical(200, 85),
                                    right: Radius.elliptical(200, 85))),
                            title: Text(
                              (snapshot.data! as List<GastoModel>)[i]
                                  .gastoDescripcion,
                              style: TextStyle(color: Colors.black),
                            ),
                            subtitle: Text(
                              "Costo: ${(snapshot.data! as List<GastoModel>)[i].gastoMoney.toStringAsFixed(2)}",
                              style: TextStyle(color: Colors.black),
                            ),
                            leading: SizedBox(
                              width: 20,
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
                Center(
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 30 / 100,
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
                                data.gastoCompras!.toStringAsFixed(2),
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
                                data.gastoComprasXKilo!.toStringAsFixed(2),
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
                                data.otrosGastos!.toStringAsFixed(2),
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
                          title: const Text("Gasto total (En dólares)",
                              style: TextStyle(fontSize: 14)),
                          subtitle: Text(
                            data.gastoTotal.toStringAsFixed(2),
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
                                  data.gananciaComprasReal!.toStringAsFixed(2),
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
                                  data.gananciaComprasXKilo!.toStringAsFixed(2),
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
                      width: MediaQuery.of(context).size.width * 30 / 100,
                      child: ListTile(
                        tileColor: const Color.fromARGB(162, 90, 64, 102),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                        title: const Text("Rentabilidad (En dólares)",
                            style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          data.rentabilidad!.toStringAsFixed(2),
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
                        title: const Text(
                            "Rentabilidad por kilogramo (En dólares)",
                            style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          data.rentabilidadXKilo!.toStringAsFixed(2),
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
                        title: const Text(
                            "Rentabilidad porcentual (En dólares)",
                            style: TextStyle(fontSize: 14)),
                        subtitle: Text(
                          data.rentabilidadPorcentual!.toStringAsFixed(2),
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

Widget fechaFinalWidget(fecha) {
  if (fecha == "") {
    return Text("El viaje no se ha terminado");
  } else {
    return Text(fecha);
  }
}
