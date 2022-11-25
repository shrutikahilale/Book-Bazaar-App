import 'package:bookbazaar/layouts/booklist.dart';
import 'package:bookbazaar/layouts/books_for_u.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
                child: Text(
                  "Explore",
                  style: GoogleFonts.rubik(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              // book list layout
              BookList(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18.0,
                  vertical: 10,
                ),
                child: Text(
                  "Books For You",
                  style: GoogleFonts.rubik(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
              ),
              BooksForYou()
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
