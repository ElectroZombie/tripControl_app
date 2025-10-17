import 'package:alforja/db/db_general.dart';

Future<void> initializeCountries(List<String> paises) async {
  if (await DB.hasCountries()) {
    await DB.insertCountries(paises);
  }
}

Future<void> setActivado(bool act) async {
  await DB.activate(act);
}

Future<bool> getActivado() async {
  return await DB.getAct();
}
