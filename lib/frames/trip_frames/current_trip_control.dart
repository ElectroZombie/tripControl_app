import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/utils/tuple.dart';
import 'package:trip_control_app/widgets/frame_widgets/current_trip_general_data_widget.dart';
import 'package:trip_control_app/widgets/frame_widgets/current_trip_products_widget.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';

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
    ColorScheme colors = Theme.of(context).colorScheme;
    var initIndex = 0;
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
              foregroundColor: colors.onPrimary,
              leading: const BackButton(),
              actions: [
                IconButton(
                  onPressed: () => endTrip(tupla, context, colors),
                  icon: const Icon(Icons.do_not_disturb_on_total_silence_sharp),
                  tooltip: "FINALIZAR VIAJE",
                )
              ],
              title: const Text("CONTROL DE VIAJE"),
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
            body: TabBarView(
              children: [
                Form(
                    child: currentTripGeneralDataWidget(
                        tupla.K!,
                        paises,
                        nombreViaje,
                        precioM1,
                        precioM2,
                        nombrePais,
                        context,
                        colors,
                        singleton: false)),
                Form(
                    child: currentTripProductsWidget(
                        tupla.K!,
                        nombreCompra,
                        cantU,
                        pesoT,
                        costoM2,
                        ventaM1,
                        descripcionGasto,
                        costoGastoD,
                        context,
                        colors,
                        singleton: false))
              ],
            )));
  }

  Future<void> endTrip(
      Tuple<int, TripModel> tupla, context, ColorScheme colors) async {
    endTrip(int idTrip, String fecha) async {
      if (fecha == "") {
        fecha = DateTime.now().toString();
      }
      await DB.endTrip(idTrip, fecha);
      Navigator.pushReplacementNamed(context, '/principal', arguments: 1);
    }

    if (tupla.T == 0) {
      await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: colors.surface,
            title: const Text("TODAVÍA NO SE HA CREADO UN VIAJE"),
            actions: [
              TextButton(
                  style: dialogButtonStyleWidget(colors),
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
            backgroundColor: colors.surface,
            title: const Text("¿DESEA FINALIZAR EL VIAJE?"),
            actions: [
              TextButton(
                  style: dialogButtonStyleWidget(colors),
                  onPressed: () {
                    endTrip(tupla.K!.tripID, tupla.K!.fechaFinalViaje!);
                    Navigator.pop(context);
                  },
                  child: const Text("SI")),
              TextButton(
                  style: dialogButtonStyleWidget(colors),
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
