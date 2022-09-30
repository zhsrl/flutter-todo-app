import 'package:flutter/material.dart';
import 'package:todo_app/widgets/taskitem_widget.dart';

import '../consts.dart';

class InProgressWidget extends StatefulWidget {
  InProgressWidget({Key? key}) : super(key: key);

  @override
  State<InProgressWidget> createState() => _InProgressWidgetState();
}

class _InProgressWidgetState extends State<InProgressWidget> {
  @override
  Widget build(BuildContext context) {
    double fullWidth = MediaQuery.of(context).size.width;
    double fullHeight = MediaQuery.of(context).size.height;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Text('Folders',
              style: TextStyle(
                  color: AppColor.white,
                  fontWeight: FontWeight.w600,
                  fontSize: fullWidth * 0.05)),
        ),
        SizedBox(
          height: fullHeight * 0.02,
        ),
        Container(
          height: 150,
          child: ListView(
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            children: [TaskItem(), TaskItem()],
          ),
        ),
      ],
    );
  }
}
