import 'package:trip_control_app/db/db_general.dart';

Future<void> initializeCountries(List<String> paises) async {
  if (await DB.hasCountries()) {
    await DB.insertCountries(paises);
  }
}
