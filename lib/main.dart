import 'package:bookbazaar/screens/first_home_screen.dart';
import 'package:bookbazaar/layouts/profile.dart';
import 'package:bookbazaar/layouts/viewbook.dart';
import 'package:bookbazaar/screens/intro_screen.dart';
import 'package:bookbazaar/screens/login_screen.dart';
import 'package:bookbazaar/screens/middleware.dart';
import 'package:bookbazaar/screens/register_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

import 'layouts/home.dart';
import 'layouts/addbook.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await checkLocationPermission();
  runApp(const MyApp());
}

Future<void> checkLocationPermission() async {
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  _serviceEnabled = await location.serviceEnabled();
  if (!_serviceEnabled) {
    _serviceEnabled = await location.requestService();
    if (!_serviceEnabled) {
      return;
    }
  }

  _permissionGranted = await location.hasPermission();
  if (_permissionGranted == PermissionStatus.denied) {
    _permissionGranted = await location.requestPermission();
    if (_permissionGranted != PermissionStatus.granted) {
      return;
    }
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Middleware(),
      routes: {
        '/viewbook': (context) => BookLayout(
              title:
                  (ModalRoute.of(context)?.settings.arguments as Map)['title'],
              description: (ModalRoute.of(context)?.settings.arguments
                  as Map)['description'],
              images:
                  (ModalRoute.of(context)?.settings.arguments as Map)['images'],
              price:
                  (ModalRoute.of(context)?.settings.arguments as Map)['price'],
              seller:
                  (ModalRoute.of(context)?.settings.arguments as Map)['seller'],
            ),
        '/addbook': (context) => AddBook(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
      },
    );
  }
}
