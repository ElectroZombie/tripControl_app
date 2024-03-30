import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/utils/tuple.dart';
import 'package:trip_control_app/widgets/current_trip_widget.dart';
import 'package:trip_control_app/widgets/new_trip_widget.dart';

class TripControl extends StatefulWidget {
  const TripControl({Key? key}) : super(key: key);

  @override
  TripControlState createState() => TripControlState();
}

class TripControlState extends State<TripControl> {
  Tuple<int, TripModel> tupla = Tuple(T: 0, K: TripModel.nullTrip());

  Future<void> revisarViaje() async {
    int activo = 0;
    int e = await DB.getLastIDTrip();
    if (await DB.verifyActiveTrip(e)) {
      activo = 1;
    }
    if (activo == 1) {
      tupla = Tuple(T: activo, K: await DB.getTripByID(e));
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    revisarViaje();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
        ),
        body: Stack(
          children: [
            gradient(),
            Form(
              child: widgetTrip(tupla, context),
            )
          ],
        ));
  }

  Widget widgetTrip(Tuple<int, TripModel> tupla, context) {
    if (tupla.T == 0) {
      return newTripWidget(context);
    } else {
      return currentTripWidget(tupla.K!, context);
    }
  }
}
