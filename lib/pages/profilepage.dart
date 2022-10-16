import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import 'package:provider/provider.dart';
import 'package:todo_app/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/pages/change_profile.dart';
import 'package:todo_app/pages/signin_page.dart';

import 'package:image_picker/image_picker.dart';
import 'package:todo_app/utils/fbstorage_manager.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final auth = FirebaseAuth.instance;
  PlatformFile? pickedFile;
  File? image;

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _workController = TextEditingController();

  DatabaseReference emailTempvalfromDB = FirebaseDatabase.instance
      .ref()
      .child("Users")
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child("email");

  DatabaseReference nameTempvalfromDB = FirebaseDatabase.instance
      .ref()
      .child("Users")
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child("name");

  DatabaseReference workTempvalfromDB = FirebaseDatabase.instance
      .ref()
      .child("Users")
      .child(FirebaseAuth.instance.currentUser!.uid)
      .child("what kind of work do you do");

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
  void initState() {
    super.initState();

    setState(() {
      nameTempvalfromDB.onValue.listen((event) {
        final data = event.snapshot.value;

        _nameController.text = data.toString();
      });

      emailTempvalfromDB.onValue.listen((event) {
        final data = event.snapshot.value;

        _emailController.text = data.toString();
      });

      workTempvalfromDB.onValue.listen((event) {
        final data = event.snapshot.value;

        _workController.text = data.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    String? url;

    final userImage = FirebaseStorage.instance
        .ref()
        .child('user_avatars')
        .child(FirebaseAuth.instance.currentUser!.uid)
        .getDownloadURL();

    debugPrint(userImage.toString());

    setState(() {
      url = userImage.toString();
    });

    return Scaffold(
      backgroundColor: AppColor.dark,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                  future: FirebaseStorageManager().getData(),
                  builder: ((context, snapshot) {
                    if (snapshot.hasError) {
                      return Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: AppColor.green),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.done) {
                      return Container(
                        width: 150,
                        height: 150,
                        clipBehavior: Clip.hardEdge,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        child: Image.network(
                          snapshot.data.toString(),
                          fit: BoxFit.cover,
                        ),
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  })),
              // if (url == null)
              //   Container(
              //     width: 150,
              //     height: 150,
              //     decoration: BoxDecoration(
              //         borderRadius: BorderRadius.circular(100),
              //         color: AppColor.green),
              //   )
              // else
              //   Container(
              //     width: 150,
              //     height: 150,
              //     clipBehavior: Clip.hardEdge,
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(100),
              //     ),
              //     child: Image.network(
              //       url!,
              //       fit: BoxFit.cover,
              //     ),
              //   ),
              SizedBox(
                height: fullHeight * 0.02,
              ),
              StreamBuilder(
                  stream: nameTempvalfromDB.onValue,
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Loading...',
                          style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w700,
                              fontSize: fullWidth / 17));
                    } else {
                      final data = (snapshot.data!).snapshot.value;

                      return Text(data.toString(),
                          style: TextStyle(
                              color: AppColor.white,
                              fontWeight: FontWeight.w700,
                              fontSize: fullWidth / 12));
                    }
                  })),
              SizedBox(
                height: fullHeight * 0.005,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamBuilder(
                    stream: emailTempvalfromDB.onValue,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'email',
                          style: TextStyle(
                              color: AppColor.lowopacitywhite,
                              fontWeight: FontWeight.w500,
                              fontSize: fullWidth / 28),
                        );
                      } else {
                        final data = (snapshot.data!).snapshot.value;

                        return Text(
                          data.toString(),
                          style: TextStyle(
                              color: AppColor.lowopacitywhite,
                              fontWeight: FontWeight.w500,
                              fontSize: fullWidth / 28),
                        );
                      }
                    },
                  ),
                  Text(
                    ' - ',
                    style: TextStyle(
                        color: AppColor.lowopacitywhite,
                        fontWeight: FontWeight.w500,
                        fontSize: fullWidth / 28),
                  ),
                  StreamBuilder(
                    stream: workTempvalfromDB.onValue,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Text(
                          'work',
                          style: TextStyle(
                              color: AppColor.lowopacitywhite,
                              fontWeight: FontWeight.w500,
                              fontSize: fullWidth / 28),
                        );
                      } else {
                        final data = (snapshot.data!).snapshot.value;

                        return Text(
                          data.toString(),
                          style: TextStyle(
                              color: AppColor.lowopacitywhite,
                              fontWeight: FontWeight.w500,
                              fontSize: fullWidth / 28),
                        );
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: fullHeight * 0.02),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showModalBottomSheet(
                          enableDrag: false,
                          isScrollControlled: true,
                          isDismissible: false,
                          context: context,
                          backgroundColor: AppColor.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          builder: (context) {
                            return ChangeProfile();
                          });
                    },
                    child: Text('Change Data'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      signOut();
                    },
                    child: Text('Log out'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
