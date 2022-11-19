import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 300,
            decoration: BoxDecoration(
                color: Color(0xFF673AB7),
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(60))),
          ),
          Text(
            "Book Baazar",
            style: GoogleFonts.rubik(fontSize: 40),
          )
        ],
      ),
    );
  }
}
