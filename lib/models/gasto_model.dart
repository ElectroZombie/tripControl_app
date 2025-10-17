import 'package:alforja/utils/id_element_model.dart';

class GastoModel extends IDElementModel {
  int tripID;
  String gastoDescripcion;
  double gastoMoney;

  GastoModel({
    required super.id,
    required this.tripID,
    required this.gastoDescripcion,
    required this.gastoMoney,
  });

  Map<String, dynamic> toMap() {
    return {
      'id_gasto': id,
      'id_viaje': tripID,
      'descripcion_gasto': gastoDescripcion,
      'gasto_money': gastoMoney,
    };
  }
}
