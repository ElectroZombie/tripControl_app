import 'package:flutter/material.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';

void errorDialogWidget(
    String text, ColorScheme colors, BuildContext context) async {
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
            style: iconButtonStyleWidget(colors),
          )
        ],
      );
    },
  );
}
