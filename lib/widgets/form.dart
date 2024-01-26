import 'package:flutter/material.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/utils/calculo_rentabilidad.dart';
import 'package:trip_control_app/utils/tuple.dart';

Widget form(cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2, rentR, rentKg) {
  return SingleChildScrollView(
      child: Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 300,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text("Cantidad de unidades compradas"),
                subtitle: TextFormField(
                  controller: cantU,
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                ),
              ),
              ListTile(
                title: Text("Peso total en kg"),
                subtitle: TextFormField(
                  controller: pesoT,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              ListTile(
                title: Text("Pago total en Moneda_2"),
                subtitle: TextFormField(
                  controller: pagoM2,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 50,
        ),
        SizedBox(
          width: 300,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                title: Text("Precio de cada unidad en CUP"),
                subtitle: TextFormField(
                  controller: precioM1,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              ListTile(
                title: Text("Cambio CUP/USD"),
                subtitle: TextFormField(
                  controller: cambioM1,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
              ListTile(
                title: Text("Cambio Moneda_2/USD"),
                subtitle: TextFormField(
                  controller: cambioM2,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                ),
              ),
            ],
          ),
        )
      ],
    ),
    TextButton(
      onPressed: () => save(
          cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2, rentR, rentKg),
      child: Text("Convertir"),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: 200,
            child: ListTile(
              title: Text("Rentabilidad real"),
              subtitle: TextFormField(
                enabled: false,
                controller: rentR,
              ),
            )),
        SizedBox(
            width: 200,
            child: ListTile(
              title: Text("Rentabilidad por kg"),
              subtitle: TextFormField(
                enabled: false,
                controller: rentKg,
              ),
            ))
      ],
    ),
  ]));
}

void save(
    TextEditingController cantU,
    TextEditingController pesoT,
    TextEditingController pagoM2,
    TextEditingController precioM1,
    TextEditingController cambioM1,
    TextEditingController cambioM2,
    TextEditingController rentR,
    TextEditingController rentKg) {
  Tuple t = calculoRentabilidad(
      int.parse(cantU.text),
      double.parse(pesoT.text),
      double.parse(pagoM2.text),
      double.parse(precioM1.text),
      double.parse(cambioM1.text),
      double.parse(cambioM2.text));

  String rr = (t.T as double).toString();
  String rk = (t.K as double).toString();
  rentR.value = TextEditingValue(text: rr);
  rentKg.value = TextEditingValue(text: rk);
}
