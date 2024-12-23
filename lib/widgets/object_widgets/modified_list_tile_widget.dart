import 'package:flutter/material.dart';

import '../../utils/text_form_data_model.dart';

Widget modifiedListTileWidget(
    IconData icon, String title, Widget subtitle, context) {
  ColorScheme colors = Theme.of(context).colorScheme;
  return Stack(children: [
    Row(children: [
      const SizedBox(width: 10),
      CircleAvatar(
          backgroundColor: colors.tertiary,
          child: Icon(
            icon,
            color: colors.onTertiary,
          ))
    ]),
    Column(children: [
      const SizedBox(
        height: 7,
      ),
      ListTile(
          titleAlignment: ListTileTitleAlignment.titleHeight,
          title: Text(title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 14)),
          tileColor: colors.primary,
          shape: RoundedRectangleBorder(
              side: BorderSide(color: colors.tertiary, width: 1.75),
              borderRadius: BorderRadius.circular(20)),
          subtitle: subtitle)
    ])
  ]);
}

Widget modifiedListTileSubtitleWidget(
    List<TextFormDataModel> data, context, Object obj,
    {required bool singleton}) {
  ColorScheme colors = Theme.of(context).colorScheme;
  return ListView.builder(
    shrinkWrap: true,
    itemCount: data.length * 2,
    itemBuilder: (BuildContext context, int i) {
      if (i % 2 == 0) {
        return SizedBox(height: (MediaQuery.of(context).size.height * 2) / 100);
      } else {
        int index = (i - 1) ~/ 2;
        return TextFormField(
          decoration: InputDecoration(
              icon: data[index].getLabelIcon(),
              fillColor: colors.surface,
              labelText: data[index].text,
              labelStyle: const TextStyle(fontSize: 10),
              filled: true,
              constraints: BoxConstraints.loose(const Size.fromHeight(35)),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: colors.tertiary, width: 1.75),
                  borderRadius: BorderRadius.circular(10))),
          cursorColor: colors.tertiary,
          controller: data[index].controller,
          maxLength: null,
          readOnly: data[index].readOnly,
          keyboardType: data[index].getTextInputType(),
          style: const TextStyle(fontSize: 12),
          onEditingComplete: () {
            try {
              data[index]
                  .func(data[index].controller.text, obj, context, singleton);
            } catch (e) {
              //
            }
          },
        );
      }
    },
  );
}
