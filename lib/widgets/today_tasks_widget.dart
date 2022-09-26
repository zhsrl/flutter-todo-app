import 'package:flutter/material.dart';
import 'package:todo_app/widgets/task_widget.dart';

import '../colors.dart';

class TodayTasksWidget extends StatefulWidget {
  TodayTasksWidget({Key? key}) : super(key: key);

  @override
  State<TodayTasksWidget> createState() => _TodayTasksWidgetState();
}

class _TodayTasksWidgetState extends State<TodayTasksWidget> {
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Today tasks',
                style: TextStyle(
                    color: AppColor.white,
                    fontWeight: FontWeight.w600,
                    fontSize: fullWidth * 0.05),
              ),
              Text(
                'See all',
                style: TextStyle(
                    color: AppColor.lowopacitywhite,
                    fontWeight: FontWeight.w600,
                    fontSize: fullWidth * 0.05),
              ),
            ],
          ),
          TaskWidget(),
          TaskWidget(),
          TaskWidget()
        ],
      ),
    );
  }
}
