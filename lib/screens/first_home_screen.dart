import 'package:bookbazaar/layouts/home.dart';
import 'package:bookbazaar/layouts/profile.dart';
import 'package:bookbazaar/services/auth_service.dart';
import 'package:flutter/material.dart';
import '../layouts/wishlist.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen();

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  int selectedIdx = 0;

  List<BottomNavigationBarItem> items = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: 'Home',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.favorite),
      label: 'Wishlist',
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: 'Settings',
    ),
  ];

  onTapChangeScreen(int index) {
    setState(() {
      selectedIdx = index;
    });
  }

  List<Widget> screens = [
    HomePage(),
    WishList(),
    ProfileSettings(),
  ];

  List<String> titles = ['Book Bazaar', 'Wishlist', 'Profile settings'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(titles[selectedIdx]),
          backgroundColor: Colors.deepPurple,
          actions: [
            GestureDetector(
                onTap: () {
                  AuthService().signOut();
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.logout),
                ))
          ],
        ),
        body: screens[selectedIdx],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIdx,
          items: items,
          selectedItemColor: Colors.black,
          selectedLabelStyle: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
          onTap: onTapChangeScreen,
        ),
      ),
    );
  }
}
