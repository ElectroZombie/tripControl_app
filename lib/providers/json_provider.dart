import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonProvider extends ChangeNotifier {
  List<String> listG = [];
  List<String> listW = [];
  String value = '';

  Random r = Random();

  List<String> getListG() => listG;
  List<String> getListW() => listW;
  String getValue() => value;

  setValues() async {
    await loadJsons();
    notifyListeners();
  }

  loadJsons() async {
    String jsonG = await _loadJsonG();
    String jsonW = await _loadJsonW();

    List<dynamic> jsonDataG = await jsonDecode(jsonG);
    List<dynamic> jsonDataW = await jsonDecode(jsonW);

    listG = List.generate(jsonDataG.length, (i) => jsonDataG[i]['word']);
    listW = List.generate(jsonDataW.length, (i) => jsonDataW[i]['sha_word']);
    value = listG[r.nextInt(147)];
  }

  static Future<String> _loadJsonG() async {
    return await rootBundle.loadString("assets/json/guayaba_words.json");
  }

  static Future<String> _loadJsonW() async {
    return await rootBundle.loadString("assets/json/sha_words.json");
  }
}
