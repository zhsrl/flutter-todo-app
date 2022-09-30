import 'package:flutter/material.dart';
import 'package:todo_app/consts.dart';

class RecyclePage extends StatefulWidget {
  RecyclePage({Key? key}) : super(key: key);

  @override
  State<RecyclePage> createState() => _RecyclePageState();
}

class _RecyclePageState extends State<RecyclePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.dark,
      body: Center(child: Text('Recycle')),
    );
  }
}
