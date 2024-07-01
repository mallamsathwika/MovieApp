import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_project/screens/reset_screen.dart';
import 'package:tmdb_project/screens/signup_screen.dart';
import 'package:tmdb_project/widgets/mybutton.dart';
import 'package:tmdb_project/widgets/mytextfield.dart';
import 'package:tmdb_project/wrapper.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passwordcontroller = TextEditingController();

  signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailcontroller.text, password: _passwordcontroller.text);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.grey, Colors.black],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  "img/movieicon.png",
                  width: w,
                  height: h * 0.35,
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Welcome",
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                ),
                const Text(
                  "Sign-in to the app",
                  style: TextStyle(fontSize: 20, color: Colors.white54),
                ),
                const SizedBox(
                  height: 30,
                ),
                mytextfield("Enter e-mail address", Icons.mail_outline, false,
                    _emailcontroller),
                const SizedBox(
                  height: 5,
                ),
                mytextfield("Enter Password", Icons.lock_outline, true,
                    _passwordcontroller),
                const SizedBox(
                  height: 5,
                ),
                forgetPassword(context),
                const SizedBox(
                  height: 30,
                ),
                mybutton(context, "SIGN IN", () async {
                  try {
                    final credential = await FirebaseAuth.instance
                        .signInWithEmailAndPassword(
                            email: _emailcontroller.text,
                            password: _passwordcontroller.text);

                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Wrapper()),
                    );
                  } on FirebaseAuthException catch (e) {
                    String message;
                    switch (e.code) {
                      case 'user-not-found':
                        message = 'No user found for that email.';
                        break;
                      case 'wrong-password':
                        message = 'Wrong password provided for that user.';
                        break;
                      default:
                        message = 'An error occurred. Please try again.';
                    }
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(message)),
                    );
                  }
                }),
                signup(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row signup() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Don't have account? ",
          style: TextStyle(color: Colors.white70),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignupPg()));
          },
          child: const Text(
            "Sign Up",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.red[300]),
          textAlign: TextAlign.right,
        ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const ResetPg()));
        },
      ),
    );
  }
}
