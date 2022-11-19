import 'package:bookbazaar/screens/first_home_screen.dart';
import 'package:bookbazaar/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class Middleware extends StatelessWidget {
  const Middleware({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        debugPrint(snapshot.data?.uid.toString());
        if (snapshot.hasData) {
          return FirstScreen();
        }
        return LoginScreen();
      },
    );
  }
}
