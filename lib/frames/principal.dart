import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/frames/trip_control.dart';
import 'package:trip_control_app/frames/trip_data.dart';
import 'package:trip_control_app/frames/trip_list.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/tuple.dart';

class Principal extends StatelessWidget {
  Principal({Key? key}) : super(key: key);
  TripModel trip = TripModel.nullTrip();
  int activo = 0;

  revisarViaje() async {
    int id = await DB.getLastIDTrip();
    if (await DB.verifyActiveTrip(id)) {
      trip = await DB.getTripByID(id);
      activo = 1;
    }
  }

  @override
  Widget build(BuildContext context) {
    revisarViaje();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Control de viajes",
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: const Color.fromARGB(255, 47, 128, 182),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Lista de viajes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text('Calculadora', style: TextStyle(fontSize: 16)),
              ),
              Tab(
                child: Text('Control de viaje', style: TextStyle(fontSize: 16)),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            const TripList(),
            const Calculator(),
            TripControl(Tuple(T: activo, K: trip))
          ],
        ),
      ),
    );
  }
}
