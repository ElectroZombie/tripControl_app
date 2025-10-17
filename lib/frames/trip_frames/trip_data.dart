import 'package:flutter/material.dart';
import 'package:alforja/db/db_general.dart';
import 'package:alforja/models/trip_model.dart';
//import 'package:alforja/utils/pdf_actions.dart';
import 'package:alforja/widgets/frame_widgets/data_trip_general_data_widget.dart';
import 'package:alforja/widgets/frame_widgets/data_trip_products_widget.dart';
import 'package:alforja/widgets/object_widgets/button_widget.dart';

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

  _deleteTrip(Future<TripModel> trip, colors) async {
    data = await trip;
    await showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        var colors = Theme.of(context).colorScheme;
        return AlertDialog(
          backgroundColor: colors.surface,
          title: const Text(
              "¿DESEA ELIMINAR EL VIAJE? \n SE  PERDERÁN TODOS LOS DATOS"),
          actions: [
            TextButton(
                style: dialogButtonStyleWidget(colors),
                onPressed: () {
                  DB.deleteTrip(data.tripID);
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/principal', (route) => false,
                      arguments: true);
                },
                child: const Text("ACEPTAR")),
            TextButton(
                style: dialogButtonStyleWidget(colors),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("CANCELAR"))
          ],
        );
      },
    );
  }

  _activateTrip(Future<TripModel> trip, ColorScheme colors) async {
    data = await trip;

    await showDialog(
      // ignore: use_build_context_synchronously
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: colors.surface,
          title: const Text(
              "¿DESEA VOLVER A ACTIVAR EL VIAJE? \n ESTA ES UNA ACTIVACIÓN DE UNA SOLA VEZ"),
          actions: [
            TextButton(
                style: dialogButtonStyleWidget(colors),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, '/update_trip_singleton',
                      arguments: [data, 0]);
                },
                child: const Text("ACEPTAR")),
            TextButton(
                style: dialogButtonStyleWidget(colors),
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
    var colors = Theme.of(context).colorScheme;
    _updateTrip(trip);
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            backgroundColor: colors.surfaceContainerHighest,
            appBar: AppBar(
              backgroundColor: colors.onPrimaryFixedVariant,
              foregroundColor: colors.onPrimary,
              title: const Text("DATOS DEL VIAJE"),
              actions: [
                PopupMenuButton(
                  tooltip: "MOSTRAR MENÚ",
                  iconSize: 25,
                  itemBuilder: (context) {
                    return [
                      /*PopupMenuItem(
                    child: const Text("EXPORTAR PDF"),
                    onTap: () => exportToPDF(trip, context),
                  ),*/
                      const PopupMenuItem(
                        height: 10,
                        enabled: false,
                        child: PopupMenuDivider(),
                      ),
                      PopupMenuItem(
                        child: const Text("ACTIVAR VIAJE"),
                        onTap: () => _activateTrip(trip, colors),
                      ),
                      const PopupMenuItem(
                        height: 10,
                        enabled: false,
                        child: PopupMenuDivider(),
                      ),
                      PopupMenuItem(
                        child: const Text("ELIMINAR VIAJE"),
                        onTap: () => _deleteTrip(trip, colors),
                      ),
                    ];
                  },
                )
              ],
              leading: const BackButton(),
              centerTitle: true,
              bottom: TabBar(
                dividerColor: colors.secondary,
                indicatorColor: colors.secondary,
                tabs: [
                  Tab(
                    child: Text(
                      'DATOS',
                      style: TextStyle(fontSize: 16, color: colors.onPrimary),
                    ),
                  ),
                  Tab(
                    child: Text('PRODUCTOS',
                        style:
                            TextStyle(fontSize: 16, color: colors.onPrimary)),
                  )
                ],
              ),
            ),
            body: TabBarView(children: [
              Form(child: dataTripGeneralDataWidget(data, context, colors)),
              Form(child: dataTripProductsWidget(data, context, colors))
            ])));
  }
}
