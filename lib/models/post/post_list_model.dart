import 'package:morphosis_flutter_demo/models/post/post_model.dart';
class PostListModel {
  final List<PostModel>? posts;

  PostListModel({
    this.posts,
  });

  factory PostListModel.fromJson(List<dynamic> json) {
    List<PostModel> posts = <PostModel>[];
    posts = json.map((post) => PostModel.fromJson(post)).toList();

    return PostListModel(
      posts: posts,
    );
  }
}
