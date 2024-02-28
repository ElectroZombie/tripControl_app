import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/utils/tuple.dart';

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
                    Text("No hay viajes disponibles"),
                    TextButton(
                        onPressed: () => {
                              Navigator.popAndPushNamed(context, '/TripControl',
                                  arguments: Tuple(T: true, K: null))
                            },
                        child: Text("Crear viaje"))
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length - 1,
                  itemBuilder: (context, r) {
                    return Column(
                      children: [
                        ListTile(
                          title: snapshot.data[r].tripName,
                          leading: IconButton(
                              onPressed: () => {
                                    Navigator.pushNamed(context, '/TripData',
                                        arguments: snapshot.data[r].tripID)
                                  },
                              icon: Icon(Icons.arrow_circle_right_outlined)),
                        ),
                        SizedBox(
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
        ),
      ],
    );
  }
}

Widget nuevoViaje(snapshot, context) {
  if (!snapshot.data[snapshot.data.length].activo) {
    return TextButton(
        onPressed: () => {
              Navigator.popAndPushNamed(context, '/TripControl',
                  arguments: Tuple(T: true, K: null))
            },
        child: Text("Crear viaje"));
  }
  return SizedBox(
    height: 1,
  );
}
