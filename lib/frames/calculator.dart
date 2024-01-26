import 'package:flutter/material.dart';
import 'package:trip_control_app/db/db.dart';
import 'package:trip_control_app/utils/gradient.dart';
import 'package:trip_control_app/widgets/form.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  CalculatorState createState() => CalculatorState();
}

TextEditingController cantU = new TextEditingController();
TextEditingController pesoT = new TextEditingController();
TextEditingController pagoM2 = new TextEditingController();
TextEditingController precioM1 = new TextEditingController();
TextEditingController cambioM1 = new TextEditingController();
TextEditingController cambioM2 = new TextEditingController();
TextEditingController rentR = new TextEditingController();
TextEditingController rentK = new TextEditingController();

class CalculatorState extends State<Calculator> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora'),
      ),
      body: Stack(children: [
        gradient(),
        Form(
            child: form(cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2,
                rentR, rentK)),
      ]),
    );
  }
}
