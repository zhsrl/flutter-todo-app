import 'package:flutter/material.dart';

import '../consts.dart';

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
            child: Column(
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
            ),
          ),
        ),
      ),
    );
  }
}
