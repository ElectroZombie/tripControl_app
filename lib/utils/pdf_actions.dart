/*import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pdf/widgets.dart' as pdf_package;
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:alforja/db/db_general.dart';
import 'package:alforja/methods/bar_message_method.dart';
import 'package:alforja/models/compra_model.dart';
import 'package:alforja/models/gasto_model.dart';
import 'package:alforja/models/trip_model.dart';

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
            pdf_package.Text('DATOS DEL VIAJE: ${trip.tripName}'),
            pdf_package.Text('PAÍS DE DESTINO: ${trip.nombrePais}'),
            pdf_package.Text(
                'FECHAS: ${trip.fechaInicioViaje} -> ${trip.fechaFinalViaje}'),
            pdf_package.Text(
                'PRECIO DEL CUP EN USD: ${trip.coin1Price}/PRECIO DE LA MONEDA EXTRANJERA EN USD: ${trip.coin2Price}'),
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
            pdf_package.Text('${compras[i].compraNombre}\n'
                'PRECIO TOTAL DE LA COMPRA: ${compras[i].compraPrecio}\n'
                'CANTIDAD DE UNIDADES COMPRADAS: ${compras[i].cantU}\n'
                'PESO TOTAL DE LA COMPRA: ${compras[i].pesoT}\n'
                'PRECIO DE VENTA DE CADA PRODUCTO EN CUP: ${compras[i].ventaCUPXUnidad}\n'),
          );
        }
        content.add(pdf_package.Text(
            'GASTO TOTAL DE COMPRAS: ${trip.gastoCompras}\n'
            'GASTO TOTAL DE COMPRAS, POR KILOGRAMO: ${trip.gastoComprasXKilo}'));
        content.add(
            pdf_package.Text('GANANCIA TOTAL: ${trip.gananciaComprasReal}\n'
                'GANANCIA REAL, POR KILOGRAMO: ${trip.gananciaComprasXKilo}'));
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
                'DESCRIPCIÓN DEL GASTO: ${gastos[i].gastoDescripcion}\n'
                'GASTO: ${gastos[i].gastoMoney}'),
          );
        }

        content.add(pdf_package.Text('OTROS GASTOS: ${trip.otrosGastos}\n'));
        content.add(pdf_package.Text('GASTOS TOTALES: ${trip.gastoTotal}'));

        return content;
      },
    ),
  );

  pdf.addPage(
    pdf_package.Page(
      build: (pdf_package.Context context) {
        return pdf_package.Center(
          child: pdf_package.Column(children: [
            pdf_package.Text('RENTABILIDAD: ${trip.rentabilidad}'),
            pdf_package.Text(
                'RENTABILIDAD POR KILOGRAMO: ${trip.rentabilidadXKilo}'),
            pdf_package.Text(
                'RENTABILIDAD PORCENTUAL: ${trip.rentabilidadPorcentual}'),
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
*/