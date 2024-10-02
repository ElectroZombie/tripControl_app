import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_control_app/db/initialize_db.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/frames/login.dart';
import 'package:trip_control_app/frames/trip_frames/new_trip_control.dart';
import 'package:trip_control_app/frames/principal.dart';
import 'package:trip_control_app/frames/trip_frames/current_trip_control.dart';
import 'package:trip_control_app/frames/trip_frames/trip_data.dart';
import 'package:trip_control_app/frames/trip_frames/trip_list.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:trip_control_app/frames/trip_frames/update_trip_singleton.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  bool activado = true;

  List<String> paises = [
    'Afganistán',
    'Albania',
    'Alemania',
    'Andorra',
    'Angola',
    'Antigua y Barbuda',
    'Arabia Saudita',
    'Argelia',
    'Argentina',
    'Armenia',
    'Australia',
    'Austria',
    'Azerbaiyán',
    'Bahamas',
    'Bangladés',
    'Barbados',
    'Baréin',
    'Bélgica',
    'Belice',
    'Benín',
    'Bielorrusia',
    'Birmania',
    'Bolivia',
    'Bosnia y Herzegovina',
    'Botsuana',
    'Brasil',
    'Brunéi',
    'Bulgaria',
    'Burkina Faso',
    'Burundi',
    'Bután',
    'Cabo Verde',
    'Camboya',
    'Camerún',
    'Canadá',
    'Catar',
    'Chad',
    'Chile',
    'China',
    'Chipre',
    'Ciudad del Vaticano',
    'Colombia',
    'Comoras',
    'Corea del Norte',
    'Corea del Sur',
    'Costa de Marfil',
    'Costa Rica',
    'Croacia',
    'Cuba',
    'Dinamarca',
    'Dominica',
    'Ecuador',
    'Egipto',
    'El Salvador',
    'Emiratos Árabes Unidos',
    'Eritrea',
    'Eslovaquia',
    'Eslovenia',
    'España',
    'Estados Unidos',
    'Estonia',
    'Etiopía',
    'Filipinas',
    'Finlandia',
    'Fiyi',
    'Francia',
    'Gabón',
    'Gambia',
    'Georgia',
    'Ghana',
    'Granada',
    'Grecia',
    'Guatemala',
    'Guyana',
    'Guinea',
    'Guinea ecuatorial',
    'Guinea-Bisáu',
    'Haití',
    'Honduras',
    'Hungría',
    'India',
    'Indonesia',
    'Irak',
    'Irán',
    'Irlanda',
    'Islandia',
    'Islas Marshall',
    'Islas Salomón',
    'Israel',
    'Italia',
    'Jamaica',
    'Japón',
    'Jordania',
    'Kazajistán',
    'Kenia',
    'Kirguistán',
    'Kiribati',
    'Kuwait',
    'Laos',
    'Lesoto',
    'Letonia',
    'Líbano',
    'Liberia',
    'Libia',
    'Liechtenstein',
    'Lituania',
    'Luxemburgo',
    'Macedonia del Norte',
    'Madagascar',
    'Malasia',
    'Malaui',
    'Maldivas',
    'Maldivas',
    'Malta',
    'Marruecos',
    'Mauricio',
    'Mauritania',
    'México',
    'Micronesia',
    'Moldavia',
    'Mónaco',
    'Mongolia',
    'Montenegro',
    'Mozambique',
    'Namibia',
    'Nauru',
    'Nepal',
    'Nicaragua',
    'Níger',
    'Nigeria',
    'Noruega',
    'Nueva Zelanda',
    'Omán',
    'Países Bajos',
    'Pakistán',
    'Palaos',
    'Panamá',
    'Papúa Nueva Guinea',
    'Paraguay',
    'Perú',
    'Polonia',
    'Portugal',
    'Reino Unido',
    'República Centroafricana',
    'República Checa',
    'República del Congo',
    'República Democrática del Congo',
    'República Dominicana',
    'República Sudafricana',
    'Ruanda',
    'Rumanía',
    'Rusia',
    'Samoa',
    'San Cristóbal y Nieves',
    'San Marino',
    'San Vicente y las Granadinas',
    'Santa Lucía',
    'Santo Tomé y Príncipe',
    'Senegal',
    'Serbia',
    'Seychelles',
    'Sierra Leona',
    'Singapur',
    'Siria',
    'Somalia',
    'Splerga',
    'Sri Lanka',
    'Suazilandia',
    'Sudán',
    'Sudán del Sur',
    'Suecia',
    'Suiza',
    'Surinam',
    'Tailandia',
    'Tanzania',
    'Tayikistán',
    'Timor Oriental',
    'Togo',
    'Tonga',
    'Trinidad y Tobago',
    'Túnez',
    'Turkmenistán',
    'Turquía',
    'Tuvalu',
    'Ucrania',
    'Uganda',
    'Uruguay',
    'Uzbekistán',
    'Vanuatu',
    'Venezuela',
    'Vietnam',
    'Yemen',
    'Yibuti',
    'Zambia',
    'Zimbabue'
  ];

  if (Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    await initializeCountries(paises);
    activado = await getActivado();
  } else {
    await initializeCountries(paises);
    activado = await getActivado();
  }

  if (isFirstTime) {
    await initializeCountries(paises);
    await prefs.setBool('isFirstTime', false);
    activado = await getActivado();
    activado = false;
    await setActivado(activado);
  }

  runApp(MainApp(
    activado: activado,
  ));
}

// ignore: must_be_immutable
class MainApp extends StatelessWidget {
  bool activado = true;
  MainApp({super.key, required this.activado});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: "Arial",
          colorScheme: const ColorScheme.light(
              surface: Color.fromARGB(246, 246, 248, 218),
              surfaceContainerHighest: Color.fromARGB(235, 242, 242, 235),
              primary: Color.fromARGB(106, 130, 175, 218),
              primaryFixed: Color.fromARGB(149, 10, 100, 142),
              secondary: Color.fromARGB(153, 20, 46, 50),
              tertiary: Color.fromARGB(255, 27, 59, 73),
              onPrimaryFixedVariant: Color.fromARGB(100, 120, 170, 200),
              onPrimary: Color.fromARGB(255, 7, 8, 8),
              onSecondary: Color.fromARGB(255, 195, 203, 203),
              onSurface: Color.fromARGB(255, 7, 8, 8)),
          useMaterial3: true),
      debugShowCheckedModeBanner: false,
      initialRoute: checkActivado(),
      routes: {
        '/principal': (context) => const Principal(),
        '/calculator': (BuildContext context) => const Calculator(),
        '/new_trip_control': (BuildContext context) => const NewTripControl(),
        '/current_trip_control': (BuildContext context) =>
            const CurrentTripControl(),
        '/update_trip_singleton': (BuildContext context) =>
            const UpdateTripSingleton(),
        '/trip_data': (BuildContext context) => const TripData(),
        '/trip_list': (BuildContext context) => const TripList(),
        '/login': (BuildContext context) => const Login()
      },
    );
  }

  String checkActivado() {
    if (activado) {
      return '/principal';
    } else {
      return '/login';
    }
  }
}
