import 'package:bookbazaar/layouts/booklisttile.dart';
import 'package:bookbazaar/models/personModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BooksForYou extends StatelessWidget {
  List<BookListTile> books = [];

  final ref = FirebaseFirestore.instance.collection('Books');

  // Future getBooks() async {
  //   await ref.get().then((snapshot) {
  //     for (var doc in snapshot.docs) {
  //       Map mp = doc.data();
  //       books.add(BookListTile(
  //         booktitle: mp['title'],
  //         price: mp['price'],
  //         contact: Person(mp['seller'], "9009001101", 'pune'),
  //       ));
  //     }
  //   });
  // }

  BooksForYou({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: FutureBuilder(
          future: ref.get(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return BookListTile(
                      title: snapshot.data!.docs[index]['title'],
                      price: snapshot.data!.docs[index]['price'],
                      url: snapshot.data!.docs[index]['images'][0],
                      description: snapshot.data!.docs[index]['description'],
                      seller: snapshot.data!.docs[index]['seller'],
                      bid: snapshot.data!.docs[index].id);
                }),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
