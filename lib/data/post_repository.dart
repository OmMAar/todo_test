import 'dart:async';

import 'package:morphosis_flutter_demo/data/local/constants/db_constants.dart';
import 'package:morphosis_flutter_demo/data/network/post/post_api.dart';
import 'package:morphosis_flutter_demo/data/sharedpref/shared_preference_helper.dart';
import 'package:morphosis_flutter_demo/models/post/post_list_model.dart';
import 'package:morphosis_flutter_demo/models/post/post_model.dart';
import 'package:sembast/sembast.dart';

import 'local/datasources/post/post_datasource.dart';

class PostRepository {
  // data source object
  final PostDataSource _postDataSource;

  // api objects
  final PostApi _postApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  PostRepository(this._postApi, this._sharedPrefsHelper, this._postDataSource);

  // Post: ---------------------------------------------------------------------
  // Post: ---------------------------------------------------------------------
  Future<PostListModel> getPosts({bool withRefresh = false}) async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use

    if (await _postDataSource.count() != 0 && !withRefresh ) {
      return await _postDataSource.getPostsFromDb();
    } else
      return await _postApi.getPosts().then((postsList) {
        postsList.posts?.forEach((post) {
          _postDataSource.insert(post);
        });

        return postsList;
      }).catchError((error) => throw error);
  }

  Future<List<PostModel>> findPostById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<List<PostModel>> findPostByName(String name) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilterByTitle =
        Filter.matches(DBConstants.FIELD_TITLE, name);
    filters.add(dataLogTypeFilterByTitle);

    //making db call
    return _postDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  Future<int> insert(PostModel post) => _postDataSource
      .insert(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> update(PostModel post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);

  Future<int> delete(PostModel post) => _postDataSource
      .update(post)
      .then((id) => id)
      .catchError((error) => throw error);
}
