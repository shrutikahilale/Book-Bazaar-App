import 'dart:developer';

import 'package:bookbazaar/layouts/booklisttile.dart';
import 'package:bookbazaar/models/book.dart';
import 'package:bookbazaar/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  TextEditingController controller = TextEditingController();

  late Future resultsLoaded;
  List<QueryDocumentSnapshot<Map<String, dynamic>>> _allBooks = [];
  List<Map<String, dynamic>> _booksList = [];

  @override
  void initState() {
    controller.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    resultsLoaded = getAllBooks();
  }

  void _onSearchChanged() {
    log(controller.text);
    searchBooks();
  }

  void searchBooks() {
    List<Map<String, dynamic>> showResults = [];
    print(_allBooks.length);
    if (controller.text.isNotEmpty) {
      for (QueryDocumentSnapshot<Map<String, dynamic>> doc in _allBooks) {
        if (doc
            .data()['title']
            .toString()
            .toLowerCase()
            .contains(controller.text.toLowerCase())) {
          showResults.add(doc.data());
        }
      }
    }
    setState(() {
      _booksList = showResults;
    });
  }

  getAllBooks() async {
    final QuerySnapshot<Map<String, dynamic>> data =
        await DatabaseService().ref.collection("Books").get();

    setState(() {
      _allBooks = data.docs;
    });
    searchBooks();
    return "complete";
  }

  @override
  void dispose() {
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Search Books',
          style: GoogleFonts.rubik(fontSize: 20, color: Colors.white),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 20.0, right: 20.0, top: 20, bottom: 20),
            child: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                isDense: true,
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple)),
                hintText: 'Search here...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ),
          Expanded(
            child: _booksList.isEmpty
                ? const Center(
                    child: Text(
                      "No search Found",
                      style: TextStyle(fontSize: 25),
                    ),
                  )
                : GridView.builder(
                    shrinkWrap: true,
                    itemCount: _booksList.length,
                    itemBuilder: (BuildContext context, int index) =>
                        GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: BookListTile(
                                  title: _booksList[index]['title'],
                                  price: _booksList[index]['price'],
                                  url: _booksList[index]['images'][0]),
                            )),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
