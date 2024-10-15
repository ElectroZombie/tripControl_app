import 'package:flutter/material.dart';
import 'package:trip_control_app/utils/tuple.dart';

Widget rentabilityWidget(List<Tuple<double, String>> data, context) {
  return Container(
      height: 150,
      alignment: Alignment.center,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: data.length,
            itemBuilder: (context, i) {
              return Row(
                children: [
                  const SizedBox(width: 10),
                  Column(children: [
                    Text(
                      "${data[i].K}",
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 1),
                    CircleAvatar(
                        radius: 40,
                        backgroundColor: selectColor(data[i].T!, context),
                        child: Text("${data[i].T!.toStringAsFixed(2)} \$")),
                  ]),
                  const SizedBox(
                    width: 10,
                  )
                ],
              );
            }),
      ));
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
