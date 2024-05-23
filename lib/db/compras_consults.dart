import 'package:trip_control_app/models/compra_model.dart';

class CompraConsults {
  static Future<void> insertNewCompra(db, CompraModel c) async {
    db.insert('compra', c.toMap());
  }

  static Future<List<CompraModel>> getComprasTrip(db, int idTrip) async {
    List<Map<String, dynamic>> Q =
        await db.query('compra', where: 'id_viaje = ?', whereArgs: [idTrip]);

    return List.generate(
        Q.length,
        (i) => CompraModel(
            tripID: idTrip,
            id: Q[i]['id_compra'],
            compraNombre: Q[i]['nombre_compra'],
            cantU: Q[i]['cant_unidades'],
            pesoT: Q[i]['peso_total'],
            compraPrecio: Q[i]['compra_precio'],
            ventaCUPXUnidad: Q[i]['ventaCUP']));
  }

  static Future<void> updateCompra(db, CompraModel compra) async {
    db.rawUpdate(
        "UPDATE compra SET nombre_compra = ?, peso_total = ?, cant_unidades = ?, compra_precio = ?, ventaCUP = ? WHERE id_compra = ${compra.id}",
        [
          compra.compraNombre,
          compra.pesoT,
          compra.cantU,
          compra.compraPrecio,
          compra.ventaCUPXUnidad
        ]);
  }

  static Future<void> deleteCompra(db, int idCompra) async {
    db.delete('compra', where: 'id_compra = ?', whereArgs: [idCompra]);
  }

  static Future<int> getLastIDCompra(db) async {
    List<Map<String, dynamic>> S =
        await db.rawQuery("SELECT MAX (id_compra) AS maxId FROM compra");
    if (S[0]['maxId'] == null) {
      return 1;
    } else {
      return S[0]['maxId'];
    }
  }
}
