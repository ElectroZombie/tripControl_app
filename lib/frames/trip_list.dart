import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';

class TripList extends StatefulWidget {
  const TripList({Key? key}) : super(key: key);

  @override
  TripListState createState() => TripListState();
}

class TripListState extends State<TripList> {
  Future<List<TripModel>> loadTrips() async {
    return DB.getTrips();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        gradient(),
        SingleChildScrollView(
          child: FutureBuilder(
            future: loadTrips(),
            initialData: null,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (!snapshot.hasData || snapshot.data.length == 0) {
                return Column(
                  children: [
                    const Text("No hay viajes disponibles"),
                    TextButton(
                        onPressed: () =>
                            {Navigator.pushNamed(context, '/trip_control')},
                        child: const Text("Crear viaje"))
                  ],
                );
              } else {
                return Center(
                    child: SizedBox(
                        width: (MediaQuery.of(context).size.width * 7) / 10,
                        child: Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: snapshot.data.length,
                              itemBuilder: (context, r) {
                                TripModel viaje = snapshot.data[r];
                                return Column(
                                  children: [
                                    ListTile(
                                        tileColor:
                                            Color.fromARGB(255, 105, 89, 112),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        title: Text(
                                          "Nombre del viaje: ${viaje.tripName}"
                                          "\n Pais del viaje: ${viaje.nombrePais}"
                                          "\n Fechas del viaje: ${viaje.fechaInicioViaje} - ${viaje.fechaFinalViaje}",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                        leading: IconButton(
                                            onPressed: () => {
                                                  Navigator.pushNamed(
                                                      context, '/trip_data',
                                                      arguments: snapshot
                                                          .data[r].tripID)
                                                },
                                            hoverColor: Color.fromARGB(
                                                202, 14, 99, 139),
                                            tooltip: "Ver informacion",
                                            icon: const Icon(Icons
                                                .arrow_circle_right_outlined))),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                );
                              },
                            ),
                            nuevoViaje(snapshot, context),
                          ],
                        )));
              }
            },
          ),
        )
      ],
    );
  }
}

Widget nuevoViaje(snapshot, context) {
  if (snapshot.data[snapshot.data.length - 1].activo == 0) {
    return TextButton(
        onPressed: () => {Navigator.pushNamed(context, '/trip_control')},
        child: const Text("Crear viaje"));
  }
  return const SizedBox(
    height: 1,
  );
}
