import 'dart:io';

import 'package:flutter/material.dart';
import 'package:trip_control_app/frames/calculator.dart';
import 'package:trip_control_app/frames/principal.dart';
import 'package:trip_control_app/frames/trip_control.dart';
import 'package:trip_control_app/frames/trip_data.dart';
import 'package:trip_control_app/frames/trip_list.dart';
import 'package:trip_control_app/models/trip_model.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  runApp(const MainApp());

  if (Platform.isLinux) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const Principal(),
        '/calculator': (BuildContext context) => const Calculator(),
        '/trip_control': (BuildContext context) => const TripControl(TripModel),
        '/trip_data': (BuildContext context) => const TripData(),
        'trip_list': (BuildContext context) => const TripList()
      },
    );
  }
}
