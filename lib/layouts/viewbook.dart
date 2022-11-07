import 'package:bookbazaar/models/personModel.dart';
import 'package:flutter/material.dart';

class BookLayout extends StatelessWidget {
  Map mp = {};
  late String booktitle;
  late String price;
  late Person contact;

  @override
  Widget build(BuildContext context) {
    mp = ModalRoute.of(context)!.settings.arguments as Map;
    booktitle = mp['booktitle'];
    price = mp['price'];
    contact = mp['contact'];

    return Scaffold(
      appBar: AppBar(
        title: Text(booktitle),
        backgroundColor: Colors.lightGreen,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.person),
                  SizedBox(width: 10),
                  // Name of the owner
                  Text(
                    contact.sellerName,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // book image
              Image(
                image: AssetImage(
                  'assets/book.png',
                ),
                height: 150,
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  const Text(
                    ' Rs. ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  // price
                  Text(
                    price,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Icon(Icons.location_pin),
                  SizedBox(width: 10),
                  // location
                  Text(
                    contact.location,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Row(
                children: [
                  Icon(Icons.phone),
                  SizedBox(width: 10),
                  // contact details
                  Text(
                    contact.contactNumber,
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
