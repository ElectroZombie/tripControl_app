import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/widgets/trip_widgets/current_trip_widget.dart';

class UpdateTripSingleton extends StatefulWidget {
  const UpdateTripSingleton({Key? key}) : super(key: key);

  @override
  UpdateTripSingletonState createState() => UpdateTripSingletonState();
}

class UpdateTripSingletonState extends State<UpdateTripSingleton> {
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

  _getCountries() async {
    paises = await DB.getCountries();
    paisSeleccionado = paises[0];
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _getCountries();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TripModel T = ModalRoute.of(context)!.settings.arguments as TripModel;

    return Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          actions: [
            IconButton(
              onPressed: () => endTrip(T, context),
              icon: const Icon(Icons.do_not_disturb_on_total_silence_sharp),
              tooltip: "FINALIZAR VIAJE",
            )
          ],
          title: Text(
            "${T.tripName} / ${T.nombrePais} / ${T.fechaInicioViaje}",
            style: const TextStyle(fontSize: 20, letterSpacing: -2),
          ),
          backgroundColor: const Color.fromARGB(255, 47, 128, 182),
        ),
        body: Stack(
          children: [
            gradient(),
            Form(
              child: currentTripWidget(
                  T,
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
                  context),
            )
          ],
        ));
  }

  Future<void> endTrip(TripModel T, context) async {
    endTrip(int idTrip, String fecha) async {
      if (fecha == "") {
        fecha = DateTime.now().toString();
      }
      await DB.endTrip(idTrip, fecha);
      Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false,
          arguments: 1);
    }

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color.fromARGB(255, 111, 129, 155),
          title: const Text("¿DESEA FINALIZAR ESTE VIAJE?"),
          actions: [
            TextButton(
                onPressed: () {
                  endTrip(T.tripID, T.fechaFinalViaje!);
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
