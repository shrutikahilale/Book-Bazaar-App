// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:bookbazaar/models/personModel.dart';
import 'package:bookbazaar/services/database_service.dart';

class BookLayout extends StatefulWidget {
  String title;
  String price;
  String seller;
  String description;
  List<dynamic> images;

  BookLayout({
    Key? key,
    required this.title,
    required this.price,
    required this.seller,
    required this.description,
    required this.images,
  }) : super(key: key);

  @override
  State<BookLayout> createState() => _BookLayoutState();
}

class _BookLayoutState extends State<BookLayout> {
  late String name;
  late String email;
  late String phone;
  bool isLoaded = false;

  getUser() async {
    final user = await DatabaseService()
        .ref
        .collection('Users')
        .doc(widget.seller)
        .get();
    name = user['name'];
    email = user['email'];
    phone = user['phone'];
    isLoaded = true;
    setState(() {});
    //photoURL = user['photoURL'];
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          overflow: TextOverflow.ellipsis,
        ),
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.grey[200],
      body: !isLoaded
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 60),

                  // book image
                  SizedBox(
                    height: 300,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.images.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.only(
                                left: 30,
                                right:
                                    index == widget.images.length - 1 ? 20 : 0),
                            child: Image(
                              image: NetworkImage(
                                widget.images[index],
                              ),
                              height: 300,
                              width: 200,
                              fit: BoxFit.fill,
                            ),
                          );
                        }),
                  ),
                  const SizedBox(height: 40),

                  // name, description, Seller details, price

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(40),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.title,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(widget.description.isEmpty
                              ? "-No description Given-"
                              : widget.description),
                          SizedBox(
                            height: 20,
                          ),
                          SizedBox(
                            height: 1,
                            child: Container(
                                decoration: BoxDecoration(color: Colors.black)),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text(name),
                          SizedBox(
                            height: 10,
                          ),
                          Text(email),
                          SizedBox(
                            height: 10,
                          ),
                          Text(phone),
                          SizedBox(
                            height: 50,
                          ),
                          Text(
                            'Rs. ${widget.price}',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
