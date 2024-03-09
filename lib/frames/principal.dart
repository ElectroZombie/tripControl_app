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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () =>
                    {Navigator.pushNamed(context, '/trip_control')},
                child: Text("Control de viaje actual"))
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
                  'Lista de viajes',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Tab(
                child: Text('Calculadora', style: TextStyle(fontSize: 16)),
              )
            ],
          ),
        ),
        body: TabBarView(
          children: [const TripList(), const Calculator()],
        ),
      ),
    );
  }
}
