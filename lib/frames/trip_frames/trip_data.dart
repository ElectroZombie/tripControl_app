import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/utils/pdf_actions.dart';
import 'package:trip_control_app/widgets/trip_widgets/data_trip_widget.dart';

class TripData extends StatefulWidget {
  const TripData({Key? key}) : super(key: key);

  @override
  TripDataState createState() => TripDataState();
}

class TripDataState extends State<TripData> {
  TripModel data = TripModel.nullTrip();

  void _updateTrip(Future<TripModel> trip) async {
    data = await trip;
    setState(() {});
  }

  _deleteTrip(Future<TripModel> trip) async {
    data = await trip;
    await showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 111, 129, 155),
          title: const Text(
              "¿DESEA ELIMINAR EL VIAJE? \n SE  PERDERÁN TODOS LOS DATOS"),
          actions: [
            TextButton(
                onPressed: () {
                  DB.deleteTrip(data.tripID);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/', (route) => false,
                      arguments: true);
                },
                child: const Text("ACEPTAR")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CANCELAR"))
          ],
        );
      },
    );
  }

  _activateTrip(Future<TripModel> trip) async {
    data = await trip;

    await showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 111, 129, 155),
          title: const Text(
              "¿DESEA VOLVER A ACTIVAR EL VIAJE? \n ESTA ES UNA ACTIVACIÓN DE UNA SOLA VEZ"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/update_trip_singleton',
                      arguments: data);
                },
                child: const Text("ACEPTAR")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CANCELAR"))
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Future<TripModel> trip =
        ModalRoute.of(context)!.settings.arguments as Future<TripModel>;
    _updateTrip(trip);
    return Scaffold(
        appBar: AppBar(
          actions: [
            PopupMenuButton(
              tooltip: "MOSTRAR MENÚ",
              iconColor: Colors.white60,
              iconSize: 25,
              style: ButtonStyle(
                  overlayColor: WidgetStateColor.resolveWith(
                      (states) => const Color.fromARGB(99, 104, 58, 183))),
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text("EXPORTAR PDF"),
                    onTap: () => exportToPDF(trip, context),
                  ),
                  const PopupMenuItem(
                    height: 10,
                    enabled: false,
                    child: PopupMenuDivider(),
                  ),
                  PopupMenuItem(
                    child: const Text("ACTIVAR VIAJE"),
                    onTap: () => _activateTrip(trip),
                  ),
                  const PopupMenuItem(
                    height: 10,
                    enabled: false,
                    child: PopupMenuDivider(),
                  ),
                  PopupMenuItem(
                    child: const Text("ELIMINAR VIAJE"),
                    onTap: () => _deleteTrip(trip),
                  ),
                ];
              },
            )
          ],
          leading: const BackButton(),
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
