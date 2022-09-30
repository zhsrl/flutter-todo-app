import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/utils/user.dart';

import '../consts.dart';

final _nameController = TextEditingController();
final _surnameController = TextEditingController();
final _emailController = TextEditingController();
final _passwordController = TextEditingController();

bool isSuccessful = false;

class SignUpPage extends StatefulWidget {
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
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
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: isSuccessful
                    ? NameAndSurnameWidget()
                    : EmailAndPasswordWidget(),
              )),
        ),
      ),
    );
  }
}

class EmailAndPasswordWidget extends StatefulWidget {
  EmailAndPasswordWidget({Key? key}) : super(key: key);

  @override
  State<EmailAndPasswordWidget> createState() => _EmailAndPasswordWidgetState();
}

class _EmailAndPasswordWidgetState extends State<EmailAndPasswordWidget> {
  var firebaseAuth = auth.FirebaseAuth.instance;
  var firebaseDB = FirebaseDatabase.instance;

  Future<void> signUpFirebase(String email, String password) async {
    try {
      auth.UserCredential credential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      isSuccessful = true;

      final snackbar = SnackBar(
        content: Text('Sign Up Success!'),
      );
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      setState(() {
        isSuccessful = isSuccessful;
      });

      // ignore: use_build_context_synchronously

    } on auth.FirebaseAuthException catch (e) {
      isSuccessful = false;
      if (e.code == 'weak-password') {
        debugPrint('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        debugPrint('The account already exists for that email.');
      }
    } catch (e) {
      isSuccessful = false;
      debugPrint(e.toString());
      final snackbar = SnackBar(
        content: Text(e.toString()),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.width;
    double fullWidth = MediaQuery.of(context).size.height;

    return Column(
      key: Key('1'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Sign up',
          style: TextStyle(
            color: AppColor.white,
            fontSize: 42.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: fullHeight * 0.15,
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
          height: fullHeight * 0.05,
        ),
        TextField(
          controller: _passwordController,
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
              var email = _emailController.text;
              var password = _passwordController.text;

              signUpFirebase(email, password);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
            child: Text('Continue'.toUpperCase(),
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
            Navigator.pop(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Have a account?',
                style: TextStyle(
                  color: AppColor.white,
                  fontSize: 16,
                ),
              ),
              Text(
                ' Sign In.',
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
    );
  }
}

class NameAndSurnameWidget extends StatefulWidget {
  NameAndSurnameWidget({Key? key}) : super(key: key);

  @override
  State<NameAndSurnameWidget> createState() => _NameAndSurnameWidgetState();
}

class _NameAndSurnameWidgetState extends State<NameAndSurnameWidget> {
  var firebaseAuth = auth.FirebaseAuth.instance;
  var firebaseDB = FirebaseDatabase.instance;

  void addNameandSurnameFirebase(
      String userName, String userSurname, String userEmail) {
    final user = User(userName, userSurname, userEmail);

    try {
      firebaseDB.ref('users').child(firebaseAuth.currentUser!.uid).set(user);

      if (isSuccessful == true) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TodoScreen()),
        );
      } else {
        debugPrint('sign up: error');
      }
    } catch (e) {
      final snackbar = SnackBar(
        content: Text(e.toString()),
      );

      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.width;
    double fullWidth = MediaQuery.of(context).size.height;

    return Column(
      key: Key('2'),
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          'Sign up',
          style: TextStyle(
            color: AppColor.white,
            fontSize: 42.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: fullHeight * 0.15,
        ),
        SizedBox(
          height: fullHeight * 0.05,
        ),
        TextField(
          controller: _nameController,
          decoration: Utils().inputDecoration('Name'),
          style: TextStyle(
            color: AppColor.white,
            fontSize: 18,
          ),
        ),
        SizedBox(
          height: fullHeight * 0.05,
        ),
        TextField(
          controller: _surnameController,
          decoration: Utils().inputDecoration('Surname'),
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
              var name = _nameController.text;
              var surname = _surnameController.text;
              var email = _emailController.text;

              addNameandSurnameFirebase(name, surname, email);
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColor.green),
            child: Text('Sign up'.toUpperCase(),
                style: TextStyle(
                    color: AppColor.dark,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }
}
