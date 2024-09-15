import 'package:flutter/material.dart';

Widget rentabilityWidget(double rentR, double rentKg, double rentP, context) {
  return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
    Column(children: [
      const Text(
        "RENTABILIDAD",
        style: TextStyle(fontSize: 12),
      ),
      const SizedBox(height: 0.1),
      const Text(
        "",
        style: TextStyle(fontSize: 12),
      ),
      CircleAvatar(
          radius: 35,
          backgroundColor: selectColor(rentR, context),
          child: Text("${rentR.toStringAsFixed(2)} \$"))
    ]),
    SizedBox(width: (MediaQuery.of(context).size.width * 0.25) / 10),
    Column(
      children: [
        const Text(
          "RENTABILIDAD",
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 0.1),
        const Text(
          "POR KG",
          style: TextStyle(fontSize: 12),
        ),
        CircleAvatar(
            radius: 35,
            backgroundColor: selectColor(rentKg, context),
            child: Text("${rentKg.toStringAsFixed(2)} \$"))
      ],
    ),
    SizedBox(width: (MediaQuery.of(context).size.width * 0.25) / 10),
    Column(
      children: [
        const Text(
          "RENTABILIDAD",
          style: TextStyle(fontSize: 12),
        ),
        const SizedBox(height: 0.1),
        const Text(
          "PORCENTUAL",
          style: TextStyle(fontSize: 12),
        ),
        CircleAvatar(
            radius: 35,
            backgroundColor: selectColor(rentP, context),
            child: Text("${rentP.toStringAsFixed(2)} %"))
      ],
    )
  ]);
}

Color selectColor(double n, context) {
  if (n > 0) {
    return Colors.green;
  } else if (n < 0) {
    return Colors.redAccent;
  } else {
    return Theme.of(context).colorScheme.primary;
  }
}
