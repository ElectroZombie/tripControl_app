import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/utils/tuple.dart';
import 'package:trip_control_app/widgets/trip_widgets/current_trip_widget.dart';
import 'package:trip_control_app/widgets/trip_widgets/new_trip_widget.dart';

class TripControl extends StatefulWidget {
  const TripControl({Key? key}) : super(key: key);

  @override
  TripControlState createState() => TripControlState();
}

class TripControlState extends State<TripControl> {
  Tuple<int, TripModel> tupla = Tuple(T: 0, K: TripModel.nullTrip());
  String paisSeleccionado = "";
  DateTime? selectedDate;
  List<String> paises = [];
  String textoViaje = "Nuevo viaje";

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

  Future<void> revisarViaje() async {
    int activo = 0;
    int e = await DB.getLastIDTrip();
    if (await DB.verifyActiveTrip(e)) {
      activo = 1;
    }
    if (activo == 1) {
      tupla = Tuple(T: activo, K: await DB.getTripByID(e));
      textoViaje =
          "${tupla.K!.tripName} / ${tupla.K!.nombrePais} / ${tupla.K!.fechaInicioViaje}";
    }
    setState(() {});
  }

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
    setState(() {
      paisSeleccionado = pais;
    });
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
            TextButton(
                onPressed: () => endTrip(tupla, context),
                child: Text("Terminar Viaje"))
          ],
          title: Text(
            textoViaje,
            style: TextStyle(fontSize: 20, letterSpacing: -2),
          ),
          backgroundColor: const Color.fromARGB(255, 47, 128, 182),
        ),
        body: Stack(
          children: [
            gradient(),
            Form(
              child: widgetTrip(tupla, context, callbackDate, callbackPais),
            )
          ],
        ));
  }

  Future<void> endTrip(Tuple<int, TripModel> tupla, context) async {
    _endTrip(int idTrip) async {
      await DB.endTrip(idTrip, DateTime.now().toString());
      Navigator.pushReplacementNamed(context, '/', arguments: 1);
    }

    if (tupla.T == 0) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 111, 129, 155),
            title: Text("Todavia no se ha creado el viaje"),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("Aceptar"))
            ],
          );
        },
      );
    } else {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 111, 129, 155),
            title: Text("Desea finalizar este viaje?"),
            actions: [
              TextButton(
                  onPressed: () {
                    _endTrip(tupla.K!.tripID);
                    Navigator.pop(context);
                  },
                  child: Text("Si")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text("No"))
            ],
          );
        },
      );
    }
  }

  Widget widgetTrip(
      Tuple<int, TripModel> tupla, context, callbackDate, callbackPais) {
    setState(() {});
    if (tupla.T == 0) {
      return newTripWidget(selectedDate, paisSeleccionado, paises, context,
          callbackDate, callbackPais, nombreViaje, precioM1, precioM2);
    } else {
      return currentTripWidget(
          tupla.K!,
          paises,
          context,
          nombreViaje,
          precioM1,
          precioM2,
          nombreCompra,
          cantU,
          pesoT,
          costoM2,
          ventaM1,
          descripcionGasto,
          costoGastoD);
    }
  }
}
