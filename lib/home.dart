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
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Wishlist',
    ),
    const BottomNavigationBarItem(
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
          backgroundColor: Colors.deepPurple,
        ),
        body: Container(
          margin: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          padding: const EdgeInsets.fromLTRB(0, 10.0, 10.0, 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[200],
          ),
          child: buildBookList(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateAndDisplaySelection(context),
          backgroundColor: Colors.grey[800],
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: items,
          selectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    final result = await Navigator.pushNamed(context, '/addbook') as Map;

    // basically add in the database
    setState(() {
      BookList().addBook(
        result['title'],
        double.parse(result['price']),
        result['sellername'],
        result['location'],
        result['contact'],
      );
    });

    print(result);
  }

  Widget buildBookList() {
    return BookList();
  }

  // similarly buildWishList() to be implemented

}
