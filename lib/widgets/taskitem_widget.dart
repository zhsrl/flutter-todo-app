import 'package:flutter/material.dart';
import 'package:todo_app/colors.dart';
import 'package:getwidget/getwidget.dart';

// ignore: must_be_immutable
class TaskItem extends StatefulWidget {
  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return Row(
      children: [
        SizedBox(
          width: fullWidth * 0.05,
        ),
        Container(
          width: 230,
          decoration: BoxDecoration(
              gradient: AppColor.priorityItemColor1,
              borderRadius: BorderRadius.circular(15.0)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Visual',
                        style: TextStyle(
                          color: AppColor.white,
                          fontSize: fullWidth * 0.06,
                          fontWeight: FontWeight.bold,
                        )),
                    Row(
                      children: [
                        Opacity(
                          opacity: 0.3,
                          child: Icon(
                            Icons.timer,
                            color: AppColor.white,
                          ),
                        ),
                        SizedBox(
                          width: fullWidth * 0.02,
                        ),
                        Text(
                          '3h',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: AppColor.white,
                              fontSize: fullWidth * 0.05),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: fullHeight * 0.01,
                ),
                Container(
                  width: 35,
                  height: 35,
                  decoration: BoxDecoration(
                      color: AppColor.green,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColor.white,
                        width: 1.0,
                        style: BorderStyle.solid,
                      )),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      'assets/images/memoji_woman.png',
                    ),
                  ),
                ),
                SizedBox(
                  height: fullHeight * 0.02,
                ),
                GFProgressBar(
                  percentage: 0.73,
                  backgroundColor: AppColor.lowopacitywhite,
                  progressBarColor: AppColor.green,
                  lineHeight: 15,
                  child: Center(
                      child: Text('73%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ))),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
