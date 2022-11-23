import 'package:bookbazaar/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../models/personModel.dart';
import 'booklisttile.dart';

class BookList extends StatelessWidget {
  // List<BookListTile> books = [
  //   BookListTile(
  //     booktitle: 'Data structures',
  //     price: '240',
  //     contact: Person('Seller', '1221221222', 'Pune'),
  //   ),
  //   BookListTile(
  //     booktitle: 'Data structures',
  //     price: '240',
  //     contact: Person('Seller', '1221221222', 'Pune'),
  //   )
  // ];

  List<BookListTile> books = [];

  final ref = FirebaseFirestore.instance.collection('Books');

  Future getBooks() async {
    await ref.get().then((snapshot) {
      for (var doc in snapshot.docs) {
        Map mp = doc.data();
        books.add(BookListTile(
            booktitle: mp['title'],
            price: mp['price'],
            contact: Person(mp['seller'], "9009001101", 'pune')));
      }
    });
  }

  BookList({super.key});

  @override
  Widget build(BuildContext context) {
    // return GridView.builder(
    //   itemCount: books.length,
    //   itemBuilder: (context, index) {
    //     return Book(
    //       booktitle: books[index].booktitle,
    //       price: books[index].price.toString(),
    //       contact: books[index].contact,
    //     );
    //   },
    //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     mainAxisSpacing: 2,
    //     mainAxisExtent: 240,
    //   ),
    // );
    return FutureBuilder(
        future: getBooks(),
        builder: (context, snapshot) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: books.length,
            itemBuilder: ((context, index) {
              return BookListTile(
                booktitle: books[index].booktitle,
                price: books[index].price.toString(),
                contact: books[index].contact,
              );
            }),
          );
        });
  }
}
