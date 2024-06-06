import 'package:flutter/material.dart';
import 'package:trip_control_app/methods/compras_methods.dart';
import 'package:trip_control_app/methods/gastos_methods.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/calculo_rentabilidad.dart';

Widget dataTripWidget(TripModel data, context) {
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
                  subtitle: Text(
                    data.tripName,
                    style: const TextStyle(fontSize: 14),
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
                  subtitle: Text(
                    data.coin1Price!.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 14),
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
                  subtitle: Text(
                    data.coin2Price!.toStringAsFixed(2),
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ListTile(
                  tileColor: const Color.fromARGB(255, 160, 121, 177),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  subtitle: DropdownButtonFormField<String>(
                    items: [
                      DropdownMenuItem(
                        value: data.nombrePais,
                        child: Text(data.nombrePais!),
                      )
                    ],
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
                    value: data.nombrePais!,
                    onChanged: (value) {},
                  ),
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
                  subtitle: Text(data.fechaInicioViaje!.split(" ").first),
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
                  subtitle:
                      fechaFinalWidget(data.fechaFinalViaje!.split(" ").first),
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
                  future: getCompras(data.tripID),
                  initialData: const Text("SIN COMPRAS",
                      style: TextStyle(fontSize: 20, color: Colors.redAccent)),
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
                                "RENTABILIDAD DEL PRODUCTO: ${(calculoRentabilidad(snapshot.data[i].cantU, snapshot.data[i].pesoT, snapshot.data[i].compraPrecio, snapshot.data[i].ventaCUPXUnidad, data.coin1Price!, data.coin2Price!).T).toStringAsFixed(2)}",
                                style: const TextStyle(
                                    color: Colors.black, letterSpacing: -1.5),
                              )
                            ],
                          ),
                          leading: const SizedBox(
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
                const Text(
                  "GASTOS:",
                  style: TextStyle(
                    fontSize: 24,
                    fontFamily: "Times new roman",
                  ),
                ),
                FutureBuilder(
                  future: getGastos(data.tripID),
                  initialData: const Text("SIN GASTOS",
                      style: TextStyle(fontSize: 20, color: Colors.redAccent)),
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const Text(
                        "SIN GASTOS",
                        style: TextStyle(fontSize: 20, color: Colors.redAccent),
                      );
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: (snapshot.data! as List<GastoModel>).length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            tileColor: const Color.fromARGB(255, 63, 53, 92),
                            shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.horizontal(
                                    left: Radius.elliptical(200, 85),
                                    right: Radius.elliptical(200, 85))),
                            title: Text(
                              (snapshot.data! as List<GastoModel>)[i]
                                  .gastoDescripcion,
                              style: const TextStyle(
                                  color: Colors.black, letterSpacing: -1.5),
                            ),
                            subtitle: Text(
                              "GASTO: ${(snapshot.data! as List<GastoModel>)[i].gastoMoney.toStringAsFixed(2)}",
                              style: const TextStyle(
                                  color: Colors.black, letterSpacing: -1.5),
                            ),
                            leading: const SizedBox(
                              width: 20,
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
                                data.gastoCompras!.toStringAsFixed(2),
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
                              title: const Text("GASTO OCUPADO EN COMPTAS (KG)",
                                  style: TextStyle(
                                      fontSize: 14, letterSpacing: -1.5)),
                              subtitle: Text(
                                data.gastoComprasXKilo!.toStringAsFixed(2),
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
                          title: const Text("GASTO TOTAL",
                              style:
                                  TextStyle(fontSize: 14, letterSpacing: -1.5)),
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
                                  data.gananciaComprasReal!.toStringAsFixed(2),
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
                        title: const Text("RENTABILIDAD (KG)",
                            style:
                                TextStyle(fontSize: 14, letterSpacing: -1.5)),
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
                        title: const Text("RENTABILIDAD (%)",
                            style:
                                TextStyle(fontSize: 14, letterSpacing: -1.5)),
                        subtitle: Text(
                          data.rentabilidadPorcentual!.toStringAsFixed(2),
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

Widget fechaFinalWidget(fecha) {
  if (fecha == "") {
    return const Text("EL VIAJE NO SE HA TERMINADO");
  } else {
    return Text(fecha);
  }
}
