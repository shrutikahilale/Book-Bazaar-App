import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  Future<bool> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    final userCred =
        await FirebaseAuth.instance.signInWithCredential(credential);

    if (userCred.additionalUserInfo!.isNewUser) {
      await createUserProfile(
          userCred.user!.displayName ?? "",
          userCred.user!.email ?? "",
          userCred.user!.phoneNumber ?? "",
          userCred.user!.uid,
          userCred.user!.photoURL ?? "");
    }

    return true;
  }

  void login(String emailAddress, String password, BuildContext context) async {
    try {
      final credential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: emailAddress, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('No user found for that email.')));
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Wrong password provided for that user.')));
      } else {
        debugPrint(e.toString());
      }
    }
  }

  Future<void> register(String name, String phone, String emailAddress,
      String password, BuildContext context) async {
    try {
      debugPrint('registering started...');
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );

      await createUserProfile(name, emailAddress, phone, credential.user!.uid,
          credential.user!.photoURL ?? "");

      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('weak password');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The password provided is too weak.')));
      } else if (e.code == 'email-already-in-use') {
        debugPrint('already in use');
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('The account already exists for that email.')));
      } else {
        debugPrint(e.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  Future<void> createUserProfile(String name, String email, String phone,
      String uid, String photoUrl) async {
    await FirebaseFirestore.instance.collection("Users").doc(uid).set({
      "name": name,
      "phone": phone,
      "email": email,
      "uid": uid,
      "photoURL": photoUrl
    });
  }
}
