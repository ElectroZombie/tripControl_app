import 'package:flutter/material.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/widgets/trip_widgets/data_trip_widget.dart';

class TripData extends StatefulWidget {
  const TripData({Key? key}) : super(key: key);

  @override
  TripDataState createState() => TripDataState();
}

class TripDataState extends State<TripData> {
  TripModel data = TripModel.nullTrip();
  String textoViaje = "Nuevo viaje";

  void actViaje(Future<TripModel> trip) async {
    data = await trip;
    textoViaje =
        "Viaje actual: ${data.tripName} / ${data.nombrePais} / ${data.fechaInicioViaje}";

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Future<TripModel> trip =
        ModalRoute.of(context)!.settings.arguments as Future<TripModel>;
    actViaje(trip);
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: Text(
            textoViaje,
            style: TextStyle(fontSize: 20),
          ),
          centerTitle: true,
          backgroundColor: const Color.fromARGB(255, 47, 128, 182),
        ),
        body: Stack(
          children: [
            gradient(),
            Form(
              child: dataTripWidget(data, context),
            )
          ],
        ));
  }
}
