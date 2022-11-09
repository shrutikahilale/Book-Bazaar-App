import 'package:bookbazaar/layouts/viewbook.dart';
import 'package:flutter/material.dart';

import 'home.dart';
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
      home: const MyHomePage('Book Bazaar'),
      routes: {
        '/viewbook':(context) => BookLayout(),
        '/addbook':(context)=> AddBook(),
      },
    );
  }
}


