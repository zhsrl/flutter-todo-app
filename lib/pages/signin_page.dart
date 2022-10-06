import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/consts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:todo_app/pages/signup/emailandpassword.dart';

import '../main.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final firebaseAuth = FirebaseAuth.instance;
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signInFirebase(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TodoScreen()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        debugPrint('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        debugPrint('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.width;
    double fullWidth = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.dark,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Sign in',
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 42.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.15,
                ),
                TextField(
                  controller: _emailController,
                  decoration: Utils().inputDecoration('Email'),
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.05,
                ),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: Utils().inputDecoration('Password'),
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.05,
                ),
                SizedBox(
                  width: fullWidth,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      String userEmail = _emailController.text;
                      String userPassword = _passwordController.text;

                      signInFirebase(userEmail, userPassword);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green),
                    child: Text('Sign in'.toUpperCase(),
                        style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.05,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EmailAndPassword()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Have not account?',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        ' Sign Up.',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
