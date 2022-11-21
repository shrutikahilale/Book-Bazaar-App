import 'package:bookbazaar/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBook extends StatefulWidget {
  @override
  State<AddBook> createState() => _AddBookState();
}

class _AddBookState extends State<AddBook> {
  // texteditingcontrollers for textfields
  final titletec =
      TextEditingController(text: "Sherlock Holmes"); // for testing purposes
  final pricetec = TextEditingController(text: "399.0");
  final descriptiontec = TextEditingController();

  bool imagesSelected = false;
  List<XFile> imgs = [];

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
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Price of the book',
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
                      controller: descriptiontec,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Description (optional)',
                          hintStyle: TextStyle(fontSize: 14)),
                    ),
                  ),
                ),
              ),

              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 230, 217, 252),
                ),
                child: (imagesSelected && imgs.isNotEmpty)
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              imagesSelected = false;
                              imgs.clear();
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.grey[850],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              "${imgs.length} images selected",
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
                            ),
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              imgs = await picker.pickMultiImage();
                              imagesSelected = true;
                              setState(() {});
                              print(imgs.length);
                            },
                            icon: Icon(
                              Icons.add_a_photo,
                              color: Colors.grey[850],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.all(4.0),
                            child: Text(
                              'Upload Images',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.deepPurple,
                              ),
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
                onPressed: () async {
                  // grab the data from TECs
                  String title = titletec.text;
                  String price = pricetec.text;
                  String? description = descriptiontec.text;

                  //send this data to database and it will render it on home page as well
                  if (title.isNotEmpty && price.isNotEmpty && imagesSelected) {
                    const SnackBar(
                      duration: Duration(
                        milliseconds: 1000,
                      ),
                      content: Text('Adding to our database...'),
                      backgroundColor: Colors.black,
                    );

                    bool res = await DatabaseService()
                        .uploadBook(imgs, title, price, description);

                    if (res) {
                      Navigator.pop(
                        context,
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          duration: Duration(
                            milliseconds: 1000,
                          ),
                          content: Text('Please enable location!'),
                          backgroundColor: Colors.black,
                        ),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        duration: Duration(
                          milliseconds: 1000,
                        ),
                        content: Text('Please enter all fields!'),
                        backgroundColor: Colors.black,
                      ),
                    );
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
