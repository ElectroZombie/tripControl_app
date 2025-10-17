import 'package:alforja/models/gasto_model.dart';

class GastoConsults {
  static Future<void> insertNewGasto(db, GastoModel g) async {
    db.insert('gasto', g.toMap());
  }

  static Future<List<GastoModel>> getGastosTrip(db, int idTrip) async {
    List<Map<String, dynamic>> Q =
        await db.query('gasto', where: 'id_viaje = ?', whereArgs: [idTrip]);

    return List.generate(
        Q.length,
        (i) => GastoModel(
            id: Q[i]['id_gasto'],
            tripID: idTrip,
            gastoDescripcion: Q[i]['descripcion_gasto'],
            gastoMoney: Q[i]['gasto_money']));
  }

  static Future<void> updateGasto(db, GastoModel gasto) async {
    db.update('gasto', gasto.toMap(),
        where: 'id_gasto = ?', whereArgs: [gasto.id]);
  }

  static Future<void> deleteGasto(db, int idGasto) async {
    db.delete('gasto', where: 'id_gasto = ?', whereArgs: [idGasto]);
  }

  static Future<int> getLastIDGasto(db) async {
    List<Map<String, dynamic>> S =
        await db.rawQuery("SELECT MAX (id_gasto) AS maxId FROM gasto");
    if (S[0]['maxId'] == null) {
      return 1;
    } else {
      return S[0]['maxId'];
    }
  }
}
