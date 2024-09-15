import 'package:flutter/material.dart';

import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/frames/trip_frames/trip_list.dart';
import 'package:trip_control_app/widgets/object_widgets/info_sheet.dart';

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
    var colors = Theme.of(context).colorScheme;
    int initIndex = 0;
    var arg = ModalRoute.of(context)!.settings.arguments;
    if (arg != null) {
      initIndex = 1;
    }
    return DefaultTabController(
      length: 2,
      initialIndex: initIndex,
      child: Scaffold(
        backgroundColor: colors.surfaceContainerHighest,
        appBar: AppBar(
          backgroundColor: colors.onPrimaryFixedVariant,
          actions: [
            IconButton(
              onPressed: () => showSheet(context, colors),
              icon: const Icon(Icons.info),
              tooltip: "Información",
            ),
            IconButton(
              onPressed: () => goToTripControl(context),
              icon: const Icon(Icons.turned_in_sharp),
              tooltip: "CONTROL DE VIAJE ACTUAL",
            )
          ],
          title: Text(
            "CONTROL DE VIAJES",
            style: TextStyle(fontSize: 20, color: colors.onSurface),
          ),
          leading: const Icon(Icons.calendar_month_outlined),
          bottom: TabBar(
            dividerColor: colors.secondary,
            indicatorColor: colors.secondary,
            tabs: [
              Tab(
                child: Text(
                  'CALCULADORA',
                  style: TextStyle(fontSize: 16, color: colors.onPrimary),
                ),
              ),
              Tab(
                child: Text('LISTA DE VIAJES',
                    style: TextStyle(fontSize: 16, color: colors.onPrimary)),
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

void showSheet(context, colors) {
  showModalBottomSheet(
      backgroundColor: colors.surface,
      isScrollControlled: true,
      context: context,
      builder: (BuildContext context) {
        return infoSheet(context, colors);
      });
}
