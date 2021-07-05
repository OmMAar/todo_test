import 'dart:async';
import 'dart:convert';

import 'package:morphosis_flutter_demo/data/network/constants/endpoints.dart';
import 'package:morphosis_flutter_demo/data/network/dio_client.dart';
import 'package:morphosis_flutter_demo/data/network/rest_client.dart';
import 'package:morphosis_flutter_demo/models/post/post_list_model.dart';
import 'package:morphosis_flutter_demo/models/post/post_model.dart';

class PostApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  PostApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<PostListModel> getPosts() async {
    try {
      final res = await _dioClient.get(Endpoints.getPosts);
      return PostListModel.fromJson(res);
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }


}
