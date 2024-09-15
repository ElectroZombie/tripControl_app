import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/tuple.dart';
import 'package:trip_control_app/widgets/frame_widgets/new_trip_widget.dart';

class NewTripControl extends StatefulWidget {
  const NewTripControl({Key? key}) : super(key: key);

  @override
  NewTripControlState createState() => NewTripControlState();
}

class NewTripControlState extends State<NewTripControl> {
  Tuple<int, TripModel> tupla = Tuple(T: 0, K: TripModel.nullTrip());
  String paisSeleccionado = "";
  DateTime? selectedDate;
  List<String> paises = [];
  Map<String, Function> callbacks = {};

  TextEditingController nombreViaje = TextEditingController();
  TextEditingController precioM1 = TextEditingController();
  TextEditingController precioM2 = TextEditingController();
  TextEditingController nombrePais = TextEditingController();

  _getCountries() async {
    paises = await DB.getCountries();
    paisSeleccionado = paises[0];
    setState(() {});
  }

  callbackDate(date) {
    setState(() {
      selectedDate = date;
    });
  }

  callbackPais(pais) {
    pais ??= "";
    setState(() {
      paisSeleccionado = pais;
    });
  }

  @override
  void initState() {
    super.initState();
    _getCountries();
    selectedDate = DateTime.now();
    callbacks = {"date": callbackDate, "pais": callbackPais};

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colors = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colors.surfaceContainerHighest,
        appBar: AppBar(
          backgroundColor: colors.onPrimaryFixedVariant,
          foregroundColor: colors.onPrimary,
          leading: const BackButton(),
          title: const Text(
            "CREAR VIAJE",
            style: TextStyle(fontSize: 20),
          ),
        ),
        body: Form(
          child: newTripWidget(
              selectedDate,
              paisSeleccionado,
              paises,
              nombreViaje,
              precioM1,
              precioM2,
              nombrePais,
              callbacks,
              context,
              colors),
        ));
  }
}
