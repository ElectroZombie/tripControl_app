import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/frames/trip_frames/trip_list.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key}) : super(key: key);

  void goToTripControl(context) async {
    int idTrip = await DB.getLastIDTrip();
    await DB.verifyActiveTrip(idTrip).then((value) {
      if (value) {
        Navigator.pushNamed(context, '/current_trip_control');
      } else {
        Navigator.pushNamed(context, '/new_trip_control');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    int initIndex = 0;
    var arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null) {
      initIndex = 1;
    }
    return DefaultTabController(
      length: 2,
      initialIndex: initIndex,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () => goToTripControl(context),
                child: const Text("Control de viaje actual"))
          ],
          title: const Text(
            "Control de viajes",
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: const Color.fromARGB(255, 47, 128, 182),
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text(
                  'Calculadora',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text('Lista de viajes', style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
        body: const TabBarView(
          children: [Calculator(), TripList()],
        ),
      ),
    );
  }
}
