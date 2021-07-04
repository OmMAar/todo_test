import 'package:another_flushbar/flushbar_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:morphosis_flutter_demo/blocs/task/task_bloc.dart';
import 'package:morphosis_flutter_demo/constants/colors.dart';
import 'package:morphosis_flutter_demo/data/repo/firebase_manager.dart';
import 'package:morphosis_flutter_demo/di/components/service_locator.dart';
import 'package:morphosis_flutter_demo/main.dart';
import 'package:morphosis_flutter_demo/models/task/task.dart';
import 'package:morphosis_flutter_demo/utils/locale/app_localization.dart';

class TaskPage extends StatefulWidget {
  TaskPage({this.task});

  final Task? task;

  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {

  static const double _padding = 16;

  Task? task;
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  var _bloc = TaskBloc();
  void init() {
    if (task == null) {
      task = Task();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: task!.title);
      _descriptionController = TextEditingController(text: task!.description);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context) {
    //TODO implement save to firestore

    // getIt<FirebaseManager>().addTask(task!);

    var task = Task();
    task.title = _titleController.text;
    task.description = _descriptionController.text;
    // task.id = uuid.v4();


    _bloc.add(TaskEvent(task: task));

    //  Navigator.of(context).pop();
  }


  // General Methods:-----------------------------------------------------------
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

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.task == null ? 'New Task' : 'Edit Task'),
      ),
      body: SafeArea(
        child: BlocListener<TaskBloc, TaskState>(
          bloc: _bloc,
          listener: (context, state) async {
            if (state is TaskSuccess) {
              // result = state.result;
              Navigator.of(context).pop();
            }
            if (state is TaskFailure) {

              _showErrorMessage(state.errorMessage);
              // final error = state.error;
              // if (error is ConnectionError) {
              //   ErrorViewerGet.showConnectionError(context, state.callback!);
              // } else if (error is CustomError) {
              //   ErrorViewerGet.showCustomError(context, error.message!);
              // } else {
              //   ErrorViewerGet.showUnexpectedError(context);
              // }
            }
          },
          child: BlocBuilder<TaskBloc, TaskState>(
              bloc: _bloc,
              builder: (context, state)  {
                return  ModalProgressHUD(
                  inAsyncCall: state is TaskLoading,
                  color: AppColors.primaryColor,
                  opacity: 0.2,
                  progressIndicator: SpinKitCircle(
                    color: AppColors.primaryColor,
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(_padding),
                    child: Column(
                      children: [
                        TextField(
                          controller: _titleController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Title',
                          ),
                        ),
                        SizedBox(height: _padding),
                        TextField(
                          controller: _descriptionController,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: 'Description',
                          ),
                          minLines: 5,
                          maxLines: 10,
                        ),
                        SizedBox(height: _padding),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Completed ?'),
                            CupertinoSwitch(
                              value: false,
                              onChanged: (_) {
                                setState(() {
                                  task!.toggleComplete();
                                });
                              },
                            ),
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () => _save(context),
                          child: Container(
                            width: double.infinity,
                            child: Center(child: Text('Create')),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
          ),
        ),
      ),
    );
  }
}

class _TaskForm extends StatefulWidget {
  _TaskForm(this.task);

  final Task? task;
  @override
  __TaskFormState createState() => __TaskFormState(task);
}

class __TaskFormState extends State<_TaskForm> {
  static const double _padding = 16;

  __TaskFormState(this.task);

  Task? task;
 late TextEditingController _titleController;
  late TextEditingController _descriptionController;

   var _bloc = TaskBloc();
  void init() {
    if (task == null) {
      task = Task();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: task!.title);
      _descriptionController = TextEditingController(text: task!.description);
    }
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  void _save(BuildContext context) {
    //TODO implement save to firestore

    // getIt<FirebaseManager>().addTask(task!);

    var task = Task();
    task.title = _titleController.text;
    task.description = _descriptionController.text;
    task.id = uuid.v4();


    _bloc.add(TaskEvent(task: task));

  //  Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<TaskBloc, TaskState>(
        listener: (context, state) async {
          if (state is TaskSuccess) {
            // result = state.result;
            Navigator.of(context).pop();
          }
          if (state is TaskFailure) {

            _showErrorMessage(state.errorMessage);
            // final error = state.error;
            // if (error is ConnectionError) {
            //   ErrorViewerGet.showConnectionError(context, state.callback!);
            // } else if (error is CustomError) {
            //   ErrorViewerGet.showCustomError(context, error.message!);
            // } else {
            //   ErrorViewerGet.showUnexpectedError(context);
            // }
          }
        },
        child: BlocBuilder<TaskBloc, TaskState>(
            bloc: _bloc,
            builder: (context, state)  {
            return  ModalProgressHUD(
              inAsyncCall: state is TaskLoading,
              color: AppColors.primaryColor,
              opacity: 0.2,
              progressIndicator: SpinKitCircle(
                color: AppColors.primaryColor,
              ),
              child: Container(
                padding: const EdgeInsets.all(_padding),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Title',
                      ),
                    ),
                    SizedBox(height: _padding),
                    TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Description',
                      ),
                      minLines: 5,
                      maxLines: 10,
                    ),
                    SizedBox(height: _padding),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Completed ?'),
                        CupertinoSwitch(
                          value: task!.isCompleted,
                          onChanged: (_) {
                            setState(() {
                              task!.toggleComplete();
                            });
                          },
                        ),
                      ],
                    ),
                    Spacer(),
                    ElevatedButton(
                      onPressed: () => _save(context),
                      child: Container(
                        width: double.infinity,
                        child: Center(child: Text(task!.isNew ? 'Create' : 'Update')),
                      ),
                    )
                  ],
                ),
              ),
            );
          }
        ),
      ),
    );
  }

  // General Methods:-----------------------------------------------------------
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

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
