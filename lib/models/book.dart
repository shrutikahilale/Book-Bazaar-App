// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'personModel.dart';

// class BookSeller {
//   final String booktitle;
//   final double price;
//   final Person contact;

//   BookSeller(this.booktitle, this.price, this.contact);
// }

class Book {
  String title;
  String price; // or double
  String description;
  String seller; // uid of the seller
  Map<String, double> location; // contains latitude and logitude
  List<String> images; // images of the book
  bool isSold = false; // either true or false
  String buyer; // uid of the buyer . empty by default
  Book({
    required this.title,
    required this.price,
    required this.description,
    required this.seller,
    required this.location,
    required this.images,
    required this.isSold,
    required this.buyer,
  });
}
