import 'package:flutter/material.dart';
import 'button_widget.dart';
import 'package:url_launcher/url_launcher.dart';

Widget infoSheet(BuildContext context, ColorScheme colors) {
  return Stack(children: [
    SingleChildScrollView(
        child: Column(children: [
      Image.asset("assets/images/GuayabaLogo2.jpg"),
      Image.asset("assets/images/GuayabaLogo2.jpg")
    ])),
    SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                Text(
                  "Información:",
                  style: TextStyle(fontSize: 18, color: colors.surface),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 9.5 / 10,
                    child: Card(
                      color: const Color.fromARGB(0, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: colors.tertiary, width: 1.75),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 100),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 9 / 10,
                            child: Text(
                                "La aplicación para dispositivos móviles Controlador de Viajes ha sido creada con el objetivo"
                                "de brindar un apoyo a las personas que realizan viajes para comprar productos en el extranjero"
                                "y traer de regreso. Provee de una calculadora de rentabilidad de los productos, así como de un sistema"
                                "para llevar el control de las compras y gastos de los viajes realizados.",
                                maxLines: 11,
                                softWrap: true,
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: colors.surfaceContainerHighest,
                                )),
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 100),
                        ],
                      ),
                    )),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 9.5 / 10,
                    child: Card(
                      color: const Color.fromARGB(0, 0, 0, 0),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(color: colors.tertiary, width: 1.75),
                          borderRadius: BorderRadius.circular(5)),
                      child: Column(
                        children: [
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 100),
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 9 / 10,
                              child: Column(children: [
                                Text(
                                    "A mobile application to support travel checks for purchasing items\n"
                                    "v1.4.12\n"
                                    "Author:\n"
                                    "Eric Michel Villavicencio Reyes\n"
                                    "Buildig Specs:\n"
                                    "Java Version: 17.0.11\n"
                                    "SQLite 3 Version: 3.45.3\n"
                                    "Dart SDK: 3.4.0\n"
                                    "Built on:\n"
                                    "Flutter SDK: 3.22.0\n"
                                    "Android SDK: 31.0.0\n"
                                    "Code-OSS: 1.89.0",
                                    maxLines: 20,
                                    softWrap: true,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: colors.surfaceContainerHighest,
                                    )),
                                TextButton(
                                    style: buttonStyleWidget(colors),
                                    child: const Text("GitHub"),
                                    onPressed: () => _launchUrl()),
                              ])),
                          SizedBox(
                              height: MediaQuery.of(context).size.height / 100),
                        ],
                      ),
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 5 / 100),
                SizedBox(
                    width: MediaQuery.of(context).size.width * 4.5 / 10,
                    child: Card(
                        color: colors.tertiary,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: colors.tertiary, width: 1.75),
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 100),
                            IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(Icons.cancel),
                              style: iconButtonStyleWidget(colors),
                            ),
                            Text(
                              "Cerrar",
                              style: TextStyle(
                                  fontSize: 16, color: colors.onTertiary),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height / 100),
                          ],
                        )))
              ],
            ),
          ),
        ))
  ]);
}

Future<void> _launchUrl() async {
  if (!await launchUrl(
      mode: LaunchMode.platformDefault,
      Uri.http('github.com', '/ElectroZombie'))) {
    throw Exception('Could not launch https://github.com/ElectroZombie');
  }
}
