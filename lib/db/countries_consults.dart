import 'package:sqflite/sqflite.dart';

class CountriesConsults {
  static Future<List<String>> getCountries(Database db) async {
    List<Map<String, dynamic>> Q = await db.query("pais");
    if (Q.isEmpty) {
      return [];
    }
    return List.generate(Q.length, (i) => Q[i]['nombre_pais']);
  }

  static Future<void> insertCountries(Database db) async {
    await db.insert('pais', {'id_pais': 1, 'nombre_pais': "Cuba"});
    await db.insert('pais', {'id_pais': 2, 'nombre_pais': "Haiti"});
  }

  static Future<bool> hasCountries(Database db) async {
    List<Map<String, dynamic>> escMap = await db.query("pais");
    if (escMap.isEmpty) {
      return true;
    } else {
      return false;
    }
  }
}
