import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:todo_app/consts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_app/images.dart';
import 'package:todo_app/pages/signin_page.dart';

import '../single_notifier.dart';

class ProfilePage extends StatefulWidget {
  ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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

  Future<void> _updateData(String name, String email, String work) async {
    final user = FirebaseAuth.instance.currentUser;
    final firebaseDB = FirebaseDatabase.instance;

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

      final snackbar = SnackBar(
        content: Text('Update Success!'),
      );

      Navigator.pop(context);

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

    debugPrint(maleImages[1].toString());

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

    return Scaffold(
      backgroundColor: AppColor.dark,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircleAvatar(
                radius: 70,
                backgroundColor: AppColor.green,
              ),
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
                      // Change User Data Bottom Sheet
                      showModalBottomSheet(
                          isScrollControlled: true,
                          context: context,
                          backgroundColor: AppColor.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          builder: (context) {
                            return Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 60, horizontal: 24),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Column(
                                      children: [
                                        CircleAvatar(
                                          radius: 70,
                                          backgroundColor: AppColor.green,
                                        ),
                                        SizedBox(
                                          height: fullHeight * 0.02,
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            var selectedImage;

                                            showModalBottomSheet(
                                                backgroundColor: AppColor.dark,
                                                context: context,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                                builder: (context) {
                                                  return Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 32.0,
                                                        horizontal: 24.0),
                                                    child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      children: [
                                                        Text('Avatar',
                                                            style: TextStyle(
                                                              color: AppColor
                                                                  .white,
                                                              fontSize: 32,
                                                            )),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: SizedBox(
                                                                height: 100,
                                                                width: 300,
                                                                child: ListView
                                                                    .separated(
                                                                        itemCount:
                                                                            maleImages
                                                                                .length,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        separatorBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return SizedBox(
                                                                              width: 20);
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return GestureDetector(
                                                                              child: Stack(
                                                                            alignment:
                                                                                AlignmentDirectional.bottomCenter,
                                                                            children: [
                                                                              CircleAvatar(radius: 40, backgroundImage: AssetImage(maleImages[index])),
                                                                              Radio(
                                                                                value: maleImages[index],
                                                                                groupValue: selectedImage,
                                                                                onChanged: (value) {
                                                                                  selectedImage = value;
                                                                                  setState(() {});
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ));
                                                                        }),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: SizedBox(
                                                                height: 100,
                                                                child: ListView
                                                                    .separated(
                                                                        itemCount:
                                                                            femaleImages
                                                                                .length,
                                                                        scrollDirection:
                                                                            Axis
                                                                                .horizontal,
                                                                        separatorBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return SizedBox(
                                                                              width: 20);
                                                                        },
                                                                        itemBuilder:
                                                                            (context,
                                                                                index) {
                                                                          return GestureDetector(
                                                                              child: Stack(
                                                                            alignment:
                                                                                AlignmentDirectional.bottomCenter,
                                                                            children: [
                                                                              CircleAvatar(
                                                                                  radius: 40,
                                                                                  backgroundImage: AssetImage(
                                                                                    femaleImages[index],
                                                                                  )),
                                                                              Radio(
                                                                                value: femaleImages[index],
                                                                                groupValue: selectedImage,
                                                                                onChanged: (value) {
                                                                                  selectedImage = value;
                                                                                  setState(() {});
                                                                                },
                                                                              ),
                                                                            ],
                                                                          ));
                                                                        }),
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                        SizedBox(
                                                          height:
                                                              fullHeight * 0.05,
                                                        ),
                                                        SizedBox(
                                                          width: fullWidth,
                                                          height: 55,
                                                          child: ElevatedButton(
                                                            onPressed: () {},
                                                            style: ElevatedButton
                                                                .styleFrom(
                                                                    backgroundColor:
                                                                        AppColor
                                                                            .green),
                                                            child: Text(
                                                                'Select',
                                                                style: TextStyle(
                                                                    color:
                                                                        AppColor
                                                                            .dark,
                                                                    fontSize:
                                                                        18,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  );
                                                });
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
                                                  decoration: Utils()
                                                      .inputDecoration(
                                                          'noname'),
                                                  style: TextStyle(
                                                    color: AppColor.white,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              } else {
                                                final data = (snapshot.data!)
                                                    .snapshot
                                                    .value;

                                                return TextField(
                                                  controller: _nameController,
                                                  decoration: Utils()
                                                      .inputDecorationWithLabel(
                                                          data
                                                              .toString()
                                                              .trim(),
                                                          'Name'),
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
                                                  decoration: Utils()
                                                      .inputDecoration(
                                                          'noname'),
                                                  style: TextStyle(
                                                    color: AppColor.white,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              } else {
                                                final data = (snapshot.data!)
                                                    .snapshot
                                                    .value;

                                                return TextField(
                                                  controller: _emailController,
                                                  decoration: Utils()
                                                      .inputDecorationWithLabel(
                                                          data
                                                              .toString()
                                                              .trim(),
                                                          'Email'),
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
                                                  decoration: Utils()
                                                      .inputDecoration(
                                                          'noname'),
                                                  style: TextStyle(
                                                    color: AppColor.white,
                                                    fontSize: 18,
                                                  ),
                                                );
                                              } else {
                                                final data = (snapshot.data!)
                                                    .snapshot
                                                    .value;

                                                return TextField(
                                                  controller: _workController,
                                                  decoration: Utils()
                                                      .inputDecorationWithLabel(
                                                          data
                                                              .toString()
                                                              .trim(),
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
                                          String updatedName =
                                              _nameController.text;
                                          String updatedEmail =
                                              _emailController.text;
                                          String updatedWork =
                                              _workController.text;

                                          _updateData(updatedName, updatedEmail,
                                              updatedWork);
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
                            );
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
