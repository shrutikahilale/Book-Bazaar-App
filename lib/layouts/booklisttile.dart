// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bookbazaar/models/personModel.dart';
import 'package:flutter/material.dart';

class BookListTile extends StatelessWidget {
  final String booktitle;
  final String price;
  final Person contact;

  const BookListTile(
      {super.key,
      required this.booktitle,
      required this.price,
      required this.contact});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Container(
        width: double.infinity,
         height: MediaQuery.of(context).size.height*0.3,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // img
              Stack(
                alignment: Alignment.topRight,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: Image(
                      image: AssetImage('assets/book.png'),
                      height: 150,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Adding to your wishlist..'),
                        ),
                      );
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.redAccent,
                      radius: 10,
                      child: Icon(
                        Icons.favorite,
                        size: 10,
                        color: Color.fromARGB(255, 245, 245, 245),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(width: 16),

              // info
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Expanded(
                          child: Row(
                            children: [
                              Text(
                                booktitle,
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        price,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 60),
                
                      // view details
                      GestureDetector(
                        onTap: () {
                          // send data of current book tapped
                          Navigator.pushNamed(context, '/viewbook', arguments: {
                            'title': 'Book title',
                            'price': '250.00',
                            'contact':
                                Person('Seller Name', '7472364794', 'Pune'),
                            'description': '',
                          });
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Text(
                            textAlign: TextAlign.center,
                            'View details',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
