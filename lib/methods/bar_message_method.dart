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
