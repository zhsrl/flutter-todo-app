import 'package:flutter/material.dart';
import 'package:todo_app/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/pages/signin_page.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;

  Future<void> signOut() async {
    if (auth.currentUser?.uid != null) {
      try {
        await auth.signOut();

        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => SignInPage()));
      } catch (e) {
        debugPrint(e.toString());
      }
    } else {
      debugPrint('user null');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.dark,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(auth.currentUser!.uid,
                style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20)),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  signOut();
                });
              },
              child: Text('Log out'),
            )
          ],
        ),
      ),
    );
  }
}
