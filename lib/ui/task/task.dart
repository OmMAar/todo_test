import 'package:another_flushbar/flushbar_helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:morphosis_flutter_demo/blocs/task/task_bloc.dart';
import 'package:morphosis_flutter_demo/constants/app_styles.dart';
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
  bool isCompleted = false;

  var _bloc = TaskBloc();

  void init() {
    if (widget.task == null) {
      task = Task();
      _titleController = TextEditingController();
      _descriptionController = TextEditingController();
    } else {
      _titleController = TextEditingController(text: widget.task!.title);
      _descriptionController =
          TextEditingController(text: widget.task!.description);
      isCompleted = widget.task!.isCompleted;
      task = widget.task!;
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

    // var task = Task();
    task!.title = _titleController.text;
    task!.description = _descriptionController.text;
    if (isCompleted)
      task!.completedAt = DateTime.now();
    else
      task!.completedAt = null;
    // task.id = uuid.v4();

    _bloc.add(AddTaskEvent(task: task!));

    //  Navigator.of(context).pop();
  }

  void _edit(BuildContext context) {
    //TODO implement edit to firestore

    task!.title = _titleController.text;
    task!.description = _descriptionController.text;
    if (isCompleted)
      task!.completedAt = DateTime.now();
    else
      task!.completedAt = null;
    // task.id = uuid.v4();

    _bloc.add(EditTaskEvent(task: task!));

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
        title: Text(
          widget.task == null ? 'New Task' : 'Edit Task',
          style: AppStyles.text20Style.copyWith(color: AppColors.whiteColor),
        ),
        brightness: Brightness.dark,
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
              builder: (context, state) {
                return ModalProgressHUD(
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
                              value: isCompleted,
                              onChanged: (value) {
                                setState(() {
                                  task!.toggleComplete();
                                  isCompleted = value;
                                });
                              },
                            ),
                          ],
                        ),
                        Spacer(),
                        ElevatedButton(
                          onPressed: () => widget.task != null
                              ? _edit(context)
                              : _save(context),
                          child: Container(
                            width: double.infinity,
                            child: Center(child: Text('Create')),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
