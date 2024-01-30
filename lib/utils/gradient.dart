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
            Color.fromARGB(170, 47, 128, 182),
            Color.fromARGB(255, 77, 36, 131)
          ])));
}
