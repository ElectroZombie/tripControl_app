import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/utils/tuple.dart';
import 'package:trip_control_app/widgets/trip_widgets/current_trip_widget.dart';

class CurrentTripControl extends StatefulWidget {
  const CurrentTripControl({Key? key}) : super(key: key);

  @override
  CurrentTripControlState createState() => CurrentTripControlState();
}

class CurrentTripControlState extends State<CurrentTripControl> {
  Tuple<int, TripModel> tupla = Tuple(T: 0, K: TripModel.nullTrip());
  String paisSeleccionado = "";
  DateTime? selectedDate;
  List<String> paises = [];
  Map<String, Function> callbacks = {};

  TextEditingController nombreViaje = TextEditingController();
  TextEditingController precioM1 = TextEditingController();
  TextEditingController precioM2 = TextEditingController();
  TextEditingController nombreCompra = TextEditingController();
  TextEditingController cantU = TextEditingController();
  TextEditingController pesoT = TextEditingController();
  TextEditingController costoM2 = TextEditingController();
  TextEditingController ventaM1 = TextEditingController();
  TextEditingController descripcionGasto = TextEditingController();
  TextEditingController costoGastoD = TextEditingController();
  TextEditingController nombrePais = TextEditingController();

  Future<void> revisarViaje() async {
    int e = await DB.getLastIDTrip();
    tupla = Tuple(T: 1, K: await DB.getTripByID(e));
    setState(() {});
  }

  _getCountries() async {
    paises = await DB.getCountries();
    paisSeleccionado = paises[0];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    revisarViaje();
    _getCountries();
    selectedDate = DateTime.now();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          actions: [
            IconButton(
              onPressed: () => endTrip(tupla, context),
              icon: const Icon(Icons.do_not_disturb_on_total_silence_sharp),
              tooltip: "FINALIZAR VIAJE",
            )
          ],
          title: const Text("CONTROL DE VIAJE"),
          backgroundColor: const Color.fromARGB(255, 47, 128, 182),
        ),
        body: Stack(
          children: [
            gradient(),
            Form(
              child: currentTripWidget(
                  tupla.K!,
                  paises,
                  nombreViaje,
                  precioM1,
                  precioM2,
                  nombreCompra,
                  cantU,
                  pesoT,
                  costoM2,
                  ventaM1,
                  descripcionGasto,
                  costoGastoD,
                  nombrePais,
                  context),
            )
          ],
        ));
  }

  Future<void> endTrip(Tuple<int, TripModel> tupla, context) async {
    endTrip(int idTrip, String fecha) async {
      if (fecha == "") {
        fecha = DateTime.now().toString();
      }
      await DB.endTrip(idTrip, fecha);
      Navigator.pushReplacementNamed(context, '/', arguments: 1);
    }

    if (tupla.T == 0) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 111, 129, 155),
            title: const Text("TODAVÍA NO SE HA CREADO UN VIAJE"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("ACEPTAR"))
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: const Color.fromARGB(255, 111, 129, 155),
            title: const Text("¿DESEA FINALIZAR EL VIAJE?"),
            actions: [
              TextButton(
                  onPressed: () {
                    endTrip(tupla.K!.tripID, tupla.K!.fechaFinalViaje!);
                    Navigator.pop(context);
                  },
                  child: const Text("SI")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("NO"))
            ],
          );
        },
      );
    }
  }
}
