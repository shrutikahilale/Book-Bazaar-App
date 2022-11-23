import 'package:bookbazaar/models/personModel.dart';
import 'package:flutter/material.dart';

class BookLayout extends StatelessWidget {
  Map mp = {};
  late String title;
  late String price;
  late Person contact;
  late String description;

  @override
  Widget build(BuildContext context) {
    mp = ModalRoute.of(context)!.settings.arguments as Map;
    title = mp['title'];
    price = mp['price'];
    contact = mp['contact'];
    description =
        mp['description'] == '' ? 'no description given' : mp['description'];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
      ),
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 60),

            // book image
            const Image(
              image: AssetImage(
                'assets/book.png',
              ),
              height: 300,
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
                      title,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(description),
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
                    Text(contact.sellerName),
                    SizedBox(
                      height: 10,
                    ),
                    Text(contact.location),
                    SizedBox(
                      height: 10,
                    ),
                    Text(contact.contactNumber),
                    SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Rs. $price',
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
