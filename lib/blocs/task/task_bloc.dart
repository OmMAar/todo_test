import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:morphosis_flutter_demo/data/task_repository.dart';
import 'package:morphosis_flutter_demo/di/components/service_locator.dart';
import 'package:morphosis_flutter_demo/models/task/task.dart';


abstract class TaskState extends Equatable {}

class TaskUninitialized extends TaskState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'TaskUninitialized';
}

class TaskLoading extends TaskState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'TaskLoading';
}

class TaskSuccess extends TaskState {

  @override
  List<Object> get props => [];

  @override
  String toString() => 'TaskSuccess';
}

class TaskFailure extends TaskState {
  final String errorMessage;
  final VoidCallback? callback;

  TaskFailure({
    required this.errorMessage,
    this.callback,
  });

  @override
  List<Object> get props => [errorMessage, callback!];

  @override
  String toString() => 'TaskFailure { error: $errorMessage }';
}

abstract class TaskEvent extends Equatable {}

class AddTaskEvent extends TaskEvent {

  final Task task;

  AddTaskEvent({required this.task});

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'TaskEvent task ${task.toJson()}';
}
class EditTaskEvent extends TaskEvent {

  final Task task;

  EditTaskEvent({required this.task});

  @override
  List<Object> get props => [task];

  @override
  String toString() => 'EditTaskEvent task ${task.toJson()}';
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskUninitialized());



  @override
  Stream<TaskState> mapEventToState(TaskEvent event) async* {
    // repository instance
    TaskRepository _repository = getIt<TaskRepository>();


    if(event is AddTaskEvent){
      yield TaskLoading();


      try {
        final future = await _repository.addTask(
            task: event.task
        );

        if(future)
          yield TaskSuccess();
        else
          yield TaskFailure(
            errorMessage: 'Error insert Task',
            callback: () {
              this.add(event);
            },
          );
      } catch (err) {
        print('Caught error: $err');
        yield TaskFailure(
          errorMessage: err.toString(),
          callback: () {
            this.add(event);
          },
        );
      }
    }

    if(event is EditTaskEvent){
      yield TaskLoading();


      try {
        final future = await _repository.editTask(
            task: event.task
        );

        if(future)
          yield TaskSuccess();
        else
          yield TaskFailure(
            errorMessage: 'Error Edit Task',
            callback: () {
              this.add(event);
            },
          );
      } catch (err) {
        print('Caught error: $err');
        yield TaskFailure(
          errorMessage: err.toString(),
          callback: () {
            this.add(event);
          },
        );
      }
    }

    }

}
