// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProfileSettings extends StatefulWidget {
  ProfileSettings({super.key});

  @override
  State<ProfileSettings> createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  List<bool> isSold = List.generate(4, (index) => false);
  List<String> sellingBooksList = [];
  String name = '';

  // get current user uid
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // get user name
  Future getUserDetails() async {
    final user =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    name = user['name'];
    print(name);
  }

  _removeBook(int index) {
    setState(() {
      isSold[index] = isSold[index] ? false : true;

      if (isSold[index] == true) {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Are you sure you want to remove the book from list?',
                ),
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                      ),
                      onPressed: null,
                      child: Text(
                        'Yes',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.red),
                      ),
                      onPressed: null,
                      child: Text(
                        'No',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              );
            });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future: getUserDetails(),
          builder: (context, snapshot) {
            return Column(
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
                    Padding(
                      padding: EdgeInsets.only(top: 16),
                      child: Text(
                        overflow: TextOverflow.fade,
                        name,
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 80,
                    ),
                    // GestureDetector(
                    //   child: Icon(Icons.settings),

                    //   // TODO: implemeent onTap to open settings menu
                    // ),
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
                  child: sellingBooksList.isEmpty
                      ? Text('No books sold by you')
                      : ListView.builder(
                          itemCount: sellingBooksList.length,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Book $index'),
                                    GestureDetector(
                                      onTap: () => _removeBook(index),
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
            );
          },
        ),
      ),
    );
  }
}
