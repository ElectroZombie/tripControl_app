import 'package:flutter/material.dart';

Widget gradient() {
  return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: FractionalOffset(0.0, 0.1),
              end: FractionalOffset(0.0, 1.0),
              colors: [
            Color.fromARGB(170, 47, 182, 99),
            Color.fromARGB(255, 233, 187, 87)
          ])));
}
