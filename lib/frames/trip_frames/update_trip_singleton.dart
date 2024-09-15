import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/frame_widgets/current_trip_general_data_widget.dart';
import 'package:trip_control_app/widgets/frame_widgets/current_trip_products_widget.dart';

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
  TextEditingController nombrePais = TextEditingController();

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
    TripModel T = (ModalRoute.of(context)!.settings.arguments
        as List<Object>)[0] as TripModel;
    var arg = (ModalRoute.of(context)!.settings.arguments as List<Object>)[1];
    var initIndex = (arg == 1) ? 1 : 0;
    ColorScheme colors = Theme.of(context).colorScheme;
    return DefaultTabController(
        length: 2,
        initialIndex: initIndex,
        child: Scaffold(
            backgroundColor: colors.primary,
            appBar: AppBar(
              backgroundColor: colors.surface,
              foregroundColor: colors.onPrimary,
              leading: const Icon(Icons.trip_origin),
              actions: [
                IconButton(
                  onPressed: () => endTrip(T, context),
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
                    child: currentTripGeneralDataWidget(T, paises, nombreViaje,
                        precioM1, precioM2, nombrePais, context, colors,
                        singleton: true)),
                Form(
                    child: currentTripProductsWidget(
                        T,
                        nombreCompra,
                        cantU,
                        pesoT,
                        costoM2,
                        ventaM1,
                        descripcionGasto,
                        costoGastoD,
                        context,
                        colors,
                        singleton: true))
              ],
            )));
  }

  Future<void> endTrip(TripModel T, context) async {
    endTrip(int idTrip, String fecha) async {
      if (fecha == "") {
        fecha = DateTime.now().toString();
      }
      await DB.endTrip(idTrip, fecha);
      Navigator.pushNamedAndRemoveUntil(context, '/principal', (route) => false,
          arguments: 1);
    }

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
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
