import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_project/widgets/mybutton.dart';
import 'package:tmdb_project/widgets/mytextfield.dart';

class ResetPg extends StatefulWidget {
  const ResetPg({super.key});

  @override
  State<ResetPg> createState() => _ResetPgState();
}

class _ResetPgState extends State<ResetPg> {
  final TextEditingController _emailcontrollerrs = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Reset Password",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.grey, Colors.black],
        )),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                mytextfield("Enter e-mail address", Icons.mail_outline, false,
                    _emailcontrollerrs),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "Press RESET PASSWORD to receive reset link to provided e-mail address",
                  style: TextStyle(fontSize: 15, color: Colors.white54),
                ),
                mybutton(context, "RESET PASSWORD", () {
                  handleResetPassword(context, _emailcontrollerrs.text);
                })
              ],
            ),
          ),
        ),
      ),
    );
  }

  void handleResetPassword(BuildContext context, String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Reset Link Sent"),
            content: const Text(
                "A reset link has been sent to your email. Please check your email and sign in with your new password."),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                  Navigator.of(context).pop(); // Go back to the previous screen
                },
                child: const Text("OK"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    }
  }
}
