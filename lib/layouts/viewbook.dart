// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:bookbazaar/models/personModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookLayout extends StatelessWidget {
  String title;
  String price;
  String url;
  String seller;
  String description;
  String sellerName = '';
  String sellerPhone = '';

  BookLayout(
      {required this.title,
      required this.price,
      required this.url,
      required this.seller,
      required this.description});

  Future getSellerDetails() async {
    print(seller);
    final user =
        await FirebaseFirestore.instance.collection('Users').doc(seller).get();
    sellerName = user['name'];
    sellerPhone = user['phone'];

    print(sellerName);
    print(sellerPhone);
  }

  @override
  Widget build(BuildContext context) {
    // mp = ModalRoute.of(context)!.settings.arguments as Map;
    // title = mp['title'];
    // price = mp['price'];
    // url = mp['url'];
    // seller = mp['seller'];
    // description = mp['description'] == ''
    //     ? 'No description provided by the seller'
    //     : mp['description'];

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.grey[200],
        body: FutureBuilder(
          future: getSellerDetails(),
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // book image
                  Container(
                    height: (400),
                    width: (300),
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10,
                            offset: Offset(2, 5))
                      ],
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(url), fit: BoxFit.fill),
                    ),
                  ),
                  const SizedBox(height: 40),

                  // details

                  Container(
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey,
                            blurRadius: 30,
                            offset: Offset(2, 5))
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(40),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // title
                            Text(
                              title,
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 38, 9, 89),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            // description

                            Text(
                              description.isEmpty
                                  ? 'No description provided by seller'
                                  : description,
                              style: GoogleFonts.poppins(
                                color: Color.fromARGB(255, 38, 9, 89),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            SizedBox(
                              height: 2,
                              child: Container(
                                  decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 38, 9, 89))),
                            ),
                            SizedBox(
                              height: 20,
                            ),

                            // seller info
                            Text(
                              sellerName,
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                color: Color.fromARGB(255, 38, 9, 89),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              sellerPhone,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Color.fromARGB(255, 38, 9, 89),
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),

                            Text(
                              '₹ $price',
                              style: GoogleFonts.poppins(
                                fontSize: 28,
                                fontWeight: FontWeight.w800,
                                color: Color.fromARGB(255, 38, 9, 89),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }
}
