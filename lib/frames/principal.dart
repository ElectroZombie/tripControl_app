import 'package:flutter/material.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/frames/trip_data.dart';
import 'package:trip_control_app/frames/trip_list.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text('Calculadora'),
              ),
              Tab(
                child: Text('Lista de viajes'),
              ),
              Tab(
                child: Text('Control de viaje'),
              ),
            ],
          ),
        ),
        body: TabBarView(children: [Calculator(), TripList(), TripData()]),
      ),
    );
  }
}
