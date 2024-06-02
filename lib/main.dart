import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:trip_control_app/db/initialize_db.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/frames/trip_frames/new_trip_control.dart';
import 'package:trip_control_app/frames/principal.dart';
import 'package:trip_control_app/frames/trip_frames/current_trip_control.dart';
import 'package:trip_control_app/frames/trip_frames/trip_data.dart';
import 'package:trip_control_app/frames/trip_frames/trip_list.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:trip_control_app/frames/trip_frames/update_trip_singleton.dart';

void main() async {
  runApp(const MainApp());

  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

  if (Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    await initializeCountries();
  } else {
    await initializeCountries();
  }

  if (isFirstTime) {
    await initializeCountries();
    await prefs.setBool('isFirstTime', false);
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Principal(),
        '/calculator': (BuildContext context) => const Calculator(),
        '/new_trip_control': (BuildContext context) => const NewTripControl(),
        '/current_trip_control': (BuildContext context) =>
            const CurrentTripControl(),
        '/update_trip_singleton': (BuildContext context) =>
            const UpdateTripSingleton(),
        '/trip_data': (BuildContext context) => const TripData(),
        '/trip_list': (BuildContext context) => const TripList()
      },
    );
  }
}
