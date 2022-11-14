// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  // bool isSold = false;

  List<bool> isSold = List.generate(5, (index) => false);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 40,
            ),
            // profile photo
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    radius: 40,
                    child: Image(
                      image: AssetImage('assets/profile-pic.jpg'),
                      fit: BoxFit.fill,
                      height: 200,
                    ),
                  ),
                ),
                SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // name of user
                    Text(
                      overflow: TextOverflow.fade,
                      'Shrutika Hilale',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6),
                    // details like location / contact number
                    Text(
                      'Location',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 80,
                ),
                GestureDetector(
                  child: Icon(Icons.settings),

                  // TODO: implemeent onTap to open settings menu
                ),
              ],
            ),
            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Container(
                height: 2,
                decoration: BoxDecoration(color: Colors.grey[800]),
              ),
            ),
            SizedBox(height: 20),

            // books sold and listed to be sold
            Container(
              padding: EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'Your selling list',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),

            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: ((context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 15,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[400],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 15,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Book $index'),
                          GestureDetector(
                            onTap: (() {
                              setState(() {
                                isSold[index] = isSold[index] ? false : true;

                                // TODO: Open dialog box to ask user if he wants to remove the book from the list as it is no longer needed when isSold becomes true
                              });
                            }),
                            child: isSold[index]
                                ? Icon(Icons.check_box)
                                : Icon(Icons.check_box_outline_blank),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
