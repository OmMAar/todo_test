import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/constants/colors.dart';
import 'package:morphosis_flutter_demo/data/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/di/components/service_locator.dart';
import 'package:morphosis_flutter_demo/models/task/task.dart';
import 'package:morphosis_flutter_demo/ui/task/task.dart';

class TasksPage extends StatelessWidget {
  TasksPage({required this.title, required this.tasks});

  final String title;
  final List<Task> tasks;

  void addTask(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: [
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () => addTask(context),
            )
          ],
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream: getIt<FirebaseManager>().readItems(),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (!snapshot.hasData) {
                return new Text("There is no expense");
              }
              if (snapshot.hasData || snapshot.data != null) {
                return new ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var info = snapshot.data!.docs[index].data()! as Map;
                    Task task = Task();
                    task.id = info['title'];
                    task.title = info['title'];
                    task.description = info['description'];
                    task.completedAt = info['completedAt'];
                    return _Task(task);
                  },
                );
              }

              return Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppColors.primaryColor,
                  ),
                ),
              );
            }));
  }
}

class _Task extends StatelessWidget {
  _Task(this.task);

  final Task task;

  void _delete() {
    //TODO implement delete to firestore
  }

  void _toggleComplete() {
    //TODO implement toggle complete to firestore
  }

  void _view(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage(task: task)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        onPressed: _toggleComplete,
      ),
      title: Text(task.title),
      subtitle: Text(task.description),
      trailing: IconButton(
        icon: Icon(
          Icons.delete,
        ),
        onPressed: _delete,
      ),
      onTap: () => _view(context),
    );
  }
}
