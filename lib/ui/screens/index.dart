import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/data/network/weather/weather_api.dart';
import 'package:morphosis_flutter_demo/data/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/data/repo/firestore_service_manager.dart';
import 'package:morphosis_flutter_demo/di/components/service_locator.dart';
import 'package:morphosis_flutter_demo/ui/home/page/home.dart';
import 'package:morphosis_flutter_demo/ui/screens/tasks.dart';

class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  int _currentIndex = 0;

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      HomePage(),
      TasksPage(
        title: 'All Tasks',
        tasks: getIt<FirebaseManager>().tasks,
      ),
      TasksPage(
        title: 'Completed Tasks',
        tasks:
        getIt<FirebaseManager>().tasks.where((t) => t.isCompleted).toList(),
      )
    ];

    return Scaffold(
      body: children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Tasks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.check),
            label: 'Completed Tasks',
          ),
        ],
      ),
    );
  }
}
