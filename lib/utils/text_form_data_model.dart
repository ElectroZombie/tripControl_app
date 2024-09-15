import 'package:flutter/material.dart';
import 'package:trip_control_app/utils/id_element_model.dart';

class TextFormDataModel extends IDElementModel {
  String text;
  bool readOnly;
  bool decimal;
  bool hasTitle;
  TextEditingController controller;
  Function func;

  TextFormDataModel(
      {required super.id,
      required this.text,
      required this.readOnly,
      required this.decimal,
      required this.hasTitle,
      required this.controller,
      required this.func});
}
