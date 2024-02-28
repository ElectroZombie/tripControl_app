import 'package:flutter/material.dart';
import 'package:trip_control_app/utils/calculo_rentabilidad.dart';
import 'package:trip_control_app/utils/tuple.dart';

Widget form(cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2, rentR, rentKg,
    context) {
  return SingleChildScrollView(
      child: Column(children: [
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: (MediaQuery.of(context).size.width * 48) / 100,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                tileColor: Color.fromARGB(104, 105, 89, 112),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: const Text(
                  "CANTIDAD DE UNIDADES",
                  style: TextStyle(fontSize: 16),
                ),
                subtitle: TextFormField(
                  controller: cantU,
                  maxLength: 8,
                  keyboardType: TextInputType.number,
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 5),
              ListTile(
                tileColor: Color.fromARGB(104, 105, 89, 112),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Text("PESO TOTAL KG", style: TextStyle(fontSize: 16)),
                subtitle: TextFormField(
                  controller: pesoT,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 5),
              ListTile(
                tileColor: Color.fromARGB(104, 105, 89, 112),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Text("PAGO TOTAL M2", style: TextStyle(fontSize: 16)),
                subtitle: TextFormField(
                  controller: pagoM2,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width * 4) / 100,
        ),
        SizedBox(
          width: (MediaQuery.of(context).size.width * 48) / 100,
          child: ListView(
            shrinkWrap: true,
            children: [
              ListTile(
                tileColor: Color.fromARGB(104, 105, 89, 112),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Text("PRECIO POR UNIDAD EN CUP",
                    style: TextStyle(fontSize: 16)),
                subtitle: TextFormField(
                  controller: precioM1,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 5),
              ListTile(
                tileColor: Color.fromARGB(104, 105, 89, 112),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Text("CAMBIO CUP/USD", style: TextStyle(fontSize: 16)),
                subtitle: TextFormField(
                  controller: cambioM1,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(height: 5),
              ListTile(
                tileColor: Color.fromARGB(104, 105, 89, 112),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                title: Text("CAMBIO M2/USD", style: TextStyle(fontSize: 16)),
                subtitle: TextFormField(
                  controller: cambioM2,
                  maxLength: 8,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  style: TextStyle(fontSize: 14),
                ),
              ),
            ],
          ),
        )
      ],
    ),
    SizedBox(height: 5),
    TextButton(
      style: ButtonStyle(
          fixedSize: MaterialStatePropertyAll(Size(150, 50)),
          backgroundColor: MaterialStateColor.resolveWith(
              (states) => Color.fromARGB(161, 255, 255, 255)),
          overlayColor: MaterialStateColor.resolveWith(
              (states) => const Color.fromARGB(99, 104, 58, 183))),
      onPressed: () => save(cantU, pesoT, pagoM2, precioM1, cambioM1, cambioM2,
          rentR, rentKg, context),
      child: Text(
        "CONVERTIR",
        style: TextStyle(fontSize: 20),
      ),
    ),
    SizedBox(height: 5),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
            width: (MediaQuery.of(context).size.width * 42) / 100,
            child: ListTile(
              tileColor: Color.fromARGB(162, 90, 64, 102),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title: Text("RENTABILIDAD REAL", style: TextStyle(fontSize: 16)),
              subtitle: TextField(
                readOnly: true,
                controller: rentR,
                style: TextStyle(fontSize: 14),
              ),
            )),
        SizedBox(width: (MediaQuery.of(context).size.width * 10) / 100),
        SizedBox(
            width: (MediaQuery.of(context).size.width * 42) / 100,
            child: ListTile(
              tileColor: Color.fromARGB(162, 90, 64, 102),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              title:
                  Text("RENTABILIDAD POR KG", style: TextStyle(fontSize: 16)),
              subtitle: TextField(
                controller: rentKg,
                readOnly: true,
                style: TextStyle(fontSize: 14),
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
    TextEditingController rentKg,
    context) async {
  if (cantU.text.isEmpty ||
      pesoT.text.isEmpty ||
      pagoM2.text.isEmpty ||
      precioM1.text.isEmpty ||
      cambioM1.text.isEmpty ||
      cambioM2.text.isEmpty) {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title: Text('Error'),
            content: Text("Debe rellenar todos los campos"));
      },
    );
  } else {
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
}
