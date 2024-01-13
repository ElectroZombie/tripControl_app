import 'package:trip_control_app/utils/id_element_model.dart';

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
      'id': id,
      'tripID': tripID,
      'gastoDescripcion': gastoDescripcion,
      'gastoMoney': gastoMoney,
    };
  }
}
