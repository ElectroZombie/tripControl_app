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

  void _updateTrip(Future<TripModel> trip) async {
    data = await trip;
    textoViaje =
        "Viaje actual: ${data.tripName} / ${data.nombrePais} / ${data.fechaInicioViaje}";

    setState(() {});
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
              tooltip: "Mostrar menú",
              iconColor: Colors.white60,
              iconSize: 25,
              style: ButtonStyle(
                  overlayColor: WidgetStateColor.resolveWith(
                      (states) => const Color.fromARGB(99, 104, 58, 183))),
              itemBuilder: (context) {
                return [
                  const PopupMenuItem(
                    child: Text("Exportar PDF"),
                   // onTap: () => _exportPDF(),
                  ),
                  const PopupMenuItem(
                    height: 10,
                    enabled: false,
                    child: PopupMenuDivider(),
                  ),
                  const PopupMenuItem(
                    child: Text("Activar viaje"),
                   // onTap: () => _activateTrip(trip),
                  ),
                  const PopupMenuItem(
                    height: 10,
                    enabled: false,
                    child: PopupMenuDivider(),
                  ),
                  const PopupMenuItem(
                    child: Text("Eliminar viaje"),
                //    onTap: () => _deleteTrip(trip),
                  ),
                ];
              },
            )
          ],
          leading: const BackButton(),
          title: Text(
            textoViaje,
            style: const TextStyle(fontSize: 20),
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
