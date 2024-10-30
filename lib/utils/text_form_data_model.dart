import 'package:flutter/material.dart';
import 'package:trip_control_app/utils/id_element_model.dart';
import 'package:trip_control_app/utils/tuple.dart';

import 'enum_types.dart';

class TextFormDataModel extends IDElementModel {
  String text;
  bool readOnly;
  bool hasTitle;
  InputTypes inputType;
  TextEditingController controller;
  Function func;

  final Map<InputTypes, Tuple<TextInputType, Icon>> inputTypes = {
    InputTypes.text:
        Tuple(T: TextInputType.text, K: const Icon(Icons.text_fields)),
    InputTypes.number:
        Tuple(T: TextInputType.number, K: const Icon(Icons.numbers)),
    InputTypes.numberDecimal: Tuple(
        T: const TextInputType.numberWithOptions(decimal: true),
        K: const Icon(Icons.numbers)),
    InputTypes.email:
        Tuple(T: TextInputType.emailAddress, K: const Icon(Icons.email)),
    InputTypes.phone: Tuple(T: TextInputType.phone, K: const Icon(Icons.phone)),
    InputTypes.url: Tuple(T: TextInputType.url, K: const Icon(Icons.link)),
  };

  TextFormDataModel(
      {required super.id,
      required this.text,
      required this.readOnly,
      required this.hasTitle,
      required this.inputType,
      required this.controller,
      required this.func});

  Icon? getLabelIcon() {
    return inputTypes[inputType]!.K;
  }

  TextInputType? getTextInputType() {
    return inputTypes[inputType]!.T;
  }
}
