import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:morphosis_flutter_demo/data/post_repository.dart';
import 'package:morphosis_flutter_demo/di/components/service_locator.dart';
import 'package:morphosis_flutter_demo/models/post/post_model.dart';
import 'package:morphosis_flutter_demo/utils/dio/dio_error_util.dart';


abstract class PostState extends Equatable {}

class PostUninitialized extends PostState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'PostUninitialized';
}

class PostLoading extends PostState {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'PostLoading';
}

class PostSuccess extends PostState {
 final List<PostModel> result;

   PostSuccess({required this.result});
  @override
  List<Object> get props => [result];

  @override
  String toString() => 'PostSuccess data length :${result.length}';
}

class PostFailure extends PostState {
  final String errorMessage;
  final VoidCallback? callback;

  PostFailure({
    required this.errorMessage,
    this.callback,
  });

  @override
  List<Object> get props => [errorMessage, callback!];

  @override
  String toString() => 'PostFailure { error: $errorMessage }';
}

abstract class PostEvent extends Equatable {}

class GetPostEvent extends PostEvent {
  final bool withRefresh;
  GetPostEvent({this.withRefresh = false});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'GetPostEvent with refresh $withRefresh';
}


class PostSearchEvent extends PostEvent {

  final String text;
  PostSearchEvent({required this.text});

  @override
  List<Object> get props => [];

  @override
  String toString() => 'PostSearchEvent text :$text';
}

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostUninitialized());



  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {


    // repository instance
    PostRepository _repository = getIt<PostRepository>();


    /// fetch all post
    if(event is GetPostEvent){
      yield PostLoading();


      try {
        final future = await _repository.getPosts(withRefresh:event.withRefresh);

        yield PostSuccess(result: future.posts!);
      } catch (err) {
        print('Caught error: $err');
        if(err is DioError)
          yield PostFailure(
            errorMessage: DioErrorUtil.handleError(err),
            callback: () {
              this.add(event);
            },
          );
        else
          yield PostFailure(
            errorMessage: err.toString(),
            callback: () {
              this.add(event);
            },
          );

      }
    }

    if(event is PostSearchEvent){
      yield PostLoading();

      try {
        final future = await _repository.findPostByName(event.text);

        yield PostSuccess(result: future);
      } catch (err) {
        print('Caught error: $err');
        if(err is DioError)
          yield PostFailure(
            errorMessage: DioErrorUtil.handleError(err),
            callback: () {
              this.add(event);
            },
          );
        else
          yield PostFailure(
            errorMessage: err.toString(),
            callback: () {
              this.add(event);
            },
          );

      }
    }

  }
}
