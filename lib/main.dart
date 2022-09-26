import 'package:flutter/material.dart';
import 'package:todo_app/colors.dart';
import 'package:todo_app/pages/calendarpage.dart';
import 'package:todo_app/pages/profilepage.dart';
import 'package:todo_app/pages/recyclepage.dart';
import 'package:todo_app/pages/todopage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        backgroundColor: AppColor.dark,
        fontFamily: 'Gilroy',
      ),
      home: TodoScreen(),
    );
  }
}

class TodoScreen extends StatefulWidget {
  TodoScreen({Key? key}) : super(key: key);

  @override
  State<TodoScreen> createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  int currentTab = 0;
  final List<Widget> pages = [
    TodoPage(),
    CalendarPage(),
    RecyclePage(),
    ProfilePage()
  ];

  final pageStorageBucket = PageStorageBucket();
  Widget currentScreen = TodoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageStorage(
        child: currentScreen,
        bucket: pageStorageBucket,
      ),
      backgroundColor: AppColor.dark,
      bottomNavigationBar: BottomAppBar(
          color: AppColor.dark,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                icon: Icon(
                  Icons.home_filled,
                  color: currentTab == 0
                      ? AppColor.white
                      : AppColor.lowopacitywhite,
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 0;
                    currentScreen = TodoPage();
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.calendar_month,
                  color: currentTab == 1
                      ? AppColor.white
                      : AppColor.lowopacitywhite,
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 1;
                    currentScreen = CalendarPage();
                  });
                },
              ),
              FloatingActionButton(
                onPressed: () {},
                child: Icon(Icons.add),
              ),
              IconButton(
                icon: Icon(
                  Icons.add_box,
                  color: currentTab == 2
                      ? AppColor.white
                      : AppColor.lowopacitywhite,
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 2;
                    currentScreen = RecyclePage();
                  });
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.person,
                  color: currentTab == 3
                      ? AppColor.white
                      : AppColor.lowopacitywhite,
                ),
                onPressed: () {
                  setState(() {
                    currentTab = 3;
                    currentScreen = ProfilePage();
                  });
                },
              ),
            ],
          )),
    );
  }
}
