import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/models/trip_model.dart';

class TripConsults {
  static Future<void> insertNewTrip(db, TripModel T) async {
    db.insert("viaje", T.toEmptyMap());
    return;
  }

  static Future<TripModel> updateTrip(db, TripModel T) async {
    db.update('viaje', T.toMap(),
        where: '${T.tripID} = ?', whereArgs: [T.tripID]);

    List<Map<String, dynamic>> Q = await db
        .query('viaje', where: '${T.tripID} = ?', whereArgs: [T.tripID]);
    return List.generate(Q.length, (i) => T).first;
  }

  static Future<void> deleteTrip(db, int idTrip) async {
    db.delete('viaje', where: 'id_viaje = ?', whereArgs: [idTrip]);
  }

  static Future<List<TripModel>> getTrips(db) async {
    List<Map<String, dynamic>> Q = await db.query('viaje');
    return List.generate(
        Q.length,
        (i) => TripModel(
            tripID: Q[i]['id_viaje'],
            tripName: Q[i]['nombre_viaje'],
            activo: Q[i]['activo']));
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
        tripID: id, tripName: Q[0]['nombre_viaje'], activo: Q[0]['activo']);
    viaje.coin1Price = Q[0]['precio_M1'];
    viaje.coin2Price = Q[0]['precio_M2'];
    viaje.compras = await DB.getComprasTrip(id);
    viaje.gananciaComprasReal = Q[0]['gananciaCompraReal'];
    viaje.gananciaComprasXKilo = Q[0]['gananciaCompraKilo'];
    viaje.gastoCompras = Q[0]['gasto_compras'];
    viaje.gastoComprasXKilo = Q[0]['gastoCompraKilo'];
    viaje.gastoTotal = Q[0]['gasto_total'];
    viaje.gastos = await DB.getGastosTrip(id);
    viaje.otrosGastos = Q[0]['gasto_otros'];
    viaje.rentabilidad = Q[0]['rentabilidad'];
    viaje.rentabilidadPorcentual = Q[0]['rentabilidadPorcentual'];
    viaje.rentabilidadXKilo = Q[0]['rentabilidadKilo'];

    return viaje;
  }
}
