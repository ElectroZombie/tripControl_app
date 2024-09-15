import 'package:flutter/material.dart';
import 'package:trip_control_app/widgets/frame_widgets/calculator_widget.dart';

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
double rentR = 0.0;
double rentK = 0.0;
double rentP = 0.0;

class CalculatorState extends State<Calculator> {
  callbackCalculate(rentRe, rentKg, rentPo) {
    setState(() {
      rentR = rentRe;
      rentK = rentKg;
      rentP = rentPo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        child: calculator(cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2,
            rentR, rentK, rentP, context, callbackCalculate));
  }
}
