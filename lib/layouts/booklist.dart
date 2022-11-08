import 'package:flutter/material.dart';
import 'package:bookbazaar/models/bookSellerModel.dart';
import 'package:bookbazaar/models/personModel.dart';
import 'booklisttile.dart';

class BookList extends StatefulWidget {
  @override
  State<BookList> createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  List<BookSeller> books = [
    BookSeller(
      'Chemistry X',
      400.0,
      Person('UserName1', '1234123488', 'Madhya Pradesh'),
    ),
    BookSeller(
      'History and Civics class 5',
      780.0,
      Person('UserName2', '6647823488', 'Punjab'),
    ),
    BookSeller(
      'Nusery Rhymes',
      460.0,
      Person('UserName3', '2346565676', 'Maharashtra'),
    ),
    BookSeller(
      'Story book for children',
      900.0,
      Person('UserName4', '9881998383', 'Asssam'),
    ),
    BookSeller(
      'Story book for children',
      900.0,
      Person('UserName4', '9881998383', 'Asssam'),
    ),
    BookSeller(
      'Story book for children',
      900.0,
      Person('UserName4', '9881998383', 'Asssam'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (context, index) {
        return Book(
          booktitle: books[index].booktitle,
          price: books[index].price.toString(),
          contact: books[index].contact,
        );
      },
    );
  }
}
