import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db.dart';
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
        FutureBuilder(
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
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, r) {
                  return Column(
                    children: [
                      ListTile(
                        title: Text(snapshot.data[r].tripName),
                        leading: IconButton(
                            onPressed: () => {
                                  Navigator.pushNamed(context, '/trip_data',
                                      arguments: snapshot.data[r].tripID)
                                },
                            icon:
                                const Icon(Icons.arrow_circle_right_outlined)),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      nuevoViaje(snapshot, context),
                    ],
                  );
                },
              );
            }
          },
        ),
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
