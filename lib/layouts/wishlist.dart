// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'booklisttile.dart';

class WishList extends StatefulWidget {
  @override
  State<WishList> createState() => _WishListState();
}

class _WishListState extends State<WishList> {
  // List<String> wishlist = [];
  final colRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('wishlist');

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: FutureBuilder(
          future: colRef.get(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: ((context, index) {
                  return Container(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // book image
                      children: [
                        Container(
                          height: (120), // 120
                          width: (90), // 90
                          decoration: BoxDecoration(
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: Colors.grey,
                                  blurRadius: 10,
                                  offset: Offset(2, 5))
                            ],
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage(
                                snapshot.data!.docs[index]['url'],
                              ),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),

                        SizedBox(width: 20),

                        // info (column)

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(5),
                              width: (200),
                              child: Text(
                                snapshot.data!.docs[index]['title'],
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
                                "₹ ${snapshot.data!.docs[index]['price']}",
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

                        // delete button
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0),
                          child: GestureDetector(
                            onTap: () {
                              // remove from wishlist
                              // for wishlist: snapshot.data!.docs[index].id
                              setState(() {
                                colRef
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              });
                            },
                            child: Icon(Icons.delete),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}
