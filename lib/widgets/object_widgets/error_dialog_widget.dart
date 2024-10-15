import 'package:flutter/material.dart';

void errorDialogWidget(String text, BuildContext context) async {
  ColorScheme colors = Theme.of(context).colorScheme;
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('ERROR'),
        backgroundColor: colors.surface,
        content: Text(
          text,
          style: const TextStyle(fontSize: 14),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.cancel),
            style: iconButtonStyle(context),
          )
        ],
      );
    },
  );
}

iconButtonStyle(context) {
  ColorScheme colors = Theme.of(context).colorScheme;
  return ButtonStyle(
      fixedSize: const WidgetStatePropertyAll(Size(45, 45)),
      backgroundColor: WidgetStatePropertyAll(colors.secondary),
      shadowColor: WidgetStatePropertyAll(colors.tertiary),
      overlayColor: WidgetStatePropertyAll(colors.onPrimaryFixedVariant),
      foregroundColor: WidgetStatePropertyAll(colors.onSecondary),
      textStyle: WidgetStatePropertyAll(TextStyle(
          fontSize: 12,
          color: colors.onSecondary,
          fontWeight: FontWeight.bold)),
      shape: WidgetStatePropertyAll(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
          side: BorderSide(color: colors.tertiary, width: 1.75))));
}
