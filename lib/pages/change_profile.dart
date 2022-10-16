import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:todo_app/utils/fbstorage_manager.dart';

import '../consts.dart';
import 'dart:io';

class ChangeProfile extends StatefulWidget {
  ChangeProfile({Key? key}) : super(key: key);

  @override
  State<ChangeProfile> createState() => _ChangeProfileState();
}

class _ChangeProfileState extends State<ChangeProfile> {
  File? image;

  final auth = FirebaseAuth.instance;

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

  Future selectImage() async {
    try {
      final image = await ImagePicker()
          .pickImage(
              source: ImageSource.gallery,
              maxHeight: 640,
              maxWidth: 480,
              imageQuality: 90)
          .whenComplete(() {
        setState(() {});
      });

      debugPrint(image!.path);

      if (image == null) return;

      final imagePath = File(image.path);

      setState(() {
        this.image = imagePath;
        // Navigator.of(context).pop();
      });
    } on PlatformException catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _updateData(String name, String email, String work,
      String filePath, String fileName) async {
    final user = FirebaseAuth.instance.currentUser;
    final firebaseDB = FirebaseDatabase.instance;
    final firebaseStorage = FirebaseStorage.instance;

    File file = File(filePath);

    Map<String, String> updatedUser = {
      "name": name,
      "email": email,
      "what kind of work do you do": work
    };

    try {
      await firebaseDB
          .ref()
          .child("Users")
          .child(user!.uid)
          .update(updatedUser);

      await user.updateEmail(email);

      await firebaseStorage.ref('user_avatars/$fileName').putFile(file);

      final snackbar = SnackBar(
        content: Text('Update Success!'),
      );

      Navigator.pop(context);

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } on FirebaseException catch (e) {
      debugPrint(e.toString());

      final snackbar = SnackBar(
        content: Text(e.toString()),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    } catch (e) {
      debugPrint(e.toString());

      final snackbar = SnackBar(
        content: Text(e.toString()),
      );

      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
    double fullHeight = MediaQuery.of(context).size.height;
    double fullWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColor.dark,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 60, horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.max,
              children: [
                Column(
                  children: [
                    FutureBuilder(
                        future: FirebaseStorageManager().getData(),
                        builder: ((context, snapshot) {
                          if (snapshot.hasError) {
                            return Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: AppColor.itemColor,
                              ),
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            return Container(
                              width: 120,
                              height: 120,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100)),
                              child: Image.network(snapshot.data.toString(),
                                  fit: BoxFit.cover),
                            );
                          }

                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        })),
                    SizedBox(
                      height: fullHeight * 0.02,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        selectImage();
                      },
                      child: Text('Change avatar'),
                    ),
                    SizedBox(
                      height: fullHeight * 0.04,
                    ),
                    StreamBuilder(
                        stream: nameTempvalfromDB.onValue,
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return TextFormField(
                              decoration: Utils().inputDecoration('noname'),
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 18,
                              ),
                            );
                          } else {
                            final data = (snapshot.data!).snapshot.value;

                            return TextField(
                              controller: _nameController,
                              decoration: Utils().inputDecorationWithLabel(
                                  data.toString().trim(), 'Name'),
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 18,
                              ),
                            );
                          }
                        })),
                    SizedBox(
                      height: fullHeight * 0.02,
                    ),
                    StreamBuilder(
                        stream: emailTempvalfromDB.onValue,
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return TextField(
                              decoration: Utils().inputDecoration('noname'),
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 18,
                              ),
                            );
                          } else {
                            final data = (snapshot.data!).snapshot.value;

                            return TextField(
                              controller: _emailController,
                              decoration: Utils().inputDecorationWithLabel(
                                  data.toString().trim(), 'Email'),
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 18,
                              ),
                            );
                          }
                        })),
                    SizedBox(
                      height: fullHeight * 0.02,
                    ),
                    StreamBuilder(
                        stream: workTempvalfromDB.onValue,
                        builder: ((context, snapshot) {
                          if (!snapshot.hasData) {
                            return TextField(
                              decoration: Utils().inputDecoration('noname'),
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 18,
                              ),
                            );
                          } else {
                            final data = (snapshot.data!).snapshot.value;

                            return TextField(
                              controller: _workController,
                              decoration: Utils().inputDecorationWithLabel(
                                  data.toString().trim(),
                                  'What kind of work do you do?'),
                              style: TextStyle(
                                color: AppColor.white,
                                fontSize: 18,
                              ),
                            );
                          }
                        })),
                  ],
                ),
                SizedBox(
                  width: fullWidth,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      String updatedName = _nameController.text;
                      String updatedEmail = _emailController.text;
                      String updatedWork = _workController.text;
                      String filePath = image!.path;

                      _updateData(updatedName, updatedEmail, updatedWork,
                          filePath, auth.currentUser!.uid);
                    },
                    onLongPress: () {
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.green),
                    child: Text('Update',
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
