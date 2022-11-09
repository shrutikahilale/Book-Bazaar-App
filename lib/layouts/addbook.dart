import 'package:flutter/material.dart';

class AddBook extends StatefulWidget {
  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  // texteditingcontrollers for textfields
  final titletec = TextEditingController();
  final pricetec = TextEditingController();
  final sellernametec = TextEditingController();
  final contacttec = TextEditingController();
  final locationtec = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Add a book'),
          backgroundColor: Colors.deepPurple,
        ),
        backgroundColor: Colors.grey[200],
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 217, 252),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    'Book description',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: titletec,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Name of the book',
                        hintStyle: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: pricetec,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Price of the book',
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 217, 252),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(6.0),
                  child: Text(
                    'Seller Details',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: sellernametec,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Name of the seller',
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: contacttec,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Contact number',
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: locationtec,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Location',
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 217, 252),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(4.0),
                      child: Text(
                        'Add a photo',
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.add_a_photo,
                        color: Colors.grey[850],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),

              // Button to add the book
              ElevatedButton(
                onPressed: () {
                  // grab the data from TECs
                  String title = titletec.text;
                  String price = pricetec.text;
                  String sellername = sellernametec.text;
                  String contact = contacttec.text;
                  String location = locationtec.text;

                  // send this data to database and it will render it on home page as well
                  if (title.isNotEmpty &&
                      price.isNotEmpty &&
                      sellername.isNotEmpty &&
                      contact.isNotEmpty) {
                    Navigator.pop(context, {
                      'title': title,
                      'price': price,
                      'sellername': sellername,
                      'contact': contact,
                      'location': location,
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurple),
                ),
                child: const Text(
                  'Sell this book',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ));
  }
}
