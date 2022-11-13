// ignore_for_file: prefer_const_constructors

import 'package:bookbazaar/models/personModel.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final String booktitle;
  final String price;
  final Person contact;

  const Book(
      {super.key,
      required this.booktitle,
      required this.price,
      required this.contact});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/viewbook', arguments: {
          'booktitle': booktitle,
          'price': price,
          'contact': contact,
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
          ),
          padding: EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image(
                  height: 100.0,
                  image: AssetImage(
                    'assets/book.png',
                  ),
                ),
                SizedBox(height: 16),
                Text(booktitle),
                SizedBox(height: 5),
                Text(
                  'Rs. $price',
                  style: TextStyle(
                    fontSize:12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
