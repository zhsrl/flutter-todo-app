import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

import '../colors.dart';

class TaskWidget extends StatefulWidget {
  TaskWidget({Key? key}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    double fullHeight = MediaQuery.of(context).size.height;
    bool isChecked = true;
    return Column(
      children: [
        SizedBox(
          height: fullHeight * 0.015,
        ),
        Container(
          height: 85,
          decoration: BoxDecoration(
            color: AppColor.itemColor,
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Task title',
                      style: TextStyle(
                          color: AppColor.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: fullHeight * 0.008,
                    ),
                    Text(
                      '02:00 pm',
                      style: TextStyle(
                          color: AppColor.lowopacitywhite,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                GFCheckbox(
                  size: GFSize.MEDIUM,
                  type: GFCheckboxType.circle,
                  activeIcon: Icon(Icons.check),
                  activeBgColor: AppColor.green,
                  onChanged: (value) {
                    setState(() {
                      isChecked = value;
                    });
                  },
                  value: isChecked,
                  inactiveIcon: null,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
