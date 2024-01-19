import 'package:flutter/material.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';

class TripList extends StatefulWidget {
  const TripList({Key? key}) : super(key: key);

  @override
  TripListState createState() => TripListState();
}

class TripListState extends State<TripList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de viaje'),
      ),
      body: Stack(
        children: [
          gradient(),
          SingleChildScrollView(),
        ],
      ),
    );
  }
}
