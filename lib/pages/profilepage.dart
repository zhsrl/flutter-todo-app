import 'package:firebase_database/firebase_database.dart';
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
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

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
                      showModalBottomSheet(
                          context: context,
                          backgroundColor: AppColor.dark,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          builder: (context) {
                            return Center(
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
                                          final data =
                                              (snapshot.data!).snapshot.value;

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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      StreamBuilder(
                                        stream: emailTempvalfromDB.onValue,
                                        builder: (context, snapshot) {
                                          if (!snapshot.hasData) {
                                            return Text(
                                              'email',
                                              style: TextStyle(
                                                  color:
                                                      AppColor.lowopacitywhite,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fullWidth / 28),
                                            );
                                          } else {
                                            final data =
                                                (snapshot.data!).snapshot.value;

                                            return Text(
                                              data.toString(),
                                              style: TextStyle(
                                                  color:
                                                      AppColor.lowopacitywhite,
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
                                                  color:
                                                      AppColor.lowopacitywhite,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fullWidth / 28),
                                            );
                                          } else {
                                            final data =
                                                (snapshot.data!).snapshot.value;

                                            return Text(
                                              data.toString(),
                                              style: TextStyle(
                                                  color:
                                                      AppColor.lowopacitywhite,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: fullWidth / 28),
                                            );
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            );
                          });
                    },
                    child: Text('Change Data'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
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
