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
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "NO HAY VIAJES DISPONIBLES",
                            style: TextStyle(
                                fontSize: 24, fontFamily: 'Times new roman'),
                          ),
                          TextButton(
                              onPressed: () => {
                                    Navigator.pushNamed(
                                        context, '/new_trip_control')
                                  },
                              child: const Text("CREAR VIAJE"))
                        ],
                      ),
                    )
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
                                        tileColor: const Color.fromARGB(
                                            255, 105, 89, 112),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30)),
                                        title: Text(
                                          "${viaje.tripName}"
                                          "\n PAÍS DE DESTINO: ${viaje.nombrePais}"
                                          "\n FECHAS DEL VIAJE: ${viaje.fechaInicioViaje} -> ${viaje.fechaFinalViaje}"
                                          "\n RENTABILIDAD: ${viaje.rentabilidad}",
                                          style: const TextStyle(fontSize: 16),
                                        ),
                                        leading: IconButton(
                                            onPressed: () => {
                                                  Navigator.pushNamed(
                                                      context, '/trip_data',
                                                      arguments:
                                                          getCompleteTrip(
                                                              viaje.tripID))
                                                },
                                            hoverColor: const Color.fromARGB(
                                                202, 14, 99, 139),
                                            tooltip: "VER INFORMACIÓN",
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
                            const SizedBox(
                              height: 10,
                            )
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
        style: ButtonStyle(
            fixedSize: const WidgetStatePropertyAll(Size(150, 50)),
            backgroundColor: WidgetStateColor.resolveWith(
                (states) => const Color.fromARGB(161, 255, 255, 255)),
            overlayColor: WidgetStateColor.resolveWith(
                (states) => const Color.fromARGB(99, 104, 58, 183))),
        onPressed: () => {Navigator.pushNamed(context, '/new_trip_control')},
        child: const Text(
          "CREAR VIAJE",
          style: TextStyle(fontSize: 24),
        ));
  }
  return const SizedBox(
    height: 10,
  );
}

Future<TripModel> getCompleteTrip(int idTrip) async {
  return DB.getTripByID(idTrip);
}
