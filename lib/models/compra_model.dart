import 'package:alforja/utils/id_element_model.dart';

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
      'id_compra': id,
      'id_viaje': tripID,
      'nombre_compra': compraNombre,
      'peso_total': pesoT,
      'cant_unidades': cantU,
      'compra_precio': compraPrecio,
      'ventaCUP': ventaCUPXUnidad
    };
  }
}
