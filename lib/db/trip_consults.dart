import 'package:sqflite/sqflite.dart';
import 'package:alforja/db/compras_consults.dart';
import 'package:alforja/db/db_general.dart';
import 'package:alforja/db/gastos_consults.dart';
import 'package:alforja/models/compra_model.dart';
import 'package:alforja/models/gasto_model.dart';
import 'package:alforja/models/trip_model.dart';

class TripConsults {
  static Future<void> insertNewTrip(db, TripModel T) async {
    await db.insert("viaje", T.toMap());
    return;
  }

  static Future<void> updateTrip(Database db, TripModel T) async {
    await db.rawUpdate(
        "UPDATE viaje SET nombre_viaje = ?, precio_M1 = ?, precio_M2 = ? WHERE id_viaje = ${T.tripID}",
        [T.tripName, T.coin1Price, T.coin2Price]);
  }

  static Future<void> updatePaisTrip(
      Database db, int idTrip, String pais) async {
    await db.update('viaje', {'nombre_pais': pais},
        where: 'id_viaje = ?', whereArgs: [idTrip]);
  }

  static Future<void> updateFechaInicioTrip(
      Database db, int idTrip, DateTime fechaInicio) async {
    await db.update('viaje', {'fecha_inicio_viaje': fechaInicio.toString()},
        where: 'id_viaje = ?', whereArgs: [idTrip]);
  }

  static Future<void> updateFechaFinalTrip(
      Database db, int idTrip, DateTime fechaFinal) async {
    await db.update('viaje', {'fecha_final_viaje': fechaFinal.toString()},
        where: 'id_viaje = ?', whereArgs: [idTrip]);
  }

  static Future<void> deleteTrip(Database db, int idTrip) async {
    await db.delete('compra', where: 'id_viaje = ?', whereArgs: [idTrip]);
    await db.delete('gasto', where: 'id_viaje = ?', whereArgs: [idTrip]);
    await db.delete('viaje', where: 'id_viaje = ?', whereArgs: [idTrip]);
  }

  static Future<List<TripModel>> getTrips(db) async {
    List<Map<String, dynamic>> Q = await db.query('viaje');
    return List.generate(
        Q.length,
        (i) => TripModel(
            tripID: Q[i]['id_viaje'],
            tripName: Q[i]['nombre_viaje'],
            activo: Q[i]['activo'],
            fechaInicioViaje: Q[i]['fecha_inicio_viaje'],
            fechaFinalViaje: Q[i]['fecha_final_viaje'],
            nombrePais: Q[i]['nombre_pais']));
  }

  static Future<int> getLastIDTrip(db) async {
    if (await DB.isDBEmpty()) {
      return 1;
    }
    List<Map<String, dynamic>> Q =
        await db.rawQuery("SELECT max (id_viaje) from viaje");
    return Q[Q.length - 1]['max (id_viaje)'];
  }

  static Future<bool> verifyActiveTrip(db, int id) async {
    List<Map<String, dynamic>> Q = await db.query('viaje',
        columns: ['activo'],
        where: 'activo = 1 and id_viaje = ?',
        whereArgs: [id]);
    if (Q.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<TripModel> getTripByID(db, int id) async {
    List<Map<String, dynamic>> Q =
        await db.query('viaje', where: 'id_viaje = ?', whereArgs: [id]);
    TripModel viaje = TripModel(
        tripID: id,
        tripName: Q[0]['nombre_viaje'],
        activo: Q[0]['activo'],
        gananciaComprasReal: 0,
        gananciaComprasXKilo: 0,
        gastoCompras: 0,
        gastoComprasXKilo: 0,
        otrosGastos: 0,
        kilosTotales: 0,
        rentabilidad: 0,
        rentabilidadPorcentual: 0,
        rentabilidadXKilo: 0,
        fechaInicioViaje: Q[0]['fecha_inicio_viaje'],
        fechaFinalViaje: Q[0]['fecha_final_viaje'],
        nombrePais: Q[0]['nombre_pais']);
    viaje.coin1Price = Q[0]['precio_M1'];
    viaje.coin2Price = Q[0]['precio_M2'];

    viaje.fechaFinalViaje ??= "";

    List<CompraModel> compras = await CompraConsults.getComprasTrip(db, id);
    for (var compra in compras) {
      viaje.addCompra(compra);
    }

    List<GastoModel> gastos = await GastoConsults.getGastosTrip(db, id);
    for (var gasto in gastos) {
      viaje.addGasto(gasto.gastoMoney);
    }

    return viaje;
  }

  static Future<void> endTrip(
      Database db, int idTrip, String fechaFinal) async {
    await db.update('viaje', {'activo': 0, 'fecha_final_viaje': fechaFinal},
        where: 'id_viaje = ?', whereArgs: [idTrip]);
  }

  static Future<void> activateTrip(Database db, int idTrip) async {
    await db.update('viaje', {'activo': 1, 'fecha_final_viaje': ""},
        where: 'id_viaje = ?', whereArgs: [idTrip]);
  }

  static Future<bool> verifyActiveTrips(Database db) async {
    List<Map<String, dynamic>> Q =
        await db.query('viaje', where: 'activo = ?', whereArgs: [1]);
    if (Q.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
