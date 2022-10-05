import 'package:flutter/material.dart';
import 'package:todo_app/pages/signin_page.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/pages/signup/userdatapage.dart';

import '../../consts.dart';
import '../../utils/user.dart';

class EmailAndPassword extends StatefulWidget {
  EmailAndPassword({Key? key}) : super(key: key);

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  var firebaseAuth = auth.FirebaseAuth.instance;
  var firebaseDB = FirebaseDatabase.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> signUpFirebase(String email, String password) async {
    Map<String, String> user = {
      "name": '',
      "what kind of work do you do": '',
      "email": email
    };

    try {
      await firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      await firebaseDB
          .ref()
          .child("Users")
          .child(firebaseAuth.currentUser!.uid)
          .set(user);

      Utils().showNotification(context, 'TEXT!SUCCESS!');

      Navigator.push(context,
          MaterialPageRoute(builder: ((context) => NameandSurnamePage())));
    } on auth.FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      debugPrint(e.toString());
      final snackbar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColor.dark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Sign up",
                  style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.05,
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
                  height: fullHeight * 0.01,
                ),
                TextField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: Utils().inputDecoration('Password'),
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.03,
                ),
                SizedBox(
                  width: fullWidth,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      var userEmail = _emailController.text;
                      var userPassword = _passwordController.text;

                      signUpFirebase(userEmail, userPassword);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green),
                    child: Text('Continue',
                        style: TextStyle(
                            color: AppColor.dark,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
