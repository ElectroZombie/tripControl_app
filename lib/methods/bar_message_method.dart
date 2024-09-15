import 'package:flutter/material.dart';

void notifySuccessPDF(String x, Color c, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: c,
      content: Text(x),
      elevation: 10,
      showCloseIcon: true,
    ),
  );
}

void notifyActivationSuccess(String x, Color c, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: c,
      content: Text(x),
      elevation: 10,
      action: SnackBarAction(
          label: "Continuar",
          onPressed: () =>
              {Navigator.pushReplacementNamed(context, '/principal')}),
      duration: const Duration(days: 1),
    ),
  );
}

void notifyActivationFailure(String x, Color c, context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: c,
      content: Text(x),
      elevation: 10,
      showCloseIcon: true,
    ),
  );
}
