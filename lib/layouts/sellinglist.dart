import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class SellingList extends StatefulWidget {
  const SellingList({super.key});

  @override
  State<SellingList> createState() => _SellingListState();
}

class _SellingListState extends State<SellingList> {
  final colRef = FirebaseFirestore.instance
      .collection('Users')
      .doc(FirebaseAuth.instance.currentUser!.uid)
      .collection('sellingBooksList');

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
                              image: AssetImage('assets/book.png'),
                              fit: BoxFit.fill,
                            )
                            /*
                              image: NetworkImage(
                                  // image url issue
                                  snapshot.data!.docs[index]['images'][0]),
                              fit: BoxFit.fill),*/
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
                            // remove from wishlist and book database
                            // for sellingList : snapshot.data!.docs[index]['bid']
                            // for books: bid
                            setState(() {
                              colRef
                                  .doc(snapshot.data!.docs[index].id)
                                  .delete();

                              int len = snapshot.data!.docs[index]['bid']
                                  .toString()
                                  .length;
                              String bookid = (snapshot.data!.docs[index]
                                      ['bid'])
                                  .toString()
                                  .substring(46, len - 1);

                              FirebaseFirestore.instance
                                  .collection('Books')
                                  .doc(bookid)
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
          return const Center(child: CircularProgressIndicator());
        });
  }
}
