import 'package:flutter/material.dart';
import 'package:todo_app/consts.dart';
import 'package:getwidget/getwidget.dart';
import 'package:todo_app/pages/signup_page.dart';

class SignInPage extends StatefulWidget {
  SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
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
                    onPressed: () {},
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SignUpPage()));
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
