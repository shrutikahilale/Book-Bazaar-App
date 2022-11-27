// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:bookbazaar/layouts/sellinglist.dart';
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
  // List<String> sellingBooksList = [];
  String name = '';
  String email = '';
  String phone = '';
  String photoURL = '';

  // get current user uid
  final uid = FirebaseAuth.instance.currentUser!.uid;

  // get user name
  Future getUserDetails() async {
    final user =
        await FirebaseFirestore.instance.collection('Users').doc(uid).get();
    name = user['name'];
    email = user['email'];
    phone = user['phone'];
    photoURL = user['photoURL'];
    print(name);
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
                  height: 10,
                ),
                // profile photo
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: CircleAvatar(
                        radius: 40,
                        child: photoURL.isNotEmpty
                            ? Image.network(
                                photoURL,
                                fit: BoxFit.cover,
                                height: 200,
                              )
                            : Image(
                                color: Colors.white,
                                image: AssetImage('assets/profile.png'),
                                fit: BoxFit.cover,
                                height: 200,
                              ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            overflow: TextOverflow.fade,
                            email,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 12),
                          child: Text(
                            overflow: TextOverflow.fade,
                            phone,
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
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

                SellingList(),

                /*
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

                */
              ],
            );
          },
        ),
      ),
    );
  }
}
