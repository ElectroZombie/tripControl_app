import 'package:flutter/material.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/utils/tuple.dart';
import 'package:trip_control_app/widgets/current_trip_widget.dart';
import 'package:trip_control_app/widgets/new_trip_widget.dart';

class TripControl extends StatefulWidget {
  const TripControl(tupla, {Key? key}) : super(key: key);

  @override
  TripControlState createState() => TripControlState();
}

class TripControlState extends State<TripControl> {
  @override
  Widget build(BuildContext context) {
    Tuple<bool, TripModel> tupla =
        ModalRoute.of(context)!.settings.arguments as Tuple<bool, TripModel>;

    return Stack(
      children: [
        gradient(),
        SingleChildScrollView(
          child: widgetTrip(tupla),
        ),
      ],
    );
  }
}

Widget widgetTrip(Tuple<bool, TripModel> tupla) {
  if (tupla.T!) {
    return newTripWidget();
  } else {
    return currentTripWidget(tupla.K!);
  }
}
