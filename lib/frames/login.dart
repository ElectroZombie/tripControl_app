import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:trip_control_app/db/db_general.dart';
import 'package:trip_control_app/methods/bar_message_method.dart';
import 'package:trip_control_app/widgets/object_widgets/button_widget.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  List<String> listG = [];
  List<String> listW = [];

  Random r = Random();

  String valor = "";

  TextEditingController passC = TextEditingController();

  loadJson() async {
    String jsonG = await _loadJsonG();
    String jsonW = await _loadJsonW();

    List<dynamic> jsonDataG = await jsonDecode(jsonG);
    List<dynamic> jsonDataW = await jsonDecode(jsonW);

    listG = List.generate(jsonDataG.length, (i) => jsonDataG[i]['word']);
    listW = List.generate(jsonDataW.length, (i) => jsonDataW[i]['sha_word']);

    setState(() {
      valor = listG[r.nextInt(147)];
    });
  }

  static Future<String> _loadJsonG() async {
    return await rootBundle.loadString("assets/json/guayaba_words.json");
  }

  static Future<String> _loadJsonW() async {
    return await rootBundle.loadString("assets/json/sha_words.json");
  }

  @override
  void initState() {
    super.initState();
    loadJson();
  }

  @override
  Widget build(BuildContext context) {
    var colors = Theme.of(context).colorScheme;
    return Scaffold(
        backgroundColor: colors.surfaceContainerHighest,
        appBar: AppBar(
          backgroundColor: colors.onPrimaryFixedVariant,
          title: const Text(
            "LOGIN",
            style: TextStyle(fontSize: 20),
          ),
          leading: const Icon(Icons.login),
        ),
        body: Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(
                top: (MediaQuery.of(context).size.height * 0.5) / 10),
            child: SizedBox(
                width: (MediaQuery.of(context).size.width * 9) / 10,
                height: (MediaQuery.of(context).size.height * 3.5) / 10,
                child: Stack(children: [
                  Row(children: [
                    const SizedBox(width: 10),
                    CircleAvatar(
                        backgroundColor: colors.tertiary,
                        child: Icon(
                          Icons.person,
                          color: colors.onTertiary,
                        ))
                  ]),
                  Column(children: [
                    const SizedBox(
                      height: 7,
                    ),
                    ListTile(
                        tileColor: colors.primary,
                        shape: RoundedRectangleBorder(
                            side:
                                BorderSide(color: colors.tertiary, width: 1.75),
                            borderRadius: BorderRadius.circular(5)),
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                        subtitle: Column(
                          children: [
                            SizedBox(
                                height: (MediaQuery.of(context).size.height *
                                        0.10) /
                                    10),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: () => copy(valor, context),
                                    icon: const Icon(Icons.copy_rounded),
                                    tooltip: "COPIAR",
                                  ),
                                  Text(
                                    valor,
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Times new roman"),
                                  )
                                ]),
                            SizedBox(
                                height: (MediaQuery.of(context).size.height *
                                        0.35) /
                                    10),
                            TextFormField(
                              decoration: InputDecoration(
                                  icon: const Icon(Icons.text_fields_rounded),
                                  fillColor: colors.surface,
                                  labelText: "INTRODUZCA LA CLAVE",
                                  labelStyle: const TextStyle(fontSize: 10),
                                  filled: true,
                                  constraints: BoxConstraints.loose(
                                      const Size.fromHeight(35)),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                          color: colors.tertiary, width: 1.75),
                                      borderRadius: BorderRadius.circular(10))),
                              cursorColor: colors.tertiary,
                              controller: passC,
                              maxLength: null,
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  fontSize: 12, color: colors.onPrimary),
                              onEditingComplete: () {
                                try {
                                  checkWord(passC, listW, context);
                                } catch (e) {
                                  //
                                }
                              },
                            ),
                            SizedBox(
                                height: (MediaQuery.of(context).size.height *
                                        0.35) /
                                    10),
                            TextButton(
                              onPressed: () =>
                                  {checkWord(passC, listW, context)},
                              style: buttonStyleWidget(colors),
                              child: const Text("LOGIN"),
                            )
                          ],
                        ))
                  ])
                ]))));
  }
}

checkWord(TextEditingController controller, listW, context) {
  String text = controller.value.text;

  String convert = sha256.convert(utf8.encode(text)).toString();

  if (listW.contains(convert)) {
    acceptCode(context);
  } else {
    declineCode(context);
  }
}

copy(String valor, context) async {
  Clipboard.setData(ClipboardData(text: valor));
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Aviso'),
          content: const Text(
            "Texto copiado al portapapeles",
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(
                    context); // Cerrar el diálogo sin agregar la unidad
              },
              child: const Text('OK'),
            ),
          ],
        );
      });
}

acceptCode(context) async {
  await DB.activate(true);
  notifyActivationSuccess("Activación Completa", Colors.green, context);
}

declineCode(context) {
  notifyActivationFailure("Clave Incorrecta", Colors.redAccent, context);
}