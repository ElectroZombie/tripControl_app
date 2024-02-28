import 'package:flutter/material.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/widgets/form.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  CalculatorState createState() => CalculatorState();
}

TextEditingController cantU = TextEditingController();
TextEditingController pesoT = TextEditingController();
TextEditingController pagoM2 = TextEditingController();
TextEditingController precioM1 = TextEditingController();
TextEditingController cambioM1 = TextEditingController();
TextEditingController cambioM2 = TextEditingController();
TextEditingController rentR = TextEditingController();
TextEditingController rentK = TextEditingController();

class CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      gradient(),
      Form(
          child: form(cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2, rentR,
              rentK, context)),
    ]);
  }
}
