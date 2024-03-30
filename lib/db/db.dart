import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:trip_control_app/models/compra_model.dart';
import 'package:trip_control_app/models/gasto_model.dart';
import 'package:trip_control_app/models/trip_model.dart';

class DB {
  static Future<Database> _openDB() async {
    if (Platform.isAndroid) {
      return openDatabase(
        join(await getDatabasesPath(), 'tripControl.db'),
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE viaje (id_viaje INTEGER PRIMARY KEY, nombre_viaje TEXT, activo INTEGER, precio_M1 DOUBLE, precio_M2 DOUBLE, gasto_total DOUBLE, gasto_compras DOUBLE, gasto_otros DOUBLE, gananciaCompraReal DOUBLE, gananciaCompraKilo DOUBLE, gastoCompraKilo DOUBLE, rentabilidad DOUBLE, rentabilidadKilo DOUBLE, rentabilidadPorcentual DOUBLE)");
          await db.execute(
              "CREATE TABLE compra (id_compra INTEGER PRIMARY KEY, id_viaje INTEGER, nombre_compra TEXT, peso_total DOUBLE, cant_unidades INTEGER, compra_precio DOUBLE, ventaCUP DOUBLE)");
          await db.execute(
              "CREATE TABLE gasto (id_gasto INTEGER PRIMARY KEY, id_viaje INTEGER, descripcion_gasto TEXT, gasto_money DOUBLE)");
        },
        version: 1,
      );
    }

    var db = databaseFactoryFfi;
    String dbpath = join(await getDatabasesPath(), 'testdb.db');
    return db.openDatabase(dbpath,
        options: OpenDatabaseOptions(
          version: 1,
          onCreate: (db, version) async {
            await db.execute(
                "CREATE TABLE viaje (id_viaje INTEGER PRIMARY KEY, nombre_viaje TEXT, activo INTEGER, precio_M1 DOUBLE, precio_M2 DOUBLE, gasto_total DOUBLE, gasto_compras DOUBLE, gasto_otros DOUBLE, gananciaCompraReal DOUBLE, gananciaCompraKilo DOUBLE, gastoCompraKilo DOUBLE, rentabilidad DOUBLE, rentabilidadKilo DOUBLE, rentabilidadPorcentual DOUBLE)");
            await db.execute(
                "CREATE TABLE compra (id_compra INTEGER PRIMARY KEY, id_viaje INTEGER, nombre_compra TEXT, peso_total DOUBLE, cant_unidades INTEGER, compra_precio DOUBLE, ventaCUP DOUBLE)");
            await db.execute(
                "CREATE TABLE gasto (id_gasto INTEGER PRIMARY KEY, id_viaje INTEGER, descripcion_gasto TEXT, gasto_money DOUBLE)");
          },
        ));
  }

  static Future<bool> isDBEmpty() async {
    Database db = await _openDB();

    List<Map<String, dynamic>> escMap = await db.query("viaje");
    if (escMap.isEmpty) {
      return true;
    } else {
      return false;
    }
  }

  static Future<void> insertNewTrip(TripModel T) async {
    Database db = await _openDB();

    db.insert("viaje", T.toEmptyMap());
    return;
  }

  static Future<TripModel> updateTrip(TripModel T) async {
    Database db = await _openDB();

    db.update('viaje', T.toMap(),
        where: '${T.tripID} = ?', whereArgs: [T.tripID]);

    List<Map<String, dynamic>> Q = await db
        .query('viaje', where: '${T.tripID} = ?', whereArgs: [T.tripID]);
    return List.generate(Q.length, (i) => T).first;
  }

  static Future<void> deleteTrip(int idTrip) async {
    Database db = await _openDB();
    db.delete('viaje', where: 'id_viaje = ?', whereArgs: [idTrip]);
  }

  static Future<List<TripModel>> getTrips() async {
    Database db = await _openDB();
    List<Map<String, dynamic>> Q = await db.query('viaje');
    return List.generate(
        Q.length,
        (i) => TripModel(
            tripID: Q[i]['id_viaje'],
            tripName: Q[i]['nombre_viaje'],
            activo: Q[i]['activo']));
  }

  static Future<int> getLastIDTrip() async {
    Database db = await _openDB();

    if (await isDBEmpty()) {
      return 1;
    }
    List<Map<String, dynamic>> Q =
        await db.rawQuery("SELECT max (id_viaje) from viaje");
    return Q[Q.length - 1]['max (id_viaje)'];
  }

  static Future<bool> verifyActiveTrip(int id) async {
    Database db = await _openDB();
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

  static Future<TripModel> getTripByID(int id) async {
    Database db = await _openDB();
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

  static Future<void> insertNewCompra(CompraModel c) async {
    Database db = await _openDB();
    db.insert('compra', c.toMap());
  }

  static Future<List<CompraModel>> getComprasTrip(int idTrip) async {
    Database db = await _openDB();

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

  static Future<void> updateCompra(CompraModel compra) async {
    Database db = await _openDB();

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

  static Future<void> deleteCompra(int idCompra) async {
    Database db = await _openDB();

    db.delete('compra', where: 'id_compra = ?', whereArgs: [idCompra]);
  }

  static Future<int> getLastIDCompra() async {
    Database db = await _openDB();

    List<Map<String, dynamic>> S =
        await db.rawQuery("SELECT MAX (id_compra) AS maxId FROM compra");
    if (S[0]['maxId'] == null) {
      return 1;
    } else {
      return S[0]['maxId'];
    }
  }

  static Future<void> insertNewGasto(GastoModel g) async {
    Database db = await _openDB();
    db.insert('gasto', g.toMap());
  }

  static Future<List<GastoModel>> getGastosTrip(int idTrip) async {
    Database db = await _openDB();

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

  static Future<void> updateGasto(GastoModel gasto) async {
    Database db = await _openDB();

    db.update('gasto', gasto.toMap(),
        where: 'id_viaje = ?', whereArgs: [gasto.tripID]);
  }

  static Future<void> deleteGasto(int idGasto) async {
    Database db = await _openDB();

    db.delete('gasto', where: 'id_viaje = ?', whereArgs: [idGasto]);
  }
}
