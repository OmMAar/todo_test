import 'package:another_flushbar/flushbar_helper.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:morphosis_flutter_demo/constants/app_styles.dart';
import 'package:morphosis_flutter_demo/constants/colors.dart';
import 'package:morphosis_flutter_demo/constants/dimens.dart';
import 'package:morphosis_flutter_demo/data/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/data/task_repository.dart';
import 'package:morphosis_flutter_demo/di/components/service_locator.dart';
import 'package:morphosis_flutter_demo/models/task/task.dart';
import 'package:morphosis_flutter_demo/ui/task/task.dart';
import 'package:morphosis_flutter_demo/utils/locale/app_localization.dart';

class TasksPage extends StatelessWidget {
  TasksPage({required this.title, required this.stream});

  final String title;
  final Stream<QuerySnapshot> stream;

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
        title: Text(title,
          style: AppStyles.text20Style.copyWith(color: AppColors.whiteColor),
        ),
        brightness: Brightness.dark,
        actions: [

          Padding(
            padding: const EdgeInsets.all(Dimens.minimum_padding),
            child: CircleAvatar(
              backgroundColor: AppColors.whiteColor,
              radius: 15,
              child: Center(
                child: FittedBox(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    color: AppColors.blackColor,
                    onPressed: () => addTask(context),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
      // body: ListView.builder(
      //   itemBuilder: (context, index) {
      //     return _Task(tasks[index]);
      //   },
      //   itemCount: tasks.length,
      //   shrinkWrap: true,
      // ),
      body: StreamBuilder<QuerySnapshot>(
          stream: stream,
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
          }),
    );
  }
}

class _Task extends StatefulWidget {
  _Task(this.task);

  final Task task;

  @override
  __TaskState createState() => __TaskState();
}

class __TaskState extends State<_Task> {
  bool isCompleted = false;

  void _delete() async{
    //TODO implement delete to firestore
    try {
      final future = await getIt<TaskRepository>().deleteTask(id: widget.task.id!);

      if (future)
        _showSuccessMessage('Success Deleted Task');
      else
        _showErrorMessage('Error Deleted Task');
    } catch (err) {
      print('Caught error: $err');
      _showErrorMessage('Error Deleted Task');
    }
  }

  void _toggleComplete() async {

    widget.task.toggleComplete();
    setState(() {

    });

    try {
      final future = await getIt<TaskRepository>().editTask(task: widget.task);

      if (future)
        _showSuccessMessage('Success Edit Task');
      else
        _showErrorMessage('Error Edit Task');
    } catch (err) {
      print('Caught error: $err');
      _showErrorMessage('Error Edit Task');
    }

  }

  @override
  void initState() {


    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  void _view(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => TaskPage(task: widget.task)),
    );
  }

  _showErrorMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createError(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_error'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  _showSuccessMessage(String message) {
    Future.delayed(Duration(milliseconds: 0), () {
      if (message.isNotEmpty) {
        FlushbarHelper.createSuccess(
          message: message,
          title: AppLocalizations.of(context).translate('home_tv_success'),
          duration: Duration(seconds: 3),
        )..show(context);
      }
    });

    return SizedBox.shrink();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: IconButton(
        icon: Icon(
          widget.task.isCompleted ? Icons.check_box : Icons.check_box_outline_blank,
        ),
        onPressed: _toggleComplete,
      ),
      title: Text(widget.task.title),
      subtitle: Text(widget.task.description),
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
