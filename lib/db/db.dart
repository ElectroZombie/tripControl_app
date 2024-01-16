import 'package:sqflite/sqflite.dart';
// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:trip_control_app/models/trip_model.dart';

class DB {
  static Future<Database> _openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'trip_control.db'),
      onCreate: (db, version) async {
        await db.execute(
          "CREATE TABLE viaje (id_viaje INTEGER PRIMARY KEY, nombre_viaje TEXT, precio_M1 DOUBLE, precio_M2 DOUBLE, gasto_total DOUBLE, gasto_compras DOUBLE, gasto_otros DOUBLE, gananciaCompraReal DOUBLE, gananciaCompraKilo DOUBLE, gastoCompraKilo DOUBLE, rentabilidad DOUBLE, rentabilidadKilo DOUBLE, rentabilidadPorcentual DOUBLE)"
          "CREATE TABLE compra (id_compra INTEGER PRIMARY KEY, id_viaje INTEGER, nombre_compra TEXT, peso_total DOUBLE, cant_unidades INTEGER, compra_precio DOUBLE, ventaCUP DOUBLE)"
          "CREATE TABLE gasto (id_gasto INTEGER PRIMARY KEY, id_viaje INTEGER, descripcion_gasto TEXT, gasto_money DOUBLE)",
        );
      },
      version: 1,
    );
  }

  static Future<void> insertNewTrip(TripModel T) async {
    Database db = await _openDB();

    db.insert("viaje", T.toMap());
    return;
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
}
