import 'package:flutter/material.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';

class TripControl extends StatefulWidget {
  const TripControl(viaje, {Key? key}) : super(key: key);

  @override
  TripControlState createState() => TripControlState();
}

class TripControlState extends State<TripControl> {
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
