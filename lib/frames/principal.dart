import 'package:flutter/material.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/frames/trip_list.dart';

class Principal extends StatelessWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          actions: [
            TextButton(
                onPressed: () =>
                    {Navigator.pushNamed(context, '/trip_control')},
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
