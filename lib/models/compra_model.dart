import 'package:trip_control_app/utils/id_element_model.dart';

class CompraModel extends IDElementModel {
  int tripID;
  String compraNombre;
  int cantU;
  double pesoT;
  double compraPrecio;
  double ventaCUPXUnidad;

  CompraModel(
      {required this.tripID,
      required super.id,
      required this.compraNombre,
      required this.cantU,
      required this.pesoT,
      required this.compraPrecio,
      required this.ventaCUPXUnidad});

  Map<String, dynamic> toMap() {
    return {
      'tripID': tripID,
      'id': id,
      'compraNombre': compraNombre,
      'cantU': cantU,
      'pesoT': pesoT,
      'compraPrecio': compraPrecio,
      'ventaCUPXUnidad': ventaCUPXUnidad
    };
  }
}
