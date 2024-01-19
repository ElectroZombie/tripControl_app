import 'package:flutter/material.dart';

Widget form(cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2, keyForm) {
  return Column(
    children: [
      Text("Cantidad de unidades"),
      TextFormField(
        controller: cantU,
      ),
      Text("Peso Total"),
      TextFormField(
        controller: pesoT,
      ),
      Text("Pago total"),
      TextFormField(
        controller: pagoM2,
      ),
      Text("Precio en CUP"),
      TextFormField(
        controller: precioM1,
      ),
      Text("Cambio CUP/USD"),
      TextFormField(
        controller: cambioM1,
      ),
      Text("Cambio Moneda_2/USD"),
      TextFormField(
        controller: cambioM2,
      )
    ],
  );
}
