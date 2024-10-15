import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';
import 'package:trip_control_app/widgets/object_widgets/error_dialog_widget.dart';

class TripList extends StatefulWidget {
  const TripList({Key? key}) : super(key: key);

  @override
  TripListState createState() => TripListState();
}

class TripListState extends State<TripList> {
  Future<List<TripModel>> loadTrips() async {
    return DB.getTrips();
  }

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return SingleChildScrollView(
        child: Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height) / 100),
            child: SizedBox(
                width: (MediaQuery.of(context).size.width * 9.5) / 10,
                child: Stack(children: [
                  Row(children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                        backgroundColor: colors.tertiary,
                        child: Icon(
                          Icons.location_on_sharp,
                          color: colors.onTertiary,
                        ))
                  ]),
                  Column(children: [
                    const SizedBox(
                      height: 7,
                    ),
                    ListTile(
                      titleAlignment: ListTileTitleAlignment.titleHeight,
                      tileColor: colors.primary,
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: colors.tertiary, width: 1.75),
                          borderRadius: BorderRadius.circular(20)),
                      title: const Text(
                        "VIAJES REALIZADOS",
                        textAlign: TextAlign.center,
                      ),
                      subtitle: FutureBuilder(
                        future: loadTrips(),
                        initialData: null,
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData || snapshot.data.length == 0) {
                            return Column(
                              children: [
                                Center(
                                  child: Column(
                                    children: [
                                      SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.2),
                                      const Text(
                                        "--------NO HAY VIAJES DISPONIBLES--------",
                                        style: TextStyle(fontSize: 12),
                                      ),
                                      Container(
                                        alignment: Alignment.bottomRight,
                                        child: nuevoViaje(
                                            snapshot, context, colors),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else {
                            return Center(
                                child: SizedBox(
                                    child: Column(
                              children: [
                                ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, r) {
                                    TripModel viaje = snapshot.data[r];
                                    return Column(
                                      children: [
                                        const SizedBox(height: 3),
                                        ListTile(
                                            titleAlignment:
                                                ListTileTitleAlignment.top,
                                            tileColor: revisarFechaViajeColor(
                                                viaje, colors),
                                            shape: RoundedRectangleBorder(
                                                side: BorderSide(
                                                    color: colors.tertiary,
                                                    width: 1.75),
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            title: Text(
                                                revisarFechaViajeTitulo(viaje)),
                                            subtitle: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.end,
                                              children: [
                                                const SizedBox(height: 5),
                                                Text(
                                                  "Destino: ${viaje.nombrePais}",
                                                  style: const TextStyle(
                                                      fontSize: 11),
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  "Fecha: ${viaje.fechaInicioViaje!.split(" ").first} a: ${revisarFechaViaje(viaje)}",
                                                  style: const TextStyle(
                                                      fontSize: 11),
                                                ),
                                              ],
                                            ),
                                            trailing: IconButton(
                                                onPressed:
                                                    (revisarFechaViaje(viaje) ==
                                                            "NO TERMINADO")
                                                        ? () => {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/current_trip_control')
                                                            }
                                                        : () => {
                                                              Navigator.pushNamed(
                                                                  context,
                                                                  '/trip_data',
                                                                  arguments:
                                                                      getCompleteTrip(
                                                                          viaje
                                                                              .tripID))
                                                            },
                                                hoverColor: colors.secondary,
                                                tooltip: "DATOS DEL VIAJE",
                                                icon: const Icon(Icons
                                                    .arrow_circle_right_outlined))),
                                        const SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                Container(
                                  alignment: Alignment.bottomRight,
                                  child: nuevoViaje(snapshot, context, colors),
                                ),
                              ],
                            )));
                          }
                        },
                      ),
                    )
                  ])
                ]))));
  }
}

Widget nuevoViaje(snapshot, context, colors) {
  bool activo = true;
  try {
    if (snapshot.data[snapshot.data.length - 1].activo == 0) {
      activo = false;
    }
  } catch (e) {
    activo = false;
  }

  return IconButton(
      tooltip: "CREAR NUEVO VIAJE",
      style: iconButtonStyleWidget(colors),
      onPressed: activo
          ? () => errorDialogWidget("YA HAY UN VIAJE EN PROCESO", context)
          : () => {Navigator.pushNamed(context, '/new_trip_control')},
      icon: const Icon(Icons.add));
}

Future<TripModel> getCompleteTrip(int idTrip) async {
  return DB.getTripByID(idTrip);
}

String revisarFechaViaje(TripModel viaje) {
  if (viaje.fechaFinalViaje == null) {
    return "NO TERMINADO";
  } else {
    return viaje.fechaFinalViaje!.split(" ").first;
  }
}

Color revisarFechaViajeColor(TripModel viaje, ColorScheme colors) {
  if (viaje.fechaFinalViaje == null) {
    return colors.primaryFixed;
  } else {
    return colors.primary;
  }
}

String revisarFechaViajeTitulo(TripModel viaje) {
  if (viaje.fechaFinalViaje == null) {
    return "${viaje.tripName} (ACTIVO)";
  } else {
    return viaje.tripName;
  }
}
