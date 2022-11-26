import 'package:bookbazaar/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:bookbazaar/models/book.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/personModel.dart';
import 'booklisttile.dart';

class BookList extends StatelessWidget {
  // List<Book> books = [];

  final ref = FirebaseFirestore.instance.collection('Books');

  // Future getBooks() async {
  //   return ref.get().then((QuerySnapshot<Map<String, dynamic>> snapshot) {
  //     for (QueryDocumentSnapshot<Map<String, dynamic>> doc in snapshot.docs) {
  //       Map<String, dynamic> mp = doc.data();
  //       print(mp);
  //       books.add(Book(
  //           title: mp['title'],
  //           price: mp['price'],
  //           seller: mp['seller'],
  //           location: mp['location'],
  //           images: mp['images'],
  //           isSold: mp['isSold'],
  //           buyer: mp['buyer'],
  //           description: mp['description'] ?? ""));
  //     }
  //   });
  //   print(books.length);
  // }

  BookList({super.key});

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
                      seller: snapshot.data!.docs[index]['seller'],
                      description: snapshot.data!.docs[index]['description'],);
                }),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
