import 'package:bookbazaar/first_home_screen.dart';
import 'package:bookbazaar/layouts/profile.dart';
import 'package:bookbazaar/layouts/viewbook.dart';
import 'package:flutter/material.dart';

import 'layouts/home.dart';
import 'layouts/addbook.dart';

void main() {
  runApp(const MyApp());
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
      home: FirstScreen(),
      routes: {
        '/viewbook':(context) => BookLayout(),
        '/addbook':(context)=> AddBook(),
      },
    );
  }
}


