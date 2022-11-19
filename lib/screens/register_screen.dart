import 'package:bookbazaar/consts/app_consts.dart';
import 'package:bookbazaar/screens/login_screen.dart';
import 'package:bookbazaar/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final key = GlobalKey<FormState>();

  TextEditingController email = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Create account",
              style:
                  GoogleFonts.kanit(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            Text(
              "Connect with the bookmates today!",
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
                      controller: name,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a name';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Name',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: phone,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid contact no.';
                        }

                        if (value.length != 10) {
                          return 'Please enter a valid contact no.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Contact No.',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: email,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            !value.contains('@gmail.com')) {
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                          labelText: 'Email Address',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: password,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter a valid password';
                        }

                        if (value.length < 6) {
                          return 'Password length should be min 6.';
                        }
                        return null;
                      },
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12))),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Consts.primary,
                    fixedSize:
                        Size(MediaQuery.of(context).size.width * 0.92, 55)),
                onPressed: () async {
                  if (key.currentState!.validate()) {
                    await AuthService().register(
                        name.text.trim(),
                        phone.text.trim(),
                        email.text.trim(),
                        password.text.trim(),
                        context);
                  }
                },
                child: Text(
                  "Sign Up",
                  style: GoogleFonts.kanit(
                    fontSize: 22,
                    fontWeight: FontWeight.w400,
                  ),
                )),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Or Sign Up With",
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
                onPressed: () async {
                  if (await AuthService().signInWithGoogle()) {
                    Navigator.of(context).pop();
                  }
                },
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: GoogleFonts.kanit(fontSize: 18),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          " Login",
                          style: GoogleFonts.kanit(
                              fontSize: 18, color: Consts.primary),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
