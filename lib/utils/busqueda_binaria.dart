import 'package:trip_control_app/utils/id_element_model.dart';

int busquedaBinaria(List<IDElementModel> L, IDElementModel E) {
  int ini = 0;
  int fin = L.length;

  while (fin - ini > 1) {
    int mid = ((ini + fin) / 2) as int;
    if (E.id < L[mid].id) {
      fin = mid;
      continue;
    } else if (E.id > L[mid].id) {
      ini = mid;
      continue;
    } else if (E.id == L[mid].id) {
      ini = mid;
      break;
    }
  }

  return ini;
}
