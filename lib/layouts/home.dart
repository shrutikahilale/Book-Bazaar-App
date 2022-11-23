import 'package:bookbazaar/layouts/booklist.dart';
import 'package:flutter/material.dart';

import '../models/personModel.dart';
import 'booklisttile.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // search bar
              Container(
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Icon(Icons.search),
                      SizedBox(width: 20),
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Color.fromARGB(123, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(
                height: 25,
              ),

              // book list layout
              BookList(),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateAndDisplaySelection(context),
        backgroundColor: Colors.grey[800],
        child: const Icon(Icons.add),
      ),
    );
  }

  void _navigateAndDisplaySelection(BuildContext context) async {
    Navigator.pushNamed(context, '/addbook');
  }
}
