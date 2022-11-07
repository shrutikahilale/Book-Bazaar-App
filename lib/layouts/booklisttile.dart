// ignore_for_file: prefer_const_constructors

import 'package:bookbazaar/models/personModel.dart';
import 'package:flutter/material.dart';

class Book extends StatelessWidget {
  final String booktitle;
  final String price;
  final Person contact;

  Book({
    required this.booktitle,
    required this.price,
    required this.contact,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, '/viewbook', arguments: {
          'booktitle': booktitle,
          'price': price,
          'contact': contact,
        });
      },
      leading: Image(
        height: 100.0,
        image: AssetImage(
          'assets/book.png',
        ),
      ),
      title: Text(
        booktitle,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
      ),
      subtitle: Text(
        price,
        style: TextStyle(
          fontSize: 12.0,
        ),
      ),
    );
    /*
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10.0,
        horizontal: 16.0,
      ),
      child: Row(
        children: [
          // Image of book
          Image(
            height: 80.0,
            image: AssetImage(
              'assets/book.png',
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title of book
                Text(
                  booktitle,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                  ),
                ),
                SizedBox(
                  height: 16.0,
                ),

                // Price of book
                Text(
                  price,
                  style: TextStyle(
                    fontSize: 12.0,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    */
  }
}
