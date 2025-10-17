import 'dart:io';

// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:alforja/db/countries_consults.dart';
import 'package:alforja/models/compra_model.dart';
import 'package:alforja/models/gasto_model.dart';
import 'package:alforja/models/trip_model.dart';
import 'package:alforja/db/trip_consults.dart';
import 'package:alforja/db/compras_consults.dart';
import 'package:alforja/db/gastos_consults.dart';

class DB {
  static Future<Database> _openDB() async {
    if (Platform.isAndroid) {
      return openDatabase(
        join(await getDatabasesPath(), 'tripControl.db'),
        onCreate: (db, version) async {
          await db.execute(
              "CREATE TABLE viaje (id_viaje INTEGER PRIMARY KEY, nombre_viaje TEXT, activo INTEGER, precio_M1 DOUBLE, precio_M2 DOUBLE, nombre_pais TEXT, fecha_inicio_viaje TEXT, fecha_final_viaje TEXT)");
          await db.execute(
              "CREATE TABLE compra (id_compra INTEGER PRIMARY KEY, id_viaje INTEGER, nombre_compra TEXT, peso_total DOUBLE, cant_unidades INTEGER, compra_precio DOUBLE, ventaCUP DOUBLE)");
          await db.execute(
              "CREATE TABLE gasto (id_gasto INTEGER PRIMARY KEY, id_viaje INTEGER, descripcion_gasto TEXT, gasto_money DOUBLE)");
          await db.execute(
              "CREATE TABLE pais (id_pais INTEGER PRIMARY KEY, nombre_pais TEXT)");
          await db.execute("CREATE TABLE activate (act INTEGER)");
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
                "CREATE TABLE viaje (id_viaje INTEGER PRIMARY KEY, nombre_viaje TEXT, activo INTEGER, precio_M1 DOUBLE, precio_M2 DOUBLE, nombre_pais TEXT, fecha_inicio_viaje TEXT, fecha_final_viaje TEXT)");
            await db.execute(
                "CREATE TABLE compra (id_compra INTEGER PRIMARY KEY, id_viaje INTEGER, nombre_compra TEXT, peso_total DOUBLE, cant_unidades INTEGER, compra_precio DOUBLE, ventaCUP DOUBLE)");
            await db.execute(
                "CREATE TABLE gasto (id_gasto INTEGER PRIMARY KEY, id_viaje INTEGER, descripcion_gasto TEXT, gasto_money DOUBLE)");
            await db.execute(
                "CREATE TABLE pais (id_pais INTEGER PRIMARY KEY, nombre_pais TEXT)");
            await db.execute("CREATE TABLE activate (act INTEGER)");
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

  static Future<void> activate(bool act) async {
    Database db = await _openDB();
    int e = act == true ? 1 : 0;
    List<Map<String, dynamic>> Q = await db.query("activate");
    if (Q.isEmpty) {
      await db.insert("activate", {'act': e});
    } else {
      await db.rawUpdate("UPDATE activate SET act = ?", [e]);
    }
  }

  static Future<bool> getAct() async {
    Database db = await _openDB();

    List<Map<String, dynamic>> Q = await db.query("activate");
    if (Q.isEmpty) {
      return false;
    } else {
      return List.generate(Q.length, (i) => Q[i]['act'])[0] == 0 ? false : true;
    }
  }

//Consultas de pais
  static Future<List<String>> getCountries() async {
    Database db = await _openDB();

    return await CountriesConsults.getCountries(db);
  }

  static Future<void> insertCountries(List<String> paises) async {
    Database db = await _openDB();
    await CountriesConsults.insertCountries(db, paises);
  }

  static Future<bool> hasCountries() async {
    Database db = await _openDB();
    return await CountriesConsults.hasCountries(db);
  }
//Consultas de pais

//Consultas de viaje
  static Future<void> insertNewTrip(TripModel T) async {
    Database db = await _openDB();
    TripConsults.insertNewTrip(db, T);
  }

  static Future<void> updateTrip(TripModel T) async {
    Database db = await _openDB();
    TripConsults.updateTrip(db, T);
  }

  static Future<void> updatePaisTrip(int idTrip, String pais) async {
    Database db = await _openDB();
    await TripConsults.updatePaisTrip(db, idTrip, pais);
  }

  static Future<void> updateFechaInicioTrip(
      int idTrip, DateTime fechaInicio) async {
    Database db = await _openDB();
    await TripConsults.updateFechaInicioTrip(db, idTrip, fechaInicio);
  }

  static Future<void> updateFechaFinalTrip(
      int idTrip, DateTime fechaFinal) async {
    Database db = await _openDB();
    await TripConsults.updateFechaFinalTrip(db, idTrip, fechaFinal);
  }

  static Future<void> deleteTrip(int idTrip) async {
    Database db = await _openDB();
    TripConsults.deleteTrip(db, idTrip);
  }

  static Future<List<TripModel>> getTrips() async {
    Database db = await _openDB();
    return TripConsults.getTrips(db);
  }

  static Future<int> getLastIDTrip() async {
    Database db = await _openDB();
    return TripConsults.getLastIDTrip(db);
  }

  static Future<bool> verifyActiveTrip(int id) async {
    Database db = await _openDB();
    return TripConsults.verifyActiveTrip(db, id);
  }

  static Future<TripModel> getTripByID(int id) async {
    Database db = await _openDB();
    return TripConsults.getTripByID(db, id);
  }

  static Future<void> endTrip(int idTrip, String fechaFinal) async {
    Database db = await _openDB();
    TripConsults.endTrip(db, idTrip, fechaFinal);
  }

  static Future<bool> activateTrip(int idTrip) async {
    Database db = await _openDB();
    if (await TripConsults.verifyActiveTrips(db)) {
      await TripConsults.activateTrip(db, idTrip);
      return true;
    } else {
      return false;
    }
  }
  //Consultas de viaje

  //Consultas de compras
  static Future<void> insertNewCompra(CompraModel c) async {
    Database db = await _openDB();
    CompraConsults.insertNewCompra(db, c);
  }

  static Future<List<CompraModel>> getComprasTrip(int idTrip) async {
    Database db = await _openDB();
    return CompraConsults.getComprasTrip(db, idTrip);
  }

  static Future<void> updateCompra(CompraModel compra) async {
    Database db = await _openDB();
    CompraConsults.updateCompra(db, compra);
  }

  static Future<void> deleteCompra(int idCompra) async {
    Database db = await _openDB();
    CompraConsults.deleteCompra(db, idCompra);
  }

  static Future<int> getLastIDCompra() async {
    Database db = await _openDB();
    return CompraConsults.getLastIDCompra(db);
  }
  //Consultas de compras

  //Consultas de gastos
  static Future<void> insertNewGasto(GastoModel g) async {
    Database db = await _openDB();
    GastoConsults.insertNewGasto(db, g);
  }

  static Future<List<GastoModel>> getGastosTrip(int idTrip) async {
    Database db = await _openDB();
    return GastoConsults.getGastosTrip(db, idTrip);
  }

  static Future<void> updateGasto(GastoModel gasto) async {
    Database db = await _openDB();
    GastoConsults.updateGasto(db, gasto);
  }

  static Future<void> deleteGasto(int idGasto) async {
    Database db = await _openDB();
    GastoConsults.deleteGasto(db, idGasto);
  }

  static Future<int> getLastIDGasto() async {
    Database db = await _openDB();
    return GastoConsults.getLastIDGasto(db);
  }
  //Consultas de gastos
}
