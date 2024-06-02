import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdf_package;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/methods/bar_message_method.dart';
import 'package:trip_control_app/models/compra_model.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';

void exportToPDF(Future<TripModel> data, context) async {
  TripModel trip = await data;
  List<CompraModel> compras = await DB.getComprasTrip(trip.tripID);
  List<GastoModel> gastos = await DB.getGastosTrip(trip.tripID);

  dynamic status;

  if (Platform.isAndroid) {
    status = await Permission.storage.status;
    if (status.isDenied) {
      await [Permission.storage].request();
    }
  }

  final pdf = pdf_package.Document();

  pdf.addPage(
    pdf_package.Page(
      build: (pdf_package.Context context) {
        return pdf_package.Center(
          child: pdf_package.Column(children: [
            pdf_package.Text('Datos del viaje: ${trip.tripName}'),
            pdf_package.Text('Pais: ${trip.nombrePais}'),
            pdf_package.Text(
                'Pais: ${trip.fechaInicioViaje} -> ${trip.fechaFinalViaje}'),
            pdf_package.Text(
                'Precio del CUP en USD: ${trip.coin1Price}/Precio de la moneda extranjera en USD: ${trip.coin2Price}'),
          ]),
        );
      },
    ),
  );

  pdf.addPage(
    pdf_package.MultiPage(
      build: (pdf_package.Context context) {
        final List<pdf_package.Widget> content = [pdf_package.Text('COMPRAS:')];
        for (int i = 0; i < compras.length; i++) {
          content.add(
            pdf_package.Text(
                '${compras[i].compraNombre}   ${compras[i].compraPrecio}   ${compras[i].cantU}   ${compras[i].pesoT}   ${compras[i].ventaCUPXUnidad}'),
          );
        }
        content.add(pdf_package.Text(
            '${trip.gastoCompras}   ${trip.gastoComprasXKilo}'));
        content.add(pdf_package.Text(
            '${trip.gananciaComprasReal}   ${trip.gananciaComprasXKilo}'));
        return content;
      },
    ),
  );

  pdf.addPage(
    pdf_package.MultiPage(
      build: (pdf_package.Context context) {
        final List<pdf_package.Widget> content = [pdf_package.Text('GASTOS:')];
        for (int i = 0; i < gastos.length; i++) {
          content.add(
            pdf_package.Text(
                '${gastos[i].gastoDescripcion}   ${gastos[i].gastoDescripcion}'),
          );
        }

        content.add(pdf_package.Text('${trip.otrosGastos}'));

        return content;
      },
    ),
  );

  pdf.addPage(
    pdf_package.Page(
      build: (pdf_package.Context context) {
        return pdf_package.Center(
          child: pdf_package.Column(children: [
            pdf_package.Text('Gastos totales: ${trip.gastoTotal}'),
            pdf_package.Text('Rentabilidad: ${trip.rentabilidad}'),
            pdf_package.Text(
                'Rentabilidad por Kilogramo: ${trip.rentabilidadXKilo}'),
            pdf_package.Text(
                'Rentabilidad porcentual: ${trip.rentabilidadPorcentual}'),
          ]),
        );
      },
    ),
  );

  // Obtiene la ruta de la carpeta de descargas

  final directory = await getDownloadsDirectory();
  String defaultPath =
      '${Directory('${(await getApplicationCacheDirectory()).path}/../..').uri.path}datos_viaje_${trip.tripName}_${trip.tripID}.pdf';
  if (Platform.isWindows || Platform.isAndroid) {
    defaultPath =
        '${directory?.path}/datos_viaje_${trip.tripName}_${trip.tripID}.pdf';
  }

  // Guarda el archivo PDF
  if (Platform.isAndroid && status.isGranted) {
    final file = File(defaultPath);
    await file.writeAsBytes(await pdf.save());

    notifySuccessPDF(
        'Archivo PDF guardado en: $defaultPath', Colors.greenAccent, context);
  } else {
    final file = File(defaultPath);
    await file.writeAsBytes(await pdf.save());

    notifySuccessPDF(
        'Archivo PDF guardado en: $defaultPath', Colors.greenAccent, context);
  }
}
