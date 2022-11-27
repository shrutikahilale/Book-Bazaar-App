// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bookbazaar/layouts/viewbook.dart';
import 'package:bookbazaar/models/personModel.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookListTile extends StatelessWidget {
  final String title;
  final String price;
  final String url; // image
  final String description;
  final String seller; // uid of the seller
  // final Map<String, double> location; // contains latitude and logitude
  // final List<String> images; // images of the book

  const BookListTile(
      {super.key,
      required this.title,
      required this.price,
      required this.url,
      required this.seller,
      required this.description});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: ((context) {
          return BookLayout(
              title: title,
              price: price,
              url: url,
              seller: seller,
              description: description);
        })));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: <Widget>[
            Container(
              height: (200),
              width: (150),
              decoration: BoxDecoration(
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(2, 5))
                  ],
                  borderRadius: BorderRadius.circular(10),
                  image: url.isNotEmpty
                      ? DecorationImage(
                          image: NetworkImage(url), fit: BoxFit.fill)
                      : null),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: const EdgeInsets.all(5),
                  width: (150),
                  child: Text(
                    title,
                    softWrap: true,
                    textWidthBasis: TextWidthBasis.parent,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    "₹ $price",
                    textAlign: TextAlign.left,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                    ),
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
