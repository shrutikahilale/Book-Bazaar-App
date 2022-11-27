import 'package:bookbazaar/layouts/booklisttile.dart';
import 'package:bookbazaar/models/personModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:shimmer/shimmer.dart';

class BooksForYou extends StatefulWidget {
  BooksForYou({super.key});

  @override
  State<BooksForYou> createState() => _BooksForYouState();
}

class _BooksForYouState extends State<BooksForYou> {
  List<Map<String, dynamic>> books = [];

  bool isLoaded = false;

  final ref = FirebaseFirestore.instance.collection('Books');

  void getBooks() async {
    final QuerySnapshot<Map<String, dynamic>> docs = await ref.get();
    const Distance distance = Distance();
    final location = Location();
    var _location = await location.getLocation();

    for (QueryDocumentSnapshot<Map<String, dynamic>> map in docs.docs) {
      final double km = distance.as(
          LengthUnit.Kilometer,
          LatLng(map.data()['location']['latitude'],
              map.data()['location']['longitude']),
          LatLng(_location.latitude!, _location.longitude!));

      if (km <= 5) {
        books.add(map.data());
      }
    }

    setState(() {
      isLoaded = true;
    });
  }

  @override
  void initState() {
    getBooks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoaded
        ? SizedBox(
            height: 300,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              shrinkWrap: true,
              itemCount: books.length,
              itemBuilder: ((context, index) {
                return BookListTile(
                    title: books[index]['title'],
                    price: books[index]['price'],
                    url: books[index]['images'][0],
                    description: books[index]['description'],
                    seller: books[index]['seller']);
              }),
            ))
        : SizedBox(
            height: 300,
            child: Shimmer.fromColors(
              baseColor: Colors.grey[300]!,
              highlightColor: Colors.grey[100]!,
              enabled: !isLoaded,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  itemCount: 3,
                  itemBuilder: (context, snapshot) {
                    return BookListTile(
                        title: "",
                        price: "",
                        url: "",
                        description: "",
                        seller: "");
                  }),
            ));
  }
}
