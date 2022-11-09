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
        title: Text(booktitle, overflow: TextOverflow.ellipsis),
        backgroundColor: Colors.deepPurple,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 20,
            horizontal: 24,
          ),
          margin: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.person),
                  const SizedBox(width: 10),
                  // Name of the owner
                  Text(
                    contact.sellerName,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // book image
              const Image(
                image: AssetImage(
                  'assets/book.png',
                ),
                height: 150,
              ),
              const SizedBox(height: 10),

              Row(
                children: [
                  const Text(
                    ' Rs. ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  // price
                  Text(
                    price,
                    style: const TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(Icons.location_pin),
                  const SizedBox(width: 10),
                  // location
                  Text(
                    contact.location,
                    style: const TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              Row(
                children: [
                  const Icon(Icons.phone),
                  const SizedBox(width: 10),
                  // contact details
                  Text(
                    contact.contactNumber,
                    style: const TextStyle(
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
