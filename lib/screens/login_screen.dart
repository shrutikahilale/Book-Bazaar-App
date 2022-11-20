import 'package:bookbazaar/consts/app_consts.dart';
import 'package:bookbazaar/screens/register_screen.dart';
import 'package:bookbazaar/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_button/sign_in_button.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  final key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();

  bool isNotVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Hi, Welcome Back!👋",
                  style: GoogleFonts.kanit(
                      fontSize: 25, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Hello again, you've been missed!",
                  style: GoogleFonts.kanit(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.grey.shade600),
                ),
                Form(
                  key: key,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 40,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null ||
                              value.isEmpty ||
                              !value.contains('@gmail.com')) {
                            return 'Please enter valid email';
                          }
                          return null;
                        },
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a valid password';
                          }

                          if (value.length < 6) {
                            return 'Password length should be min 6.';
                          }
                          return null;
                        },
                        controller: password,
                        obscureText: isNotVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          suffix: GestureDetector(
                            onTap: (() {
                              setState(() {
                                isNotVisible =
                                    isNotVisible == true ? false : true;
                              });
                            }),
                            child: Icon(
                              isNotVisible == true
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Consts.primary,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.92, 55),
                  ),
                  onPressed: () {
                    if (key.currentState!.validate()) {
                      AuthService().login(
                        email.text.trim(),
                        password.text.trim(),
                        context,
                      );
                    }
                  },
                  child: Text(
                    "Login",
                    style: GoogleFonts.kanit(
                      fontSize: 22,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Or Login With",
                      style: GoogleFonts.kanit(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Center(
                  child: SignInButton(
                    Buttons.googleDark,
                    onPressed: () {
                      AuthService().signInWithGoogle();
                    },
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.16,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account?",
                      style: GoogleFonts.kanit(fontSize: 18),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed('/register');
                      },
                      child: Text(
                        " Sign Up",
                        style: GoogleFonts.kanit(
                            fontSize: 18, color: Consts.primary),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
