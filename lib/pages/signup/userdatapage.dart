import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/consts.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;

import '../../main.dart';
import '../../utils/user.dart';

class NameandSurnamePage extends StatefulWidget {
  NameandSurnamePage({Key? key}) : super(key: key);

  @override
  State<NameandSurnamePage> createState() => _NameandSurnamePageState();
}

class _NameandSurnamePageState extends State<NameandSurnamePage> {
  final _nameController = TextEditingController();
  final _workController = TextEditingController();

  var firebaseAuth = auth.FirebaseAuth.instance;
  var firebaseDB = FirebaseDatabase.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future<void> addDataFBDB(
    String userName,
    String userWork,
  ) async {
    Map<String, String> user = {
      "name": userName,
      "what kind of work do you do": userWork
    };

    try {
      await firebaseDB
          .ref("Users")
          .child(firebaseAuth.currentUser!.uid)
          .update(user);

      final snackbar = SnackBar(
        content: Text('DB Success!'),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);

      // ignore: use_build_context_synchronously

    } catch (e) {
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
                  "Tell us about yourself",
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
                  controller: _nameController,
                  decoration: Utils().inputDecoration('Name'),
                  style: TextStyle(
                    color: AppColor.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.01,
                ),
                TextField(
                  controller: _workController,
                  decoration:
                      Utils().inputDecoration('What kind of work do you do?'),
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
                      var name = _nameController.text;
                      var work = _workController.text;

                      addDataFBDB(name, work);
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green),
                    child: Text('Create account',
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
