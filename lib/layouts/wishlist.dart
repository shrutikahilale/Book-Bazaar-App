import 'package:flutter/material.dart';

class WishList extends StatelessWidget {
  List<String> wishlist = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: wishlist.isEmpty
              ? Text('No books is your wishlist')
              : ListView.builder(itemBuilder: ((context, index) {
                  return Text('Book title');
                })),
        ),
      ),
    );
  }
}
