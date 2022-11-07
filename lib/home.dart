import 'package:bookbazaar/layouts/booklist.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  final String title;
  const MyHomePage(this.title);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Wishlist',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Settings',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          backgroundColor: Colors.lightGreen,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 20.0, 20.0, 0.0),
          padding: const EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Color.fromARGB(255, 211, 241, 255),
          ),
          child: buildBookList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          selectedItemColor: Colors.lightGreen[600],
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget buildBookList(){
    return BookList();
  }

  // similarly buildWishList() to be implemented

}
