import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/consts.dart';
import 'package:todo_app/widgets/inprogress_widget.dart';
import 'package:todo_app/widgets/today_tasks_widget.dart';
import 'package:getwidget/getwidget.dart';

class TodoPage extends StatefulWidget {
  TodoPage({Key? key}) : super(key: key);

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

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
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            child: StreamBuilder(
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

                                    return Text('Hi, ${data.toString()}!',
                                        style: TextStyle(
                                            color: AppColor.white,
                                            fontWeight: FontWeight.w700,
                                            fontSize: fullWidth / 17));
                                  }
                                })),
                          ),
                          SizedBox(
                            height: fullHeight * 0.005,
                          ),
                          StreamBuilder(
                              stream: workTempvalfromDB.onValue,
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Text(
                                    'loading...',
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
                              }),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () => GFToast.showToast(
                          'Notifications',
                          context,
                          toastPosition: GFToastPosition.BOTTOM,
                        ),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.itemColor,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)),
                            fixedSize: Size(50, 50)),
                        child: Icon(Icons.alarm),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.04,
                ),
                SizedBox(width: fullWidth, child: InProgressWidget()),
                SizedBox(
                  height: fullHeight * 0.02,
                ),
                TodayTasksWidget()
              ],
            ),
          ),
        ));
  }
}
